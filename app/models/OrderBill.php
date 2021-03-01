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
    public function validation(){
        if($this->status == 'finish' && $this->pay_status != 'payed'){
            $message = new Message(
                "状态非法"
            );
            $this->appendMessage($message);
            return false;
        }
    }
}
