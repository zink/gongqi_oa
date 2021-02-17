<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\InclusionIn;
use Phalcon\Mvc\Model\Message as Message;
class Orders extends \BaseModel{
    public $id;
    public $subject;
    public $worker_id;
    public $customer_id;
    public $total;
    public $status;
    public $pay_status;
    public $remark;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id', 'OrderItem', 'order_id');
    }
    public function beforeValidationOnCreate() {
        $this->id = $this->apply_id();
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            ['status','pay_status'],
            new InclusionIn(
                [
                    'message'=>[
                        'status' => "订单状态非合法值",
                        'pay_status' => '订单支付状态非合法值',
                        'ship_status' => '订单发货状态非合法值'
                    ],
                    'domain' => [
                        'status'=>[
                            'pending',
                            'refuse',
                            'doing',
                            'loading',
                            'active',
                            'dead',
                            'finish'
                        ],
                        'pay_status'=>[
                            'unpayed',
                            'payed',
                            'partial'
                        ],
                    ]
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeUpdate(){
        $changedFields = $this->getChangedFields();
        if(count($changedFields) > 0){
        $snapshotData = $this->getSnapshotData();
            foreach($changedFields as $field){
                if($field == 'pay_status'){
                    switch($snapshotData['pay_status']){
                        case 'payed':
                            if($this->pay_status == 'unpayed'){
                                $message = new Message(
                                    "支付状态不可逆"
                                );
                                $this->appendMessage($message);
                                return false;
                            }
                        break;
                        case 'partial_payment':
                            if($this->pay_status == 'unpayed'){
                                $message = new Message(
                                    "支付状态不可逆向"
                                );
                                $this->appendMessage($message);
                                return false;
                            }
                        break;
                    }
                }
            }
        }
    }
    public function apply_id(){
        do{
            $i = substr(mt_rand() , -5);
            $orderId = (date('y')+date('m')+date('d')).date('His').$i;
            $row = $this->findFirst('id ='.$orderId);
        }while($row);
        return $orderId;
    }
    public function toDetailArray($columns = null){
        $order = parent::toArray($columns);
        $order['items'] = $this->orderItem->toArray();
        return $order;
    }
}
