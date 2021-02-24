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
        $this->hasMany('id', 'OrderBill', 'order_id');
    }
    public function beforeValidationOnCreate() {
        $this->id = $this->apply_id();
    }
    public function validation(){
        if($this->billing_time >= $this->end_time){
            $message = new Message(
                "计费开始时间不能大小或等于计费结束时间"
            );
            $this->appendMessage($message);
            return false;
        }
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
    public function beforeCreate(){
        $billingTime = $this->billing_time;
        $endTime = $this->end_time;
        $monarr = [];
        while( $billingTime <= $endTime) {
            $nexttime = 0;
            switch($this->bill_type){
                case 'year':
                    $nextTime = strtotime('+12 month', $billingTime);
                break;
                case 'half_year':
                    $nextTime = strtotime('+6 month', $billingTime);
                break;
                case 'three_month':
                    $nextTime = strtotime('+3 month', $billingTime);
                break;
                case 'month':
                    $nextTime = strtotime('+1 month', $billingTime);
                break;
            }
            $monarr[] = [
                'begin'=>$billingTime,
                'end'=>min($this->end_time,strtotime('-1 day',$nextTime))
            ];
            $billingTime = $nextTime;
        }
        $orderBillCount = count($monarr);
        $billTotal = \Utils::priceFormat($this->total / $orderBillCount);
        foreach($monarr as $k=>$v){
            $orderBill = new \OrderBill();
            $orderBill->order_id = $this->id;
            $orderBill->billing_time = $v['begin'];
            $orderBill->end_time = $v['end'];
            $orderBill->total = $billTotal;
            if(!$orderBill->save()){
                return false;
            }
        }
        return true;
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
        $order['bills'] = $this->orderBill->toArray();
        return $order;
    }
}
