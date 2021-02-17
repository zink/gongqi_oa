<?php
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
class Department extends \BaseModel{
    public $id;
    public $parent_id;
    public $name;
    public function initialize(){
        parent::initialize();
        $this->hasMany('id','Worker','department_id');
        $this->hasMany('id','Department','parent_id');
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            ['parent_id','name'],
            new Uniqueness(
                [
                    'message'=>'已有相同部门'
                ]
            )
        );
        return $this->validate($validator);
    }
    public function beforeDelete(){
        foreach($this->Department as $item){
            $item->delete();
        }
        $sql = "UPDATE
                    worker
                SET
                    department_id = 0
                WHERE
                    department_id = ".$this->id."
        ";
        return $this->getDI()->getShared('db')->execute($sql);
    }
}
