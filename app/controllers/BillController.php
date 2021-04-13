<?php
use \Component\FunctionExtension as Fex;
use Phalcon\Paginator\Adapter\QueryBuilder;
class BillController extends ControllerBase {
    public function indexAction(){
        $status = $this->request->get('status');
        $id = $this->request->get('id');
        $fex = new Fex();
        if($fex->permission('bill-all')){
            $builder = $this->modelsManager
                ->createBuilder()
                ->columns("*")
                ->from('OrderBill')
                ->orderBy("billing_time asc");
            if($status == 'finish'){
                $builder->andWhere("status = 'finish'");
            }elseif($status == 'pending'){
                $builder->andWhere("status = 'pending'");
                $builder->andWhere("pay_status = 'payed'");
            }
            if($id){
                $builder->andWhere("order_id = ".$id);
            }
            $paginator = new QueryBuilder([
                "builder" => $builder,
                "limit" => $this->limit,
                "page" => $this->page
            ]);
            $paginator = $paginator->getPaginate();
            $this->view->bills = $paginator;
        }
    }
    public function bill_confirmAction(){
        $fex = new Fex();
        if($fex->permission('billling-confirm')){
            $builder = $this->modelsManager
                ->createBuilder()
                ->columns("*")
                ->from('OrderBill')
                ->andWhere("status = 'pending'")
                ->andWhere("pay_status = 'payed'")
                ->orderBy("billing_time asc");
            $paginator = new QueryBuilder([
                "builder" => $builder,
                "limit" => $this->limit,
                "page" => $this->page
            ]);
            $paginator = $paginator->getPaginate();
            $this->view->bills = $paginator;
        }
    }
    public function bill_finishAction(){
        $fex = new Fex();
        if($fex->permission('billling-confirm')){
            $builder = $this->modelsManager
                ->createBuilder()
                ->columns("*")
                ->from('OrderBill')
                ->andWhere("status = 'finish'")
                ->orderBy("billing_time asc");
            $paginator = new QueryBuilder([
                "builder" => $builder,
                "limit" => $this->limit,
                "page" => $this->page
            ]);
            $paginator = $paginator->getPaginate();
            $this->view->bills = $paginator;
        }
    }
    public function finishAction($id = null){
        $this->begin();
        $bill = \OrderBill::findFirst($id);
        if(!$bill){
            $this->end(false);
            return $this->error('没有此账单');
        }
        $worker = \Worker::findFirst($this->account['id']);
        if(!$worker){
            $this->end(false);
            return $this->error('员工非法');
        }
        $bill->status = 'finish';
        $bill->finish_time = time();
        $bill->finish_worker = $worker->id;
        $bill->finish_worker_name = $worker->name;
        if($bill->save()){
            $this->end(true);
            return $this->success('确收成功');
        }else{
            $this->end(false);
            $msg = '';
            foreach ($bill->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    public function show_orderAction($orderId = null){
        $fex = new Fex();
        if($fex->permission('finance')){
            $order = \Orders::findFirst($orderId);
            $this->view->order = $orderArray = $order->toDetailArray();
            $total = 0;
            foreach($orderArray['items'] as $item){
                $total += $item['price'] * $item['month'] * $item['num'];
            }
            $this->view->normalTotal = $total;
            $this->view->pick('bill/_show_order');
        }
    }
}
