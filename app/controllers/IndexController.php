<?php
use \Component\FunctionExtension as Fex;
class IndexController extends ControllerBase {
    public function indexAction(){
        $conditions = [];
        if(!$this->account['is_super']){
            $conditions = [
                'conditions'=>'worker_id ='.$this->account['id']
            ];
        }
        $this->view->customer_count = \Customer::count($conditions);
        $this->view->orders_count = \Orders::count($conditions);
        if($this->account['is_super']){
            $this->view->total = \Orders::sum([
                'column'=>'total'
            ]);
        }else{
            $this->view->total = \Orders::sum([
                'conditions'=>'worker_id ='.$this->account['id'],
                'column'=>'total'
            ]);
        };
        $this->view->gaap = 0;
    }
}
