<?php
namespace Business;
use Phalcon\Paginator\Adapter\QueryBuilder;
class Opportunity extends \AbstractClass\BaseApi{
    public $requestFields = [];
    public function setFields($name,$value){
        $this->requestFields[$name] = $value;
    }
    public function get(){
        $id = $this->requestFields['id'];
        $opportunity = \Opportunity::findFirst($id);
        if(!$opportunity){
            throw new \Exception('没有此部门');
        }
        return $this->success($opportunity->toDetailArray());
    }
    public function getList(){
        $page = $this->requestFields['page'];
        $limit = $this->requestFields['limit'];
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('Opportunity')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $limit,
            "page" => $page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        return $this->success($paginator);
    }
    public function search(){
        $page     = $this->requestFields['page'];
        $limit    = $this->requestFields['limit'];
        $origin   = $this->requestFields['origin'];
        $area     = $this->requestFields['area'];
        $workerId = $this->requestFields['worker_id'];
        $company  = $this->requestFields['company'];
        $province = $this->requestFields['province'];
        $city     = $this->requestFields['city'];
        $district = $this->requestFields['district'];
        $address  = $this->requestFields['address'];
        $status   = $this->requestFields['status'];
        $builder = $this->modelsManager->createBuilder()
                   ->columns('*')
                   ->from('Opportunity')
                   ->orderBy('create_time desc');
        if($workerId){
            $builder->inWhere("worker_id",explode(',',$workerId));
        }
        if($origin){
            $builder->andWhere("origin like '%".$origin."%'");
        }
        if($area){
            $builder->andWhere("area like '%".$area."%'");
        }
        if($company){
            $builder->andWhere("company like '%".$company."%'");
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
        if($status){
            $builder->andWhere("status ='".$status."'");
        }

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $limit,
            "page" => $page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        return $this->success($paginator);
    }
    public function create(){
        $opportunity = new \Opportunity();
        $opportunity->origin  = $this->requestFields['origin'];
        $opportunity->area    = $this->requestFields['area'];
        $opportunity->company = $this->requestFields['company'];
        $opportunity->needs   = $this->requestFields['needs']?$this->requestFields['needs']:'';
        $opportunity->signing_time      = $this->requestFields['signing_time']?$this->requestFields['signing_time']:0;
        $opportunity->contract_amount   = $this->requestFields['contract_amount']?$this->requestFields['contract_amount']:0;
        $opportunity->payment_for_year  = $this->requestFields['payment_for_year']?$this->requestFields['payment_for_year']:0;
        $opportunity->success_rate   = $this->requestFields['success_rate']?$this->requestFields['success_rate']:0;
        $opportunity->remark  = $this->requestFields['remark']?$this->requestFields['remark']:'';
        /*如果有地址需要进行地址校验*/
        if($this->requestFields['province']){
            $opportunity->province = $checkReturn['province'];
            $opportunity->city     = $checkReturn['city']?$checkReturn['city']:'';
            $opportunity->district = $checkReturn['district']?$checkReturn['district']:'';
            $opportunity->address = $this->requestFields['address']?$this->requestFields['address']:'';
        }
        if($this->requestFields['worker_id']){
            $worker = \Worker::findFirst($this->requestFields['worker_id']);
            if($worker){
                $opportunity->worker_id = $this->requestFields['worker_id'];
                $workerMdl = new \OpportunityWorker();
                $workerMdl->worker_id = $this->requestFields['worker_id'];
                $workerMdl->active = 'true';
                $opportunity->worker =$workerMdl;
            }
        }
        if($opportunity->save()){
            return $this->success(['id'=>$opportunity->id]);
        }else{
            $msg = '';
            $messages = $opportunity->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    private function _change_active($opid = null){
        if(!$opid){
            return false;
        }
        $active = \OpportunityWorker::findFirst('opportunity_id = '.$opid." and active = 'true'");
        if($active){
            $active->active = 'false';
            return $active->save();
        }
        return true;
    }
    public function update(){
        $id = $this->requestFields['id'];
        $this->beginTransaction();
        $opportunity = \Opportunity::findFirst($id);
        if(!$opportunity){
            $this->rollbackTransaction();
            throw new \Exception('没有该销售机会');
        }
        /*如果有地址需要进行地址校验*/
        if($this->requestFields['province']){
            $opportunity->province = $checkReturn['province'];
            $opportunity->city     = $checkReturn['city']?$checkReturn['city']:'';
            $opportunity->district = $checkReturn['district']?$checkReturn['district']:'';
            $opportunity->address = $this->requestFields['address']?$this->requestFields['address']:'';
        }
        foreach($this->requestFields as $key=>$value){
            if($key == 'worker_id'){
                $workerMdl = \OpportunityWorker::findFirst('opportunity_id = '.$id." and worker_id = ".$value);
                if($workerMdl){
                    if($workerMdl->active == 'false'){
                        if(!$this->_change_active($id)){
                            $this->rollbackTransaction();
                            throw new \Exception('更新失败');
                        };
                        $workerMdl->active = 'true';
                        if(!$workerMdl->save()){
                            $this->rollbackTransaction();
                            $msg = '';
                            $messages = $workerMdl->getMessages();
                            foreach ($messages as $item) {
                                $msg .= $item;
                            }
                            throw new \Exception($msg);
                        }
                    }
                }else{
                    $worker = \Worker::findFirst($value);
                    if($worker){
                        $workerMdl = new \OpportunityWorker();
                        $workerMdl->worker_id = $worker->id;
                        $workerMdl->active = true;
                        $workerMdl->opportunity_id = $id;
                        if(!$this->_change_active($id)){
                            $this->rollbackTransaction();
                            throw new \Exception('更新失败');
                        };
                        if(!$workerMdl->save()){
                            $this->rollbackTransaction();
                            $msg = '';
                            $messages = $workerMdl->getMessages();
                            foreach ($messages as $item) {
                                $msg .= $item;
                            }
                            throw new \Exception($msg);
                        }
                    }
                }
            }
            $opportunity->{$key} = $value;
        }
        if($opportunity->save()){
            $this->commitTransaction();
            return $this->success(['id'=>$opportunity->id]);
        }else{
            $this->rollbackTransaction();
            $msg = '';
            $messages = $opportunity->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    public function addContact(){
        $id = $this->requestFields['id'];
        $this->beginTransaction();
        $opportunity = \Opportunity::findFirst($id);
        if(!$opportunity){
            $this->rollbackTransaction();
            throw new \Exception('没有此销售线索');
        }
        $contact = new \OpportunityContact();
        $contact->opportunity_id = $id;
        $contact->name = $this->requestFields['name'];
        $contact->type = $this->requestFields['type'];
        $contact->position = $this->requestFields['position']?$this->requestFields['position']:'';
        $contact->mobile = $this->requestFields['mobile']?$this->requestFields['mobile']:'';
        $contact->remark = $this->requestFields['remark']?$this->requestFields['remark']:'';
        if($contact->save()){
            $this->commitTransaction();
            return $this->success(['id'=>$contact->id]);
        }else{
            $this->rollbackTransaction();
            $msg = '';
            $messages = $contact->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    public function updateContact(){
        $id = $this->requestFields['id'];
        $this->beginTransaction();
        $contact = \OpportunityContact::findFirst($id);
        if(!$contact){
            $this->rollbackTransaction();
            throw new \Exception('没有此联系人');
        }
        foreach($this->requestFields as $key=>$value){
            $contact->{$key} = $value;
        }
        if($contact->save()){
            $this->commitTransaction();
            return $this->success(['id'=>$contact->id]);
        }else{
            $this->rollbackTransaction();
            $msg = '';
            $messages = $contact->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    public function deleteContact(){
        $id = $this->requestFields['id'];
        $this->beginTransaction();
        $contact = \OpportunityContact::findFirst($id);
        if(!$contact){
            $this->rollbackTransaction();
            throw new \Exception('没有此联系人');
        }
        if($contact->delete()){
            $this->commitTransaction();
            return $this->success('删除成功');
        }else{
            $this->rollbackTransaction();
            $msg = '';
            $messages = $contact->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    public function getTrack(){
        $track = \OpportunityTrack::findFirst($this->requestFields['id']);
        if(!$track){
            throw new \Exception('没有此跟踪信息');
        }
        return $this->success($track->toArray());
    }
    public function addTrack(){
        $track = new \OpportunityTrack();
        $worker = \Worker::findFirst($this->requestFields['worker_id']);
        if($worker){
            $track->worker_id = $this->requestFields['worker_id'];
        }else{
            throw new \Exception('非法的员工',500);
        }
        $track->opportunity_id = $this->requestFields['id'];
        $track->status = $this->requestFields['status'];
        $track->track_info = $this->requestFields['track_info'];
        if($track->save()){
            return $this->success(['id'=>$track->id]);
        }else{
            $msg = '';
            $messages = $track->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    public function updateTrack(){
        $this->beginTransaction();
        $track = \OpportunityTrack::findFirst($this->requestFields['id']);
        if(!$track){
            $this->rollbackTransaction();
            throw new \Exception('没有此跟踪信息');
        }
        if($this->requestFields['status']){
            $track->status = $this->requestFields['status'];
        }
        if($this->requestFields['track_info']){
            $track->track_info = $this->requestFields['track_info'];
        }
        if($track->save()){
            $this->commitTransaction();
            return $this->success(['id'=>$track->id]);
        }else{
            $msg = '';
            $messages = $track->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            throw new \Exception($msg);
        }
    }
    public function getTrackList(){
        $startTime = $this->requestFields['start_time'];
        $endTime  = $this->requestFields['end_time'];
        $workerId = $this->requestFields['worker_id'];
        $where = ["opportunity_id = ".$this->requestFields['id']];
        if($startTime){
            $where[] = 'create_time > '.$startTime;
        }
        if($endTime){
            $where[] = 'create_time < '.$endTime;
        }
        if($workerId){
            $where[] = 'worker_id = '.$workerId;
        }
        $track = \OpportunityTrack::find([
            "conditions"=>implode(' and ',$where)
        ]);
        return $this->success($track->toArray());
    }
}
