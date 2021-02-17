<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class UpController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('Orders')
            ->andWhere("status = 'loading'")
            ->orWhere("status = 'doing'")
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $this->view->orders = $paginator;
    }
    public function editAction($id=null){
        if($id){
            $order = \Orders::findFirst([
                "conditions"=>"id =".$id." and status in ('doing','loading','part_loading')"
            ]);
            $this->view->order = $order->toDetailArray();
            $this->view->breadcrumb = [
                array(
                    'name'=>'上架单',
                    'url'=>'up'
                ),
                array(
                    'name'=>$order->id
                )
            ];
        }
    }
    public function do_upAction($id=null){
        if($id){
            $doingTime = $this->request->getPost('doing_time');
            if(!$doingTime){
                return $this->error('没有上架时间');
            }
            $this->begin();
            $order = \Orders::findFirst($id);
            if(!$order){
                $this->end(false);
                return $this->error('没有该订单');
            }
            $order->loading_time = $doingTime;
            $order->status = 'doing';
            if($order->save()){
                $this->end(true);
                return $this->success('成功');
            }else{
                $msg = '';
                foreach ($order->getMessages() as $message) {
                    $msg .= $message;
                }
                return $this->error($msg);
            }
        }
    }
    public function get_ip_listAction($type='',$idc = null,$customerId = null,$orderItemId = 0){
        if(!$orderItemId){
            return $this->error('错误的订单项');
        }
        $canUseIp = [];
        $usedIp = [];
        if($idc){
            $ipIdc = \IpIdc::find([
                'conditions'=>"idc_id = ".$idc
            ]);
            foreach($ipIdc as $item){
                if($item->ipPool->type == $type && $item->can_use_ip){
                    $canUseIp[] = $item->can_use_ip->toArray(['id','ip']);
                }
                if($customerId){
                    if($item->ipPool->customer_id == $customerId && $item->ipPool->type == $type && $item->ipPool->order_item_id == $orderItemId){
                        $usedIp[] = $item->ipPool->toArray(['id','ip']);
                    }
                }
            }
        }
        return $this ->response ->setJsonContent([
            'used_ip'=>$usedIp,
            'can_use_ip'=>$canUseIp
        ]);
    }
    public function get_cabinet_listAction($idc = null,$ampere = null){
        $cabinet = [];
        if($idc && $ampere){
            $idcCabinetStock = \IdcCabinetStock::find([
                'conditions'=>"idc_id = ".$idc." and ampere ='".$ampere."'"
            ]);
            $cabinet = $idcCabinetStock->toArray();
        }
        return $this ->response ->setJsonContent($cabinet) ;
    }
    public function get_cabinet_seatAction($idc = null,$seat = null){
        $cabinet = [];
        $ampere = explode('_',$seat)[0];
        if($idc && $ampere){
            $idcCabinetStock = \IdcCabinetStock::find([
                'conditions'=>"idc_id = ".$idc." and ampere ='".$ampere."'"
            ]);
            $cabinet = $idcCabinetStock->toArray();
        }
        return $this ->response ->setJsonContent($cabinet) ;
    }
    public function save_productAction($customerId = 0,$orderItemId = null){
        if(!$orderItemId){
            return $this->error('参数错误');
        }
        $this->begin();
        $orderItem = \OrderItem::findFirst($orderItemId);
        $orderItem->final_num = $orderItem->num;
        if(!$orderItem->save()){
            $this->end(false);
            return $this->success('超卖');
        }
        $this->end(true);
        return $this->success('保存成功');
    }
    public function save_ipAction($customerId = 0,$orderItemId = null){
        if(!$orderItemId){
            return $this->error('参数错误');
        }
        $deleteIp = $this->request->getPost('delete_ip');
        $newIp = $this->request->getPost('new_ip');
        $this->begin();
        if($deleteIp && !empty($deleteIp)){
            foreach($deleteIp as $did=>$ip){
                $ip = \IpPool::findFirst($did);
                if($ip){
                    $ip->customer_id = 0;
                    $ip->order_item_id = 0;
                    if(!$ip->save()){
                        $this->end(false);
                        return $this->error('删除已有IP失败');
                    }
                }
            }
        }
        if($newIp && !empty($newIp)){
            foreach($newIp as $nid=>$ip){
                $ip = \IpPool::findFirst($nid);
                if($ip){
                    $ip->customer_id = $customerId;
                    $ip->order_item_id = $orderItemId;
                    if(!$ip->save()){
                        $this->end(false);
                        return $this->error('分配IP失败');
                    }
                }
            }
        }
        $orderItem = \OrderItem::findFirst($orderItemId);
        if($orderItem->status != 'finish'){
            $orderItem->final_num = $orderItem->final_num + count($newIp);
        }else{
            $orderItem->final_num = $orderItem->final_num + count($deleteIp) - count($newIp);
        }
        if(!$orderItem->save()){
            $this->end(false);
            return $this->error('超卖');
        }
        $this->end(true);
        return $this->success('保存成功');
    }
    public function save_cabinetAction($customerId = null,$orderItemId = null){
        if(!$customerId || !$orderItemId){
            return $this->error('参数错误');
        }
        $cabinets = $this->request->getPost('cabinets');
        $this->begin();
        $orderItem = \OrderItem::findFirst($orderItemId);
        $orderItem->final_num = $orderItem->final_num + count($cabinets);
        if(!$orderItem->save()){
            $this->end(false);
            return $this->error('超卖');
        }
        foreach($cabinets as $item){
            $cabinet = \IdcCabinetStock::findFirst($item['id']);
            $cabinet->customer_id = $customerId;
            $cabinet->used = 'true';
            $cabinet->name = $item['name'];
            $cabinet->used_seat_num = $cabinet->seat_num;
            if(!$cabinet->save()){
                $this->end(false);
                return $this->success('保存失败');
            }
        }
        $this->end(true);
        return $this->success('保存成功');
    }
}
