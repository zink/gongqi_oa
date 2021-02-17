<?php
use Phalcon\Validation;
use Phalcon\Mvc\Model\Message as Message;
use Phalcon\Validation\Validator\InclusionIn;
use Phalcon\Validation\Validator\PresenceOf;
class CustomerContact extends \BaseModel{
    public $id;
    public $customer_id;
    public $name;
    public $type;
    public $position;
    public $mobile;
    public $remark;
    public function validation(){
        $validator = new Validation();
        $validator->add(
            'type',
            new InclusionIn(
                [
                    'message'=>'非法的联系人类型',
                    'domain'=>[
                        'type'=>[
                            'key',
                            'decision',
                            'contact',
                            'other'
                        ]
                    ]
                ]
            )
        );
        $validator->add(
            "name",
            new PresenceOf(
                [
                    "message" => "姓名必填",
                ]
            )
        );
        $validator->add(
            "position",
            new PresenceOf(
                [
                    "message" => "岗位必填",
                ]
            )
        );
        $validator->add(
            "mobile",
            new PresenceOf(
                [
                    "message" => "电话必填",
                ]
            )
        );
        return $this->validate($validator);
    }
}
