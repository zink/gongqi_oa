<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class CabinetController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('IdcCabinetStock');

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $this->view->cabinet = $paginator->getPaginate();
    }
    public function unbindAction($id){
        if(!$id){
            return $this->error('没有此机柜');
        }
        $cabinet = \IdcCabinetStock::findFirst($id);
        if(!$cabinet){
            return $this->error('没有此机柜');
        }
        $cabinet->customer_id = 0;
        $cabinet->used = 'false';
        $cabinet->name = '';
        $cabinet->used_seat_num = 0;
        if($cabinet->save()){
            return $this->success('释放成功');
        }else{
            return $this->error('释放失败');
        }
    }
}
