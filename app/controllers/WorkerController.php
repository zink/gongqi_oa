<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class WorkerController extends ControllerBase {
    public function indexAction(){
        $sql = '
            SELECT
                p.id,
                p.name,
                p.position_type_id,
                p.position_rank_id,
                r.rank,
                r.level,
                t.name AS position_type_name
            FROM 
                Position AS p
            Left JOIN 
                PositionRank AS r ON p.position_rank_id = r.id
            Left JOIN 
                PositionType AS t ON p.position_type_id = t.id
        ';
        $position = $this->modelsManager->executeQuery($sql);
        $position = $position->toArray();
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("
                w.id,
                w.name,
                w.avatar,
                w.mobile,
                w.tel,
                w.email,
                d.name as department,
                p.name as position,
                w.department_id,
                w.disabled
            ")
            ->addFrom('Worker','w')
            ->leftJoin('Department','w.department_id = d.id','d')
            ->leftJoin('Position','w.position_id = p.id','p')
            ->orderBy("w.id desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        $worker = json_decode(json_encode($paginator),1);
        if($worker['total_items'] > 0){
            foreach($worker['items'] as &$item){
                $roles = \AccountAclRole::find([
                    'conditions'=>'account_id='.$item['id']
                ]);
                if($roles->count() > 0){
                    foreach($roles as $role){
                        if($role->is_super){
                            $item['is_super'] = true;
                            break;
                        }else{
                            $aclRole = $role->aclRole;
                            if(!$item['roles']){
                                $item['roles'] = [];
                            }
                            $item['roles'][] = $aclRole->name;
                        };
                    }
                }
            }
        }
        $this->view->worker = $worker;
    }
    public function editAction($id=null){
        if($id){
            $worker = \Worker::findFirst($id);
            $this->view->worker = $worker->toDetailArray();
            $title = '员工编辑';
        }else{
            $title = '新增员工';
        }
        $sql = '
            SELECT
                p.id,
                p.name,
                p.position_type_id,
                p.position_rank_id,
                r.rank,
                r.level,
                t.name AS position_type_name
            FROM 
                Position AS p
            Left JOIN 
                PositionRank AS r ON p.position_rank_id = r.id
            Left JOIN 
                PositionType AS t ON p.position_type_id = t.id
        ';
        $position = $this->modelsManager->executeQuery($sql)->toArray();
        $this->view->position = $position;
        $this->view->title = $title;
        $this->view->breadcrumb = [
            array(
                'name'=>'员工列表',
                'url'=>'worker'
            ),
            array(
                'name'=>$title
            )
        ];
    }
    public function saveAction(){
        $data = $this->request->getPost();
        $this->begin();
        if($data['id']){
            $worker = \Worker::findFirst($id);
            if(!$worker){
                $this->end(false);
                return $this->error('没有该员工',404);
            }
            foreach($data as $key=>$value){
                if($value){
                    $worker->{$key} = $value;
                }
            }
        }else{
            $worker = new \Worker();
            $worker->name     = $data['name'];
            $worker->email    = $data['email'];
            $worker->sex      = $data['sex'];
            if(!$data['email']){
                $this->end(false);
                return $this->error('邮箱必填');
            }
            if(!$data['mobile']){
                $this->end(false);
                return $this->error('手机必填');
            }
            if($data['password']){
                $worker->password = $data['password'];
            }else{
                $this->end(false);
                return $this->error('没有密码');
            }
            if($data['mobile']){
                $worker->mobile = $data['mobile'];
            }
            if($data['department_id']){
                $worker->department_id = \Department::count($data['department_id'])?$data['department_id']:0;
            }
            /*保存认证表*/
            $pamEmail = new \PamWorker();
            $pamEmail->login_account = $data['email'];
            $pamEmail->login_type = 'email';
            $worker->pam_email = $pamEmail;
            $pamMobile = new \PamWorker();
            $pamMobile->login_account = $data['mobile'];
            $pamMobile->login_type = 'mobile';
            $worker->pam_mobile = $pamMobile;
        }
        if($worker->save()){
            $this->end(true);
            return $this->success('保存成功',$this->url->get('worker/edit/'.$worker->id));
        }else{
            $msg = '';
            foreach ($worker->getMessages() as $message) {
                $msg .= $message;
            }
            $this->end(false);
            return $this->error($msg);
        }
    }
    public function worker_modalAction($multiple = 0){
        $this->view->multiple = $multiple;
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("
                w.id,
                w.name,
                w.avatar,
                w.mobile,
                w.tel,
                w.email,
                d.name as department,
                p.name as position,
                w.department_id,
                w.disabled
            ")
            ->addFrom('Worker','w')
            ->leftJoin('Department','w.department_id = d.id','d')
            ->leftJoin('Position','w.position_id = p.id','p')
            ->orderBy("w.id desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();

        $this->view->worker = json_decode(json_encode($req),1);
        $this->view->pick('worker/worker_object/_modal');
    }
    public function get_listAction(){
        $ids = $this->request->get('id');
        $worker = [];
        if(count($ids) > 0){
            foreach($ids as $id){
                $workerTmp = \Worker::findFirst($id);
                if($workerTmp->id){
                    $worker[] = $workerTmp->toDetailArray();
                }
            }
        }
        return $this->response->setJsonContent($worker);
    }
    public function disabledAction($id = null){
        if($id){
            $this->begin();
            $worker = \Worker::findFirst($id);
            if(!$worker){
                $this->end(false);
                return $this->error('没有此员工');
            }
            $worker->disabled = 'true';
            if($worker->save()){
                $this->end(true);
                return $this->success('禁用成功');
            }else{
                $this->end(false);
                $msg = '';
                foreach ($worker->getMessages() as $message) {
                    $msg .= $message;
                }
                return $this->error($msg);
            }
        }else{
            return $this->error('没有此员工');
        }
    }
    public function enableAction($id = null){
        if($id){
            $this->begin();
            $worker = \Worker::findFirst($id);
            if(!$worker){
                $this->end(false);
                return $this->error('没有此员工');
            }
            $worker->disabled = 'false';
            if($worker->save()){
                $this->end(true);
                return $this->success('启用成功');
            }else{
                $this->end(false);
                $msg = '';
                foreach ($worker->getMessages() as $message) {
                    $msg .= $message;
                }
                return $this->error($msg);
            }
        }else{
            return $this->error('没有此员工');
        }
    }
    public function reset_pwdAction(){}
    public function save_pwdAction(){
        $data = \Utils::inputFilter($this->request->getPost());
        if(!$data['password']){
            return $this->error('密码错误');
        }
        if(!$data['new_password']){
            return $this->error('新密码不能为空');
        }
        if(!$data['confirm_password']){
            return $this->error('请重复新密码');
        }
        if($data['new_password'] !== $data['confirm_password']){
            return $this->error('新密码不一致');
        }
        $validation = new \Validation\Worker\Signin();
        $username = $this->account['email']?$this->account['email']:$this->account['mobile'];
        $password = $data['password'];
        $messages = $validation->validate([
            'username'=>$username,
            'password'=>$password
        ]);
        if (count($messages)) {
            foreach ($messages as $message) {
                throw new \Exception($message);
            }
        }
        $this->begin();
        $pamWorker = new \PamWorker();
        try{
            $worker = $pamWorker->checkLogin($username, $password);
        }catch( \Exception $e){
            return $this->error($e->getMessage());
        }
        $worker->password = $data['new_password'];
        if($worker->save()){
            $this->end(true);
            return $this->success('保存成功',$this->url->get('worker/reset_pwd'));
        }else{
            $this->end(false);
            return $this->error($worker['error_description']);
        }
    }
}
