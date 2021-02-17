<?php
use Phalcon\Security;
class WorkReport extends \BaseModel{
    public $id;
    public $worker_id;
    public $report;
    public $report_data;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('worker_id','WorkReport','id');
    }
}
