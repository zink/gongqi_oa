<?php
use Phalcon\Mvc\Dispatcher;
use Phalcon\Mvc\Controller;

class ControllerBase extends Controller{
    public function beforeExecuteRoute(Dispatcher $dispatcher){
        $this->auth = new \Component\Account\Auth();
        if(!$this->auth ->isLogin()){
            $dispatcher->forward(array('controller' => 'passport', 'action' => 'login'));
            return false;
        }

        $this->referer = preg_replace('/^(https?|ftp|file):\/\/[-A-Za-z0-9+&@#\%?=~_|!:,.;]+\//','',$this->request->getHTTPReferer());
        $this->account = \Worker::findFirst([
            'conditions'=>'id ='.$this->session->get('account')['account_id'],
            'columns'=>"id,department_id,position_id,avatar,name,mobile,tel,email"
        ])->toArray();
        $this->account['is_super'] = false;
        $this->account['resource'] = [];
        $account_role = \AccountAclRole::find([
            'conditions'=>"account_id=".$this->account['id'],
            'columns'=>'account_id,acl_role_id'
        ]);
        if ($account_role->count() > 0){
            $ids = array_keys(\Utils::array_change_key($account_role->toArray(),'acl_role_id'));
            $roles = AclRole::find([
                'conditions'=>"id in ('".implode("','",$ids)."')"
            ]);
            if ($roles->count() > 0){
                $resource = [];
                foreach ($roles as $role) {
                    $resource = array_merge($resource,json_decode($role->resource,1));
                    if($role->is_super == 'true'){
                        $this->account['is_super'] = true;
                    }
                }
                $this->account['resource'] = $resource;
            }
        }
        $this->view->_account = $this->account;
        if ($this->request->isAjax() || $this->request->get('download')) {
            $this->page = $this->request->get('page')?$this->request->get('page'):1;
            $this->limit = $this->request->get('limit')?$this->request->get('limit'):20;
            $this->offset = ($this->page - 1) * $this->limit;
            $this->view->setLayout('ajax');
        } else {
            $dispatcher->forward(array('controller' => 'backstage', 'action' => 'loadpage'));
        }
    }
    //数据操作事务
    protected function begin(){
        $this->db->begin();
    }
    protected function end($flag){
        if($flag){
            $this->db->commit();
        }else{
            $this->db->rollback();
        }
    }

    //数据操作事务end
    protected function sendMsg($msg='',$redirect='',$data = array()){
        $content = array('msg'=>$msg,'data'=>$data,'redirect'=>$redirect);
        return $this ->response ->setJsonContent($content) ;
    }

    protected function success($msg='',$redirect='' ,$data = array()){
        $msg = $msg != ''?$msg:'操作成功';
        $content = array('status'=>'success','msg'=>$msg,'data'=>$data,'redirect'=>$redirect);
        return $this ->response ->setJsonContent($content) ;
    }

    protected function error($msg='',$redirect='' ,$data = array()){
        $msg = $msg != ''?$msg:'操作失败';
        $content = array('status'=>'error','msg'=>$msg,'data'=>$data,'redirect'=>$redirect);
        return $this ->response ->setJsonContent($content) ;
    }
    //专门用来处理model error message
    protected function modelError($model,$redirect='' ,$data = array()){
        $msg = '';
        $messages = $model->getMessages();
        foreach ($messages as $item) {
            $msg .= $item."\n";
        }
        $content = array('status'=>'error','msg'=>$msg,'data'=>$data,'redirect'=>$redirect);
        return $this ->response ->setJsonContent($content) ;
    }
}
