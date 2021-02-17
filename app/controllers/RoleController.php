<?php
class RoleController extends ControllerBase{
    public function indexAction(){
        $this->view->role = \AclRole::find();
    }
    public function editAction($id = null){
        if($id){
            $role = \AclRole::findFirst($id);
            $this->view->role = $role;
        }
        $this->view->acl = json_encode($this->access->acl);
    }
    public function get_rolesAction($id = null){
        $roles = \AclRole::find([
            'columns'=>'id,name,is_super'
        ]);
        $this->view->roles = $roles;
        $this->view->pick('role/_get_roles');
    }
    public function saveAction(){
        $postData = $this->request->getPost();
        if($postData['id']){
            $role = \AclRole::findFirst($postData['id']);
            if(!$role){
                return $this->error('没有此规则');
            }
        }else{
            $role = new \AclRole();
        }
        if (!empty($postData['resource']) && is_array($postData['resource'])) {
            $resource = $postData['resource'];
            $access = $this->access->acl;
            $postData['resource'] = json_encode($postData['resource']);
        }
        $role->name = $postData['name'];
        $role->resource = $postData['resource'];
        $role->is_super = $postData['is_super'];
        if($role->save()){
            return $this->success('保存成功',$this->url->get('role/edit/'.$role->id));
        }else{
            return $this->error('保存失败');
        }
    }
    public function deleteAction($id = null){
        if($id){
            $this->begin();
            $role = \AclRole::findFirst($id);

            if(!$role){
                $this->end(false);
                return $this->error('没有此角色规则');
            }
            if(!$role->delete()){
                $this->end(false);
                $msg = '';
                $messages = $role->getMessages();
                foreach ($messages as $item) {
                    $msg .= $item;
                }
                return $this->error($msg);
            }else{
                $this->end(true);
                return $this->success('删除成功');
            }
        }
    }
    public function save_account_roleAction($id = null){
        if(!$id){
            return $this->error('没有操作员');
        }
        $roleIds = $this->request->getPost('role');
        $this->begin();
        foreach($roleIds as $roleId){
            if(!\AccountAclRole::findFirst('account_id = '.$id.' and acl_role_id = '.$roleId)){
                $role = new \AccountAclRole();
                $role->account_id = $id;
                $role->acl_role_id = $roleId;
                if(!$role->save()){
                    $this->end(false);
                    return $this->error('保存失败');
                };
            }
        }
        $this->end(true);
        return $this->success('保存成功');
    }
}
