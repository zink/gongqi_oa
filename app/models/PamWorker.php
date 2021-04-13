<?php
use Phalcon\Security;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Validation\Validator\InclusionIn;
use Phalcon\Mvc\Model\Message as Message;
class PamWorker extends \BaseModel{
    public $id;
    public $worker_id;
    public $login_account;
    public $login_type;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('worker_id','Worker','id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            'login_account',
            new Uniqueness(
                [
                    'message'=>'用户名已存在',
                ]
            )
        );
        $validator->add(
            'login_type',
            new InclusionIn(
                [
                    'message'=>'非法的账户类型',
                    'domain'=>[
                        'login_type'=>[
                            'mobile',
                            'email'
                        ]
                    ]
                ]
            )
        );
        return $this->validate($validator);
    }
    public function checkLogin($account ,$password){
        $account = self::findFirst(array(
            "login_account = :login_account:",
            'bind' => array('login_account' => $account)
        ));
        if(!$account){
            $message = new Message(
                "用户名或密码错误"
            );
            $this->appendMessage($message);
            return false;
        }
        $worker = $account->worker;
        $security =  new Security();
        if($worker->disabled == 'true'){
            $message = new Message(
                "该账号已禁止登录"
            );
            $this->appendMessage($message);
            return false;
        }
        if (!$security->checkHash($password, $worker->password)) {
            $security->hash(rand());
            $message = new Message(
                "用户名或密码错误"
            );
            $this->appendMessage($message);
            return false;
        }
        return $worker;
    }
}
