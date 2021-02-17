<?php
class IdcCabinetSeat extends \BaseModel{
    public $id;
    public $name;
    public $idc_cabinet_stock_id;
    public $used;
    public $equipment;
    public $customer_id;
    public function initialize(){
        parent::initialize();
        $this->belongsTo("idc_id","Idc","id");
        $this->belongsTo("idc_cabinet_stock_id","IdcCabinetStock","id");
    }
}
