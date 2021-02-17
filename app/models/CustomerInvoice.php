<?php
use Phalcon\Mvc\Model\Message as Message;
class CustomerInvoice extends \BaseModel{
    public $id;
    public $subject;
    public $customer_id;
    public $title;
    public $tax_number;
    public $bank;
    public $bank_account;
    public $province;
    public $city;
    public $district;
    public $address;
    public $tel;
    public function initialize(){
        parent::initialize();
        $this->hasOne('customer_id','Customer','id');
    }
}
