<?php
class BandwidthIdc extends \BaseModel{
    public $id;
    public $bandwidth_id;
    public $idc_id;
    public function initialize(){
        parent::initialize();
        $this->belongsTo("bandwidth_id","Bandwidth","id");
        $this->belongsTo("idc_id","Idc","id");
    }
}
