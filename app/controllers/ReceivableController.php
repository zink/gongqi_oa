<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class ReceivableController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('Orders')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        $this->view->orders = json_decode(json_encode($paginator),1);
    }
    public function editAction($id=null){
        if($id){
            $order = \Orders::findFirst($id);
            $this->view->order = $order->toDetailArray();
            $this->view->title = '查看订单'.$order->id;
            $this->view->breadcrumb = [
                array(
                    'name'=>'订单列表',
                    'url'=>'order'
                ),
                array(
                    'name'=>$order->id
                )
            ];
        }
    }
}
