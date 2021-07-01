<?php
use \Component\FunctionExtension as Fex;
use Phalcon\Paginator\Adapter\QueryBuilder;
class CustomerController extends ControllerBase {
    public function indexAction(){
        $fex = new Fex();
        if($fex->permission('customer-all')){
            if($worker){
                $workerId  = $worker;
            }
        }else{
            $workerId  = $this->account['id'];
        }

        $subject       = $this->request->get('subject');
        $certification = $this->request->get('certification');
        $province      = $this->request->get('province');
        $city          = $this->request->get('city');
        $district      = $this->request->get('district');
        $address       = $this->request->get('address');
        $person        = $this->request->get('artificial_person');
        $builder = $this->modelsManager->createBuilder()
                   ->columns('*')
                   ->from('Customer')
                   ->orderBy('create_time desc');
        if($workerId){
            $builder->inWhere("worker_id",explode(',',$workerId));
        }
        if($subject){
            $builder->andWhere("subject like '%".$subject."%'");
        }
        if($certification){
            $builder->andWhere("certification = '".$certification."'");
        }
        if($province){
            $builder->andWhere("province like '%".$province."%'");
        }
        if($city){
            $builder->andWhere("city like '%".$city."%'");
        }
        if($district){
            $builder->andWhere("district like '%".$district."%'");
        }
        if($address){
            $builder->andWhere("address like '%".$address."%'");
        }
        if($person){
            $builder->andWhere("artificial_person like '%".$person."%'");
        }
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
    }
    public function detailAction($id=null){
        if($id){
            $customer = \Customer::findFirst($id);
            $this->view->cabinet = \IdcCabinetStock::find("customer_id=".$id);
            $this->view->ip = $ip = \IpPool::find("customer_id=".$id);
            $this->view->title = $customer->subject."资源明细";
            $this->view->breadcrumb = [
                array(
                    'name'=>'客户列表',
                    'url'=>'customer'
                ),
                array(
                    'name'=>$title
                )
            ];
        }
    }
    public function editAction($id=null){
        if($id){
            $customer = \Customer::findFirst($id);
            if($customer){
                $customer = $customer->toDetailArray();
                if($customer['worker_id']){
                    $customer['worker_name'] = \Worker::findFirst($customer['worker_id'])->name;
                }
                $this->view->attachment = \CustomerAttachment::findFirst('customer_id ='.$id);
                $this->view->customer = $customer;
                $this->view->invoice = count($customer['invoice']) > 0?$customer['invoice'][0]:null;
                $this->view->contact = \CustomerContact::find('customer_id ='.$id);
                $title = '客户编辑';
            }
        }else{
            $title = '新增客户';
        }
        $this->view->title = $title;
        $this->view->breadcrumb = [
            array(
                'name'=>'客户列表',
                'url'=>'customer'
            ),
            array(
                'name'=>$title
            )
        ];
    }
    public function saveAction(){
        $data = $this->request->getPost();
        $this->begin();
        $workerId = $data['worker_id']?$data['worker_id']:$this->account['id'];
        if($data['id']){
            $customer = \Customer::findFirst($data['id']);
        }else{
            $customer = new \Customer();
        }
        $customer->subject = $data['subject'];
        $customer->worker_id = $data['worker_id']?$data['worker_id']:$this->account['id'];
        $customer->remark = $data['remark'];
        $customer->province = $data['province'];
        $customer->city = $data['city'];
        $customer->district = $data['district'];
        $customer->address = $data['address'];
        if($customer->save()){
            $this->end(true);
            return $this->success('保存成功',$this->url->get('customer/edit/'.$customer->id));
        }else{
            $this->end(false);
            $msg = '';
            $messages = $customer->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            return $this->error($msg);
        }
    }
    public function save_invoiceAction(){
        $data = $this->request->getPost();
        $this->begin();
        if($data['id']){
            $invoice = \CustomerInvoice::findFirst($data['id']);
        }else{
            $invoice = new \CustomerInvoice();
        }
        $invoice->title = $data['title'];
        $invoice->customer_id = $data['customer_id'];
        $invoice->tel = $data['tel'];
        $invoice->tax_number = $data['tax_number'];
        $invoice->bank = $data['bank'];
        $invoice->bank_account = $data['bank_account'];
        $invoice->province = $data['province'];
        $invoice->city = $data['city'];
        $invoice->district = $data['district'];
        $invoice->address = $data['address'];
        $invoice->mobile = $data['mobile'];
        if($invoice->save()){
            $this->end(true);
            return $this->success('保存成功',$this->url->get('customer/edit/'.$data['customer_id']));
        }else{
            $this->end(false);
            $msg = '';
            $messages = $invoice->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            return $this->error($msg);
        }
    }
    public function uploadAction($columns = null,$id = null){
        if(!$id || !$columns){
            return $this->error('没有该客户');
        }
        if($this->request->hasFiles()){
            $image = current($this->request->getUploadedFiles());
            $imageName = md5(rand(0, 9999).$file.microtime()).'.'.$image->getExtension();
            $path = $this->config->application->attachmentDir.'customer/'.$id.'/';
            if(!file_exists($path)){
                mkdir($path,0755,true);
            }
            $newFile = $path.$imageName;
            $image->moveTo($newFile);
            $customerAttachment = \CustomerAttachment::findFirst('customer_id = '.$id);
            if(!$customerAttachment){
                $customerAttachment = new \CustomerAttachment();
                $customerAttachment->customer_id = $id;
            }
            switch($columns){
                case 'license':
                case 'legal_person_front':
                case 'legal_person_back':
                case 'contacts_front':
                case 'contacts_back':
                    $customerAttachment->{$columns} = $imageName;
                break;
                default:
                    return $this->error('附件类型错误');
                break;
            }
            if($customerAttachment->save()){
                return $this->success('上传成功');
            }else{
                return $this->error('上传失败');
            }
        }
    }
    public function attachmentAction($id = null){
        $imageName = $this->request->get('download');
        $path = $this->config->application->attachmentDir.'customer/'.$id.'/'.$imageName;
        if(!file_exists($path) || !$id){
            $path = $this->config->application->attachmentDir.'blank.png';
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
    public function add_contactAction($id = null){
        if(!$id){
            return $this->error('没有此客户');
        }
        $data = $this->request->getPost();
        $contact = new \CustomerContact();
        $contact->name = $data['name'];
        $contact->position = $data['position'];
        $contact->type = $data['type'];
        $contact->mobile = $data['mobile'];
        $contact->customer_id = $id;
        if($contact->save()){
            return $this->success('保存成功',$this->url->get('customer/edit/'.$id));
        }else{
            $msg = '';
            foreach ($contact->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    public function certAction($id){
        $this->begin();
        $customer = \Customer::findFirst($id);
        if(!$customer){
            $this->end(false);
            return $this->error('无此用户');
        }
        $customer->certification = 'true';
        if($customer->save()){
            $this->end(true);
            return $this->success('保存成功',$this->url->get('customer/edit/'.$customer['id']));
        }else{
            $this->end(false);
            $msg = '';
            $messages = $customer->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            return $this->error($msg);
        }
    }
}
