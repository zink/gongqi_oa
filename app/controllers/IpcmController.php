<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class IpcmController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('IpPool')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $ip = $paginator->getPaginate();
        $customer = [];
        foreach($ip->items as $key=>$item){
            if($item->customer_id){
                $customer[$item->id] = \Customer::findFirst($item->customer_id)->subject;
            }
        }
        $this->view->ip = $ip;
        $this->view->customer = $customer;
    }
    public function unbindAction($id){
        if(!$id){
            return $this->error('没有此IP');
        }
        $ip = \IpPool::findFirst($id);
        if(!$ip){
            return $this->error('没有此IP');
        }
        $ip->customer_id = 0;
        if($ip->save()){
            return $this->success('释放成功');
        }else{
            return $this->error('释放失败');
        }
    }
    public function customerAction($id){
        if(!$id){
            return $this->error('没有此IP');
        }
        $ip = \IpPool::findFirst($id);
        if(!$ip){
            return $this->error('没有此IP');
        }
        $builder = $this->modelsManager->createBuilder()
                   ->columns('*')
                   ->from('Customer')
                   ->orderBy('create_time desc');
        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);
        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        $customer = json_decode(json_encode($paginator),1);
        if(count($customer['items']) > 0){
            foreach($customer['items'] as &$item){
                if($item['worker_id']){
                    $item['worker_name'] = \Worker::findFirst($item['worker_id'])->name;
                }
            }
        }
        $this->view->customer = $customer;
        $this->view->ip = $ip->toArray();
    }
    public function bind_customerAction($ipId,$customerId){
        if(!$ipId){
            return $this->error('没有此IP');
        }
        $ip = \IpPool::findFirst($ipId);
        if(!$ip){
            return $this->error('没有此IP');
        }
        $ip->customer_id = $customerId;
        if($ip->save()){
            return $this->success('保存成功',$this->url->get('ipcm'));
        }else{
            $msg = '';
            foreach ($ip->getMessages() as $message) {
                $msg .= $message;
            }
            $this->end(false);
            return $this->error($msg);
        }
    }
}
