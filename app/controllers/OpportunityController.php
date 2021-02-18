<?php
use \Component\FunctionExtension as Fex;
class OpportunityController extends ControllerBase {
    public function indexAction(){
        $company = $this->request->get('company');
        $worker = $this->request->get('worker');
        $status = $this->request->get('status');
        $fex = new Fex();
        $req = new \Business\Opportunity();
        if($company){
            $req->setFields('company',$company);
        }
        if($status){
            $req->setFields('status',$status);
        }
        if($fex->permission('opportunity-all')){
            if($worker){
                $req->setFields('worker_id',$worker);
            }
        }else{
            $req->setFields('worker_id',$this->account['id']);
        }
        $req->setFields('page',$this->page);
        $req->setFields('limit',50);
        $opportunity = $req->search();
        if(count($opportunity['items']) > 0){
            foreach($opportunity['items'] as &$item){
                if($item['worker_id']){
                    $item['worker_name'] = \Worker::findFirst($item['worker_id'])->name;
                }
            }
        }
        $this->view->opportunity = $opportunity;
        $workers = \Worker::find([
            'columns'=>'id,name'
        ]);
        $this->view->workers = $workers;
    }
    public function batch_workerAction(){
        $fex = new Fex();
        if(!$fex->permission('opportunity-all')){
            return $this->error('无权限');
        }
        $data = $this->request->getPost();
        foreach($data['opportunity'] as $id){
            $req = new \Business\Opportunity();
            $req->setFields('id',$id);
            $req->setFields('worker_id',$data['worker']);
            $req->update();
        }
        return $this->success('保存成功');
    }
    public function editAction($id = null){
        if($id){
            $req = new \Business\Opportunity();
            $req->setFields('id',$id);
            $opportunity = $req->get();
            if(count($opportunity['worker_history']) > 0){
                foreach($opportunity['worker_history'] as &$item){
                    $item['worker_name'] = \Worker::findFirst($item['worker_id'])->name;
                }
            }
            $this->view->opportunity = $opportunity;
            $title = '编辑销售线索';
        }else{
            $title = '新增销售线索';
        }
        $this->view->title = $title;
        $this->view->breadcrumb = [
            array(
                'name'=>'全部销售线索',
                'url'=>'opportunity'
            ),
            array(
                'name'=>$title
            )
        ];
    }
    public function saveAction(){
        $data = $this->request->getPost();
        if($data['id']){
            $req = new \Business\Opportunity();
            $req->setFields('id',$data['id']);
        }else{
            $req = new \Business\Opportunity();
        }
        $req->setFields('origin',$data['origin']);
        $req->setFields('company',$data['company']);
        $req->setFields('area',$data['area']);
        $req->setFields('worker_id',$data['worker_id']?$data['worker_id']:$this->account['id']);
        $req->setFields('remark',$data['remark']);
        $req->setFields('province',$data['province']);
        $req->setFields('city',$data['city']);
        $req->setFields('district',$data['district']);
        $req->setFields('address',$data['address']);
        $req->setFields('needs',$data['needs']);
        $req->setFields('signing_time',strtotime($data['signing_time']));
        $req->setFields('contract_amount',$data['contract_amount']);
        $req->setFields('payment_for_year',$data['payment_for_year']);
        $req->setFields('success_rate',$data['success_rate']);
        if($data['id']){
            $_return = $req->update();
        }else{
            $_return = $req->create();
        }
        if($_return['id']){
            if($data['contact'] && count($data['contact']) > 0){
                $req = new \Business\Opportunity();
                foreach($data['contact'] as $contact){
                    $req->setFields('id',$_return['id']);
                    $req->setFields('name',$contact['name']);
                    $req->setFields('type',$contact['type']);
                    $req->setFields('position',$contact['position']);
                    $req->setFields('mobile',$contact['mobile']);
                    $req->addContact();
                }
            }
            if($data['delete_contact'] && count($data['delete_contact']) > 0){
                $req = new \Business\Opportunity();
                foreach($data['delete_contact'] as $del_contact_id){
                    $req->setFields('id',$del_contact_id);
                    $req->deleteContact();
                }
            }
            return $this->success('保存成功',$this->url->get('opportunity/edit/'.$_return['id']));
        }else{
            return $this->error($_return['error_description']);
        }
    }
    public function get_trackAction($id = null){
        if($id){
            $data = $this->request->getPost();
            $req = new \Business\Opportunity();
            $req->setFields('id',$id);
            $opportunity = $req->get();
            $req = new \Business\Opportunity();
            $req->setFields('id',$opportunity['id']);
            $req->setFields('start_time',strtotime($data['start']));
            $req->setFields('end_time',strtotime($data['end']));
            $tracks = $req->getTrackList();
            if(count($tracks) > 0){
                foreach($tracks as &$item){
                    if($item['worker_id']){
                        $item['worker_name'] = \Worker::findFirst($item['worker_id'])->name;
                    }
                }
            }
            return $this ->response ->setJsonContent($tracks);
        }else{
            return $this ->response ->setJsonContent([]) ;
        }
    }
    public function save_today_trackAction($opId){
        if($opId){
            $data = $this->request->getPost();
            if($data['track_id']){
                $req = new \Business\Opportunity();
                $req->setFields('id',$data['track_id']);
            }else{
                $opportunity = \Opportunity::findFirst($opId);
                $req = new \Business\Opportunity();
                $req->setFields('id',$opportunity->id);
                $req->setFields('worker_id',$opportunity->worker_id);
            }
            $req->setFields('status',$data['status']);
            $req->setFields('track_info',$data['track_info']);
            if($data['track_id']){
                $track = $req->updateTrack();
            }else{
                $track = $req->addTrack();
            }
            if($track['id']){
                return $this->success('保存成功',null,$track['id']);
            }else{
                return $this->error($track['error_description']);
            }
        }else{
            return $this->error('无效的线索');
        }
    }
}
