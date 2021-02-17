<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Message as Message;
class Position extends \BaseModel{
    public $id;
    public $name;
    public $position_rank_id;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id','Worker','position_id');
        $this->belongsTo('position_rank_id','PositionRank','id');
        $this->belongsTo('position_type_id','PositionType','id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            ['name','position_rank_id'],
            new Uniqueness(
                [
                    'message'=>'该职级职等下职位已经存在',
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeDelete(){
        if($this->worker->count() > 0){
            $message = new Message("该职级下有员工，请先移除员工");
            $this->appendMessage($message);
            return false;
        }
    }
}
