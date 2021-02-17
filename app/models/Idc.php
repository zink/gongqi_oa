<?php
use Phalcon\Mvc\Model\Message as Message;
class Idc extends \BaseModel{
    public $id;
    public $name;
    public $province;
    public $city;
    public $district;
    public $address;
    public $bridge_price;
    public $bridge_purchase_price;
    public $ampere_price;
    public $ampere_purchase_price;
    public function initialize(){
        parent::initialize();
        $this->hasMany("id","IdcCabinet","idc_id");
        $this->hasMany("id","IpIdc","idc_id");
        $this->hasMany("id","BandwidthIdc","idc_id");
    }
    public function beforeDelete(){
        return $this->IdcCabinet->delete();
    }
    public function toDetailArray($columns = null){
        $_return = parent::toArray($columns);
        $_return['cabinet'] = $this->idcCabinet->toArray();
        return $_return;
    }
}
