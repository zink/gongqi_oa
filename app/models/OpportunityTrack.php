<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\InclusionIn;
class OpportunityTrack extends \BaseModel{
    public $id;
    public $opportunity_id;
    public $worker_id;
    public $status;
    public $track_info;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('opportunity_id','Opportunity','id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            'status',
            new InclusionIn(
                [
                    'message'=>'非法的状态',
                    'domain'=>[
                        'status'=>[
                            'active',
                            'dead',
                            'success'
                        ]
                    ]
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeSave(){
        $this->opportunity->status = $this->status;
        if(!$this->opportunity->save()){
            return false;
        }
        return true;
    }
}
