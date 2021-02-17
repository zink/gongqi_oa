<?php
class IpIdc extends \BaseModel{
    public $id;
    public $ip_id;
    public $idc_id;
    public function initialize(){
        parent::initialize();
        $this->belongsTo("ip_id","IpPool","id");
        $this->belongsTo("ip_id","IpPool","id",[
            'alias'=>'can_use_ip',
            'params'=>[
                'conditions'=>"customer_id = 0"
            ]
        ]);
        $this->belongsTo("idc_id","Idc","id");
    }
}
