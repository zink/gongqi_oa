<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Message as Message;
class Customer extends \BaseModel{
    public $id;
    public $subject;
    public $certification;
    public $province;
    public $city;
    public $district;
    public $address;
    public $artificial_person;
    public $worker_id;
    public $remark;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id','IdcCabinetStock','customer_id',[
                'alias'=>'cabinet',
        ]);
        $this->hasMany('id','CustomerMember','customer_id',[
                'columns'=>['member_id','status']
        ]);
        $this->hasMany('id','CustomerInvoice','customer_id');
        $this->hasOne('id','CustomerMember','customer_id',[
                'alias'=>'main_member',
                'colums'=>'member_id',
                'params'=>[
                    'conditions'=>"status = 'main'"
                ]
        ]);
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            ['subject'],
            new Uniqueness(
                [
                    'message'=>'重复主体',
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeDelete(){
        foreach($this->CustomerMember as $item){
            if(!$item->delete()){
                $message = new Message("客户账户删除失败");
                $this->appendMessage($message);
                return false;
            };
        }
    }
    /*
    public function afterFetch(){
        if($this->license){
            $this->license = $this->getDI()->getShared('driver')->getDomain().$this->license;
        }
        if($this->legal_person_front){
            $this->legal_person_front = $this->getDI()->getShared('driver')->getDomain().$this->legal_person_front;
        }
        if($this->legal_person_back){
            $this->legal_person_back = $this->getDI()->getShared('driver')->getDomain().$this->legal_person_back;
        }
        if($this->contacts_front){
            $this->contacts_front = $this->getDI()->getShared('driver')->getDomain().$this->contacts_front;
        }
        if($this->contacts_back){
            $this->contacts_back = $this->getDI()->getShared('driver')->getDomain().$this->contacts_back;
        }
    }
    */
    public function toDetailArray($columns = null){
        $_return = parent::toArray($columns);
        $_return['member'] = $this->CustomerMember->toArray();
        $_return['invoice'] = $this->CustomerInvoice->toArray();
        return $_return;
    }
}
