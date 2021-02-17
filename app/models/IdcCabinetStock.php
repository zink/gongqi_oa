<?php
class IdcCabinetStock extends \BaseModel{
    public $id;
    public $name;
    public $idc_id;
    public $idc_cabinet_id;
    public $used;
    public $seat_num;
    public $used_seat_num;
    public $ampere;
    public $customer_id;
    public function initialize(){
        parent::initialize();
        $this->belongsTo("idc_id","Idc","id");
        $this->belongsTo("idc_cabinet_id","IdcCabinet","id");
        $this->hasMany("id","IdcCabinetSeat","idc_cabinet_stock_id");
    }
}
