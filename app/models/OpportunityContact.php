<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\InclusionIn;
class OpportunityContact extends \BaseModel{
    public $id;
    public $opportunity_id;
    public $name;
    public $type;
    public $position;
    public $mobile;
    public $remark;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('opportunity_id','Opportunity','id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            'type',
            new InclusionIn(
                [
                    'message'=>'非法的联系人类型',
                    'domain'=>[
                        'type'=>[
                            'key',
                            'decision',
                            'contact',
                            'other'
                        ]
                    ]
                ]
            )
        );
        return $this->validate($validator);
    }
}
