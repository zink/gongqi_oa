<?php
class RankController extends ControllerBase {
    public function indexAction(){
        $ranksTmp = \PositionRank::find([
            "columns"=>"id,level,rank,create_time",
            "order"=>"level desc"
        ])->toArray();
        $ranks = [];
        foreach($ranksTmp as $rank){
            if(!$ranks[$rank['rank']]){
                $ranks[$rank['rank']] = [];
            }
            $ranks[$rank['rank']][] = $rank;
        }
        $this->view->rank = json_encode($ranks);

        $this->view->position_type = json_encode(\PositionType::find([
            "columns"=>"id,name,create_time"
        ])->toArray());

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
        $positions = $this->modelsManager->executeQuery($sql);
        $positions = $positions->toArray();
        if(count($positions) > 0){
            $_returnPosition = [];
            foreach($positions as $item){
                $_id = $item['position_rank_id'].':'.$item['position_type_id'];
                if(!$_returnPosition[$_id]){
                    $_returnPosition[$_id] = [];
                }
                array_push($_returnPosition[$_id],$item);
            }
            $this->view->position = json_encode($_returnPosition); 
        }else{
            $this->view->position = '{}';
        }
    }
    public function editAction($id = null){
        if($id){
            $rank = \PositionRank::findFirst([
                "conditions"=>"id = ".$id,
                "columns"=>"id,level,rank,create_time"
            ]);
            $this->view->rank = $rank->toArray();
            $title = '职级职等编辑';
        }else{
            $title = '新建职级职等';
        }
        $this->view->title = $title;
        $this->view->breadcrumb = [
            array(
                'name'=>'职级职等列表',
                'url'=>'rank'
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
            $rank = \PositionRank::findFirst($data['id']);
            if(!$rank){
                $this->end(false);
                return $this->error('没有此职级');
            }
        }else{
            $rank = new \PositionRank();
        }
        $rank->rank = $data['rank'];
        $rank->level = $data['level'];
        if($rank->save()){
            $this->end(true);
            return $this->success('保存成功',$this->url->get('rank'));
        }else{
            $msg = '';
            foreach ($rank->getMessages() as $message) {
                $msg .= $message;
            }
            $this->end(false);
            return $this->error($msg);
        }
    }
    //保存更新职务分类
    public function save_typeAction(){
        $data = $this->request->getPost();
        $this->begin();
        if($data['id']){
            $type = \PositionType::findFirst($data['id']);
            if(!$type){
                $this->end(false);
                return $this->error('没有此职位分类');
            }
        }else{
            $type = new \PositionType();
        }
        $type->name = $data['name'];
        if($type->save()){
            $this->end(true);
            return $this->success('保存成功',null,$type->id);
        }else{
            $this->end(false);
            $msg = '';
            foreach ($type->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    //保存更新职务
    public function save_positionAction(){
        $data = $this->request->getPost();
        $this->begin();
        if($data['id']){
            $position = \Position::findFirst($data['id']);
            if(!$position){
                $this->end(false);
                return $this->error('没有此职级');
            }
        }else{
            $position = new \Position();
        }
        $position->name =$data['name'];
        if(isset($data['position_rank_id'])){
            $position->position_rank_id = $data['position_rank_id'];
        }
        if(isset($data['position_type_id'])){
            $position->position_type_id = $data['position_type_id'];
        }
        if($position->save()){
            $this->end(true);
            return $this->success('保存成功',null,$position->id);
        }else{
            $this->end(false);
            $msg = '';
            foreach ($position->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
    //删除职位
    public function delete_positionAction($id = null){
        if(!$id){
            return $this->error('无此职级');
        }
        $this->begin();
        $position = \Position::findFirst($id);
        if(!$position){
            $this->end(false);
            return $this->error('无此职级');
        }
        if($position->delete()){
            $this->end(true);
            return $this->success('删除成功');
        }else{
            $this->end(false);
            return $this->error('删除失败');
        }

    }
    public function deleteAction($id = null){
        if(!$id){
            return $this->error('错误的ID');
        }
        $this->begin();
        $rank = \PositionRank::findFirst($id);
        if(!$rank){
            $this->end(false);
            return $this->error('没有此职级职等');
        }
        if($rank->delete()){
            $this->end(true);
            return $this->success('删除成功');
        }else{
            $this->end(false);
            $msg = '';
            foreach ($rank->getMessages() as $message) {
                $msg .= $message;
            }
            return $this->error($msg);
        }
    }
}
