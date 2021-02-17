<?php
class OpportunityWorker extends \BaseModel{
    public $id;
    public $opportunity_id;
    public $worker_id;
    public $active;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('opportunity_id','Opportunity','id');
    }
}
