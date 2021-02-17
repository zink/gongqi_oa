<?php
use Phalcon\Mvc\Model\Message as Message;
class AclRole extends \BaseModel{
    public $id;
    public $name;
    public $resource;
    public $is_super;
    public function initialize(){
        parent::initialize();
        $this->hasMany("id","AccountAclRole","acl_role_id");
    }
    public function beforeDelete(){
        if($this->AccountAclRole->count() > 0){
            $message = new Message("角色下有操作员，请先删除操作员");
            $this->appendMessage($message);
            return false;
        }
        return true;
    }
}
