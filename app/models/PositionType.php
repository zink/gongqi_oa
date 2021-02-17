<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Mvc\Model\Message as Message;
class PositionType extends \BaseModel{
    public $id;
    public $name;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id','Position','position_type_id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            'name',
            new Uniqueness(
                [
                    'message'=>'职位分类已经存在',
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeDelete(){
        $positions = $this->position;
        if($positions->count() > 0){
            foreach($positions as $position){
                $position->position_type_id = 0;
                if(!$position->save()){
                    $message = new Message("职位重置错误");
                    $this->appendMessage($message);
                    return false;
                }
            }
        }
        return true;
    }
}
