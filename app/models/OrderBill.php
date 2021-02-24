<?php
use Phalcon\Mvc\Model\Message as Message;
class OrderBill extends \BaseModel{
    public $id;
    public $order_id;
    public $billing_time;
    public $end_time;
    public $total;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('order_id', 'Orders', 'id');
    }
}
