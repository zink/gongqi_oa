<?php
use Phalcon\Mvc\Model\Message as Message;
class OrderItem extends \BaseModel{
    public $id;
    public $order_id;
    public $product_type;
    public $month_price;
    public $num;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('order_id', 'Orders', 'id');
    }
    public function beforeValidationOnCreate() {
        $this->id = $this->apply_id();
    }
    public function apply_id(){
        do{
            $i = substr(mt_rand() , -5);
            $orderId = (date('y')+date('m')+date('d')).date('His').$i;
            $row = $this->findFirst('id ='.$orderId);
        }while($row);
        return $orderId;
    }
    public function beforeSave(){
        if($this->num < $this->final_num){
            $message = new Message(
                "超卖"
            );
            $this->appendMessage($message);
            return false;
        }
        if($this->num == $this->final_num){
            $this->status = 'finish';
        }
        if($this->num > $this->final_num){
            $this->status = 'loading';
        }
        return true;
    }
    public function afterSave(){
        if(\OrderItem::count("order_id =".$this->order_id." and status = 'loading'") == 0){
            $this->orders->status = 'active';
            $this->orders->save();
        }
    }
}
