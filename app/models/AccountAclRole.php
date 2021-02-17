<?php
class AccountAclRole extends \BaseModel{
    public $id;
    public $account_id;
    public $acl_role_id;
    public function initialize(){
        parent::initialize();
        $this->belongsTo('acl_role_id', 'AclRole', 'id');
        $this->belongsTo(
            'acl_role_id',
            'AclRole',
            'id',
            [
                'alias'=>'is_super',
                'params'=>[
                    'conditions'=>"is_super = 'true'"
                ]
            ]
        );
    }
}
