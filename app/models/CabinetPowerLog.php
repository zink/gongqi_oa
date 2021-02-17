<?php
class CabinetPowerLog extends \BaseModel{
    public $id;
    public $power_up;
    public $idc_cabinet_id;
    public $customer_id;
    public function initialize(){
        parent::initialize();
        $this->belongsTo("idc_cabinet_id","IdcCabinet","id");
    }
}
