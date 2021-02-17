<?php
use Phalcon\Mvc\Model\Message as Message;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
class Bandwidth extends \BaseModel{
    public $id;
    public $total;
    public $used;
    public $province;
    public $city;
    public $district;
    public function initialize(){
        parent::initialize();
        $this->hasMany("id","BandwidthIdc","bandwidth_id");
    }
    public function toDetailArray($columns = null){
        $_return = parent::toArray($columns);
        $_return['idc'] = $this->bandwidthIdc->toArray();
        return $_return;
    }
}
