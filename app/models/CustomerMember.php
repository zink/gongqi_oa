<?php
use Phalcon\Mvc\Model\Message as Message;
class CustomerMember extends \BaseModel{
    public $id;
    public $type;
    public $disabled;
    public $customer_id;
    public $member_id;
    public function initialize(){
        parent::initialize();
        $this->hasOne('customer_id','Customer','id');
    }
}
