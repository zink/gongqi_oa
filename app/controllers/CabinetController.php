<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class CabinetController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('IdcCabinetStock')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $this->view->cabinet = $paginator->getPaginate();
    }
    public function unbind($id){
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
}
