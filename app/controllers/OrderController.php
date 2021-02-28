<?php
use \Component\FunctionExtension as Fex;
use Phalcon\Paginator\Adapter\QueryBuilder;
class OrderController extends ControllerBase {
    public function indexAction(){
        $id = $this->request->get('id');
        if($id){
            $where = 'id = '.$id;
        }else{
            $where = '1=1';
        }
        $fex = new Fex();
        if($fex->permission('order-all')){
            $builder = $this->modelsManager
                ->createBuilder()
                ->columns("*")
                ->from('Orders')
                ->where($where)
                ->orderBy("create_time desc");
        }else{
            $builder = $this->modelsManager
                ->createBuilder()
                ->columns("*")
                ->from('Orders')
                ->where('worker_id = '.$this->account['id'])
                ->andWhere($where)
                ->orderBy("create_time desc");
        }

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        $this->view->orders = json_decode(json_encode($paginator),1);
    }
    public function upload_bill_payAction($id){
        $this->begin();
        $bill = \OrderBill::findFirst($id);
        if(!$bill){
            $this->end(false);
            return $this->error('上传失败');
        }
        if($this->request->hasFiles()){
            $image = current($this->request->getUploadedFiles());
            $imageName = md5(rand(0, 9999).$file.microtime()).'.'.$image->getExtension();
            $path = $this->config->application->attachmentDir.'orders/'.$bill->order_id.'/bills/'.$id.'/';
            if(!file_exists($path)){
                mkdir($path,0755,true);
            }
            $newFile = $path.$imageName;
            $image->moveTo($newFile);
            $bill->contract = $imageName;
            if($bill->save()){
                $this->end(true);
                return $this->success('上传成功');
            }else{
                $this->end(false);
                return $this->error('上传失败');
            }
        }else{
            $this->end(false);
            return $this->error('上传失败');
        }
    }
    public function bill_attachmentAction($id = null){
        $bill = \OrderBill::findFirst($id);
        if(!$bill){
            $path = $this->config->application->attachmentDir.'blank.png';
        }else{
            $path = $this->config->application->attachmentDir.'orders/'.$bill->order_id.'/bills/'.$id.'/'.$bill->contract;
            if(!file_exists($path)){
                $path = $this->config->application->attachmentDir.'blank.png';
            }
        }
        $ext = pathinfo($path)['extension'];
        $image = fread(fopen($path,'rb'),filesize($path));
        switch($ext){
            case 'gif':
                $this->response->setHeader('Content-Type', 'image/gif');
            break;
            case 'png':
                $this->response->setHeader('Content-Type', 'image/png');
            break;
            default:
                $this->response->setHeader('Content-Type', 'image/jpeg');
            break;
        }
        return $this->response->setContent($image);
    }
    public function contractAction($id){
        $this->begin();
        $order = \Orders::findFirst($id);
        if(!$order){
            $this->end(false);
            return $this->error('上传失败');
        }
        if($this->request->hasFiles()){
            $image = current($this->request->getUploadedFiles());
            $imageName = md5(rand(0, 9999).$file.microtime()).'.'.$image->getExtension();
            $path = $this->config->application->attachmentDir.'orders/'.$id.'/';
            if(!file_exists($path)){
                mkdir($path,0755,true);
            }
            $newFile = $path.$imageName;
            $image->moveTo($newFile);
            $order->contract = $imageName;
            if($order->save()){
                $this->end(true);
                return $this->success('上传成功');
            }else{
                $this->end(false);
                return $this->error('上传失败');
            }
        }else{
            $this->end(false);
            return $this->error('上传失败');
        }
    }
    public function attachmentAction($id = null){
        $order = \Orders::findFirst($id);
        if(!$order){
            $path = $this->config->application->attachmentDir.'blank.png';
        }else{
            $path = $this->config->application->attachmentDir.'orders/'.$id.'/'.$order->contract;
            if(!file_exists($path)){
                $path = $this->config->application->attachmentDir.'blank.png';
            }
        }
        $ext = pathinfo($path)['extension'];
        $image = fread(fopen($path,'rb'),filesize($path));
        switch($ext){
            case 'gif':
                $this->response->setHeader('Content-Type', 'image/gif');
            break;
            case 'png':
                $this->response->setHeader('Content-Type', 'image/png');
            break;
            default:
                $this->response->setHeader('Content-Type', 'image/jpeg');
            break;
        }
        return $this->response->setContent($image);
    }
    public function editAction($id=null){
        if($id){
            $order = \Orders::findFirst($id);
            $this->view->order = $orderArray = $order->toDetailArray();
            $total = 0;
            foreach($orderArray['items'] as $item){
                $total += $item['price'] * $item['month'] * $item['num'];
            }
            $this->view->normalTotal = $total;
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
    public function new_orderAction($customer_id = null){
        $customer = \Customer::findFirst($customer_id);
        $this->view->customer = $customer->toDetailArray();
    }
    public function get_productAction($idcId = null){
        if($idcId){
            $idc = \Idc::findFirst($idcId);
            $this->view->idc = $idc;
            $sql = 'select i.type from ip_idc as idc right join ip_pool as i on idc.ip_id = i.id where idc_id = '.$idcId.' group by type';
            $type = $this->db->query($sql);
            $this->view->ip = $type->fetchAll();
        }
        $this->view->pick('order/_get_product');
    }
    public function saveAction(){
        $data = \Utils::inputFilter($this->request->getPost());
        if(!$data['opening_time']){
            return $this->error('没有开通时间');
        }
        if(!$data['billing_time']){
            return $this->error('没有计费开始时间');
        }
        if(!$data['end_time']){
            return $this->error('没有计费结束时间');
        }
        if(!$data['items'] || empty($data['items'])){
            return $this->error('没有产品');
        }
        $worker = \Worker::findFirst($data['worker_id']?$data['worker_id']:$this->account['id']);
        if(!$worker){
            return $this->error('员工非法');
        }
        $worker = $worker->toArray();
        $total = 0;
        $order = new \Orders();
        $order->subject = $data['subject'];
        $order->worker_id = $worker['id'];
        $order->worker_name = $worker['name'];
        $order->customer_id = $data['customer_id'];
        $order->status = 'pending';
        $order->pay_status = 'unpayed';
        $order->pay_status = 'unpayed';
        $order->remark = $data['remark']?$data['remark']:'';
        $order->opening_time = $data['opening_time'];
        $order->billing_time = $data['billing_time'];
        $order->end_time = $data['end_time'];
        $order->bill_type = $data['bill_type'];
        $items = [];
        foreach($data['items'] as $idcId=>$products){
            $idc = \Idc::findFirst($idcId);
            foreach($products as $key=>$item){
                $orderItem = new \OrderItem();
                $orderItem->idc_id = $idc->id;
                $orderItem->idc_name = $idc->name;
                $orderItem->idc_province = $idc->province;
                $orderItem->idc_city = $idc->city;
                $orderItem->idc_district = $idc->district;
                $orderItem->idc_address = $idc->address;
                $orderItem->product_type = $item['type'];
                $orderItem->product_name = $item['name'];
                $orderItem->price = $item['price'];
                $orderItem->final_price = $item['final_price'];
                $orderItem->num = $item['num'];
                $orderItem->month = $item['month'];
                $orderItem->customer_id = $data['customer_id'];
                $total += $item['final_price'] * $item['month'] * $item['num'];
                $items[] = $orderItem;
            }
        }
        $order->total = $total;
        $order->orderItem = $items;
        if($order->save()){
            return $this->success('创建成功',$this->url->get('order/edit/'.$order->id));
        }else{
            $msg = '';
            foreach ($order->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    public function reviewAction($id = null,$pass = true){
        $this->begin();
        $commissionRatio = $this->request->getPost('commission_ratio')?$this->request->getPost('commission_ratio'):0;
        $refuseRemark = $this->request->getPost('refuse_remark')?$this->request->getPost('refuse_remark'):'';
        $order = \Orders::findFirst($id);
        if($pass){
            $order->status = 'loading';
        }else{
            $order->status = 'refuse';
        }
        $order->commission_ratio = $commissionRatio;
        $order->refuse_remark = $refuseRemark;
        if($order->save()){
            $this->end('true');
            return $this->success('审核成功',$this->url->get('order/edit/'.$order->id));
        }else{
            $this->end('false');
            $msg = '';
            foreach ($order->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
}
