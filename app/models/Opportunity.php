<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\InclusionIn;
class Opportunity extends \BaseModel{
    public $id;
    public $area;
    public $origin;
    public $company;
    public $needs;
    public $province;
    public $city;
    public $district;
    public $worker_id;
    public $address;
    public $signing_time;
    public $contract_amount;
    public $payment_for_year;
    public $success_rate;
    public $remark;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id','OpportunityContact','opportunity_id');
        $this->hasMany('id','OpportunityWorker','opportunity_id',[
            'alias'=>'worker_history'
        ]);
        $this->hasOne('id','OpportunityWorker','opportunity_id',[
                'alias'=>'worker',
                'params'=>[
                    'conditions'=>"active = 'true'"
                ]
        ]);
        $this->hasOne('id','OpportunityTrack','opportunity_id',[
                'alias'=>'track',
                'params'=>[
                    'conditions'=>"create_time > ".strtotime(date("Y-m-d"))
                ]
        ]);
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            'area',
            new InclusionIn(
                [
                    'message'=>'非法的地理大区',
                    'domain'=>[
                        'area'=>[
                            'east_china',
                            'south_china',
                            'northwest_china',
                            'southwest_china',
                            'north _china',
                            'northeast_china',
                            'central_china',
                            'foreign'
                        ]
                    ]
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeDelete(){
        foreach($this->OpportunityContact as $item){
            $item->delete();
        }
    }
    public function toDetailArray($columns = null){
        $_return = parent::toArray($columns);
        $_return['contact'] = $this->opportunityContact->toArray();
        $_return['worker_history'] = $this->worker_history->toArray();
        if($this->track){
            $_return['track'] = $this->track->toArray();
        }
        return $_return;
    }
}
