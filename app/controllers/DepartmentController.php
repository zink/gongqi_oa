<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class DepartmentController extends ControllerBase {
    public function indexAction(){}
    public function get_departmentAction($id = null){
        if($id == null){
            return $this->error('参数错误');
        }
        if($id == 0){
            return $this->response->setJsonContent(['id'=>0,'name'=>'顶级']);
        }
        $department = \Department::findFirst([
            "conditions"=>"id = ".$id,
            "columns"=>"id,parent_id,name,create_time",
        ]);
        return $this->response->setJsonContent($department->toArray());
    }
    public function department_modalAction(){
        $this->view->id = time();
        $this->view->pick('department/department_object/_modal');
    }
    public function get_listAction(){
        $query = [
            "columns"=>"id,parent_id,name,create_time",
        ];
        if(isset($this->requestFields['parent_id'])){
            $query['conditions'] = "parent_id =".$this->requestFields['parent_id'];
        };
        $department = \Department::find($query);
        return $this->response->setJsonContent($department);
    }
    public function get_detailAction($id = null){
        if($id == null){
            return $this->error('参数错误');
        }

        $department = \Department::findFirst($id);
        if(!$department){
            throw new \Exception('没有此部门');
        }
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("Worker.id,Worker.name,Worker.avatar,Worker.mobile,Worker.tel,Worker.email")->from('Worker')
            ->where("Worker.department_id = ".$id)
            ->orderBy("Worker.id desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $paginator = $paginator->getPaginate();
        $paginator->items = $paginator->items->toArray();
        $paginator->name = $department->name;
        $paginator->parent_id = $department->parent_id;
        $paginator->id = $department->id;

        if($department->id){
            return $this->success('成功',null,$paginator);
        }else{
            return $this->error('没有此部门');
        }
    }
    public function saveAction(){
        $data = $this->request->getPost();
        $this->begin();
        if($data['id']){
            $department = \Department::findFirst($data['id']);
            if(!$department){
                $this->end(false);
                return $this->error('没有此部门');
            }
            if($data['parent_id'] == $data['id']){
                $this->end(false);
                return $this->error('不能自关联');
            }
            if(count($data['delete_workers']) > 0){
                $workers = \Worker::find([
                    'conditions'=>"id in (".implode(',',$data['delete_workers']).") and department_id = ".$data['id']
                ]);
                foreach($workers as $worker){
                    $worker->department_id = 0;
                    if(!$worker->save()){
                        $this->end(false);
                        return $this->error('员工删除失败');
                    }
                }
            }
        }else{
            $department = new \Department();
        }
        $department->name = $data['name'];
        if($data['parent_id'] !== null){
            $department->parent_id = $data['parent_id'];
        }

        if($department->save()){
            if(count($data['workers']) > 0){
                $workers = \Worker::find([
                    'conditions'=>"id in (".implode(',',$data['workers']).")"
                ]);
                foreach($workers as $worker){
                    $worker->department_id = $data['id'];
                    if(!$worker->save()){
                        $this->end(false);
                        return $this->error('员工加入失败');
                    }
                }
            }
            $this->end(true);
            return $this->success('保存成功');
        }else{
            $this->end(false);
            $msg = '';
            $messages = $department->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            return $this->error($msg);
        }
    }

    public function deleteAction($id = null){
        if(!$id){
            return $this->error('错误的ID');
        }
        $this->begin();
        $department = \Department::findFirst($id);
        if(!$department){
            $this->end(false);
            return $this->error('没有该部门');
        }
        if($department->delete()){
            $this->end(true);
            return $this->success('成功');
        }else{
            $this->end(false);
            $msg = '';
            $messages = $department->getMessages();
            foreach ($messages as $item) {
                $msg .= $item;
            }
            return $this->error('删除失败');
        }
    }
}
