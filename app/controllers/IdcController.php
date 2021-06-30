<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class IdcController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('Idc')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        $this->view->idc = json_decode(json_encode($paginator),1);
    }
    public function editAction($id=null){
        if($id){
            $idc = \Idc::findFirst($id);
            $this->view->idc = $idc->toDetailArray();
            $title = 'IDC编辑';
        }else{
            $title = '新增IDC';
        }
        $this->view->title = $title;
        $this->view->breadcrumb = [
            array(
                'name'=>'IDC列表',
                'url'=>'idc'
            ),
            array(
                'name'=>$title
            )
        ];
    }
    public function saveAction(){
        $data = $this->request->getPost();
        if($data['id']){
            $idc = \Idc::findFirst($data['id']);
        }else{
            $idc = new \Idc();
        }
        $idc->name = $data['name'];
        $idc->province = $data['province'];
        $idc->city = $data['city'];
        $idc->district = $data['district'];
        $idc->address = $data['address'];
        $idc->bridge_price = $data['bridge_price'];
        $idc->bridge_purchase_price = $data['bridge_purchase_price'];
        $idc->ampere_price = $data['ampere_price'];
        $idc->ampere_purchase_price = $data['ampere_purchase_price'];
        $idc->ip_price = $data['ip_price'];
        $idc->ip_purchase_price = $data['ip_purchase_price'];
        $idc->ipv6_price = $data['ipv6_price'];
        $idc->ipv6_purchase_price = $data['ipv6_purchase_price'];
        if($idc->save()){
            return $this->success('保存成功',$this->url->get('idc/edit/'.$idc->id));
        }else{
            $msg = '';
            foreach ($idc->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    public function deleteAction($id = null){
        if($id){
            $idc = \Idc::findFirst($id);
            if($idc->delete()){
                return $this->success('删除成功');
            }else{
                $msg = '';
                foreach ($idc->getMessages() as $message) {
                    $msg .= $message;
                }
                return $this->error($msg);
            }
        }else{
            return $this->error('无此机房');
        }
    }
    public function save_cabinetAction($id = null){
        if(!$id){
            return $this->error('无此机房');
        }
        $data = \Utils::inputFilter($this->request->getPost());
        $this->begin();
        $idc = \Idc::findFirst($id);
        if(!$idc){
            $this->end(false);
            return $this->error('无此机房');
        }
        if($data['id']){
            $cabinet = \IdcCabinet::findFirst($data['id']);
            unset($data['id']);
        }else{
            $cabinet = new \IdcCabinet();
        }
        $cabinet->idc_id = $id;
        foreach($data as $key=>$value){
            $cabinet->{$key} = $value;
        }
        if($cabinet->save()){
            $this->end(true);
            return $this->success('保存成功');
        }else{
            $this->end(false);
            $msg = '';
            foreach ($cabinet->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    public function delete_cabinetAction($id = null){
        if(!$id){
            return $this->error('没有此机柜');
        }
        $cabinet = \IdcCabinet::findFirst($id);
        if(!$cabinet){
            return $this->error('没有此机柜');
        }
        if($cabinet->delete()){
            return $this->success('删除成功');
        }else{
            $msg = '';
            foreach ($cabinet->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    //for idc object
    public function idc_modalAction($multiple = 0){
        $this->view->multiple = $multiple;
        $idc = \Idc::find();
        $this->view->idc = $idc->toArray();
        $this->view->pick('idc/idc_object/_modal');
    }
    public function get_listAction(){
        $ids = $this->request->get('id');
        $idc = \Idc::find([
            'conditions'=>'id in ({id:array})',
            'bind'=>[
                'id'=>$ids
            ]
        ]);
        return $this->response->setJsonContent($idc->toArray());
    }
}
