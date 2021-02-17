<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Message as Message;
class PositionRank extends \BaseModel{
    public $id;
    public $name;
    public $level;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id','Position','position_rank_id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            ['rank','level'],
            new Uniqueness(
                [
                    'message'=>'职等职级已存在',
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeDelete(){
        if($this->position->count() > 0){
            $message = new Message("该职级有职位，请先移除职位");
            $this->appendMessage($message);
            return false;
        }
    }
}
