<?php
use Phalcon\Security;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\InclusionIn;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Validation\Validator\Regex; // 正则
use Phalcon\Mvc\Model\Message as Message;
class Worker extends \BaseModel{
    public $id;
    public $department_id;
    public $password;
    public $avatar;
    public $name;
    public $mobile;
    public $tel;
    public $email;
    public $b_year;
    public $b_month;
    public $b_day;
    public $sex;
    public $reg_ip;
    public $login_count;
    public $remark;
    public $disabled;
    public function initialize(){
        parent::initialize();
        $this->hasOne(
                'id',
                'PamWorker',
                'worker_id',
                [
                    'alias'=>'pam_email',
                    'params'=>[
                        'conditions'=>"login_type = 'email'"
                    ]
                ]
        );
        $this->hasOne(
                'id',
                'PamWorker',
                'worker_id',
                [
                    'alias'=>'pam_mobile',
                    'params'=>[
                        'conditions'=>"login_type = 'mobile'"
                    ]
                ]
        );
        $this->hasMany('id','Report','worker_id');
        $this->belongsTo('department_id','Department','id');
        $this->belongsTo('position_id','Position','id');
    }

    public function validation(){
        $validator = new Validation();
        $validator->add(
            'email',
            new Email(
                [
                    'message'=>'非法的email'
                ]
            )
        );
        if($this->mobile != ''){
            $validator->add(
                'mobile',
                new Regex([
                        "pattern" => "/^(1[3456789]{1}[0-9]{9})$/",
                        "message" => "请使用正确的手机号码",
                    ]
                )
            );
        }
        $validator->add(
            'sex',
            new InclusionIn(
                [
                    'message'=>[
                        'sex'=>'非法的性别'
                    ],
                    'domain'=>[
                        'sex'=>[
                            'male',
                            'female'
                        ]
                    ]
                ]
            )
        );
        $validator->add(
            'email',
            new Uniqueness(
                [
                    'message'=>'email已存在',
                ]
            )
        );
        $validator->add(
            'mobile',
            new Uniqueness(
                [
                    'message'=>'mobile已存在',
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeCreate(){
        $security =  new Security();
        $this->password =$security->hash($this->password);
        $this->reg_ip = $this->getDI()->get('request')->getClientAddress();
    }
    public function beforeUpdate(){
        if($this->hasChanged('password')){
            $security =  new Security();
            $this->password =$security->hash($this->password);
        }
        if($this->email && !$this->pam_email){
            $pamEmail = new \PamWorker();
            $pamEmail->worker_id = $this->id;
            $pamEmail->login_account = $this->email;
            $pamEmail->login_type = 'email';
            if(!$pamEmail->save()){
                $this->appendMessage(
                    new Message(
                        "email权限保存失败"
                    )
                );
                return false;
            }
        }else{
            if($this->hasChanged('email')){
                $this->pam_email->login_account = $this->email;
                if(!$this->pam_email->save()){
                    $this->appendMessage(
                        new Message(
                            "email权限保存失败"
                        )
                    );
                    return false;
                }
            }
        }
        if($this->mobile && !$this->pam_mobile){
            $pamMobile = new \PamWorker();
            $pamMobile->worker_id = $this->id;
            $pamMobile->login_account = $this->mobile;
            $pamMobile->login_type = 'mobile';
            if(!$pamMobile->save()){
                $this->appendMessage(
                    new Message(
                        "mobile权限保存失败"
                    )
                );
                return false;
            }
        }else{
            if($this->hasChanged('mobile')){
                $this->pam_mobile->login_account = $this->mobile;
                if(!$this->pam_mobile->save()){
                    $this->appendMessage(
                        new Message(
                            "mobile权限保存失败"
                        )
                    );
                    return false;
                }
            }
        }
    }
    public function toDetailArray($columns = null){
        $worker = parent::toArray($columns);
        if($worker->poistion){
            $worker['position'] = $worker->position->toArray();
        }
        return $worker;
    }
}
