<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class BandwidthController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('Bandwidth')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $this->view->bandwidth = $paginator->getPaginate();
    }
    public function editAction($id=null){
        if($id){
            $bw = \Bandwidth::findFirst($id);
            $bandwidth = $bw->toDetailArray();
            if(count($bandwidth['idc']) > 0){
                $idcId = [];
                foreach($bandwidth['idc'] as $item){
                    array_push($idcId,$item['idc_id']);
                }
                $bandwidth['idc_id'] = $idcId;
            }else{
                $bandwidth['idc_id'] = [];
            }
            $this->view->bandwidth = $bandwidth;
            $title = '带宽编辑';
        }else{
            $title = '新增带宽';
        }
        $this->view->title = $title;
        $this->view->breadcrumb = [
            array(
                'name'=>'带宽列表',
                'url'=>'bandwidth'
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
            $bw = \Bandwidth::findFirst($data['id']);
        }else{
            $bw = new \Bandwidth();
        }
        $bw->total = $data['total'];
        $bw->type = $data['type'];
        $bw->province = $data['province'];
        if($data['city']){
            $bw->city = $data['city'];
        }
        if($data['district']){
            $bw->district = $data['district'];
        }
        $bw->purchase_price = $data['purchase_price'];
        $bw->price = $data['price'];
        if($bw->save()){
            if($data['idc_id']){
                $idc = explode(',',$data['idc_id']);
                $bw->bandwidthIdc->delete();
                foreach($idc as $item){
                    $BwIdc = new \BandwidthIdc();
                    $BwIdc->bandwidth_id = $bw->id;
                    $BwIdc->idc_id = $item;
                    $BwIdc->save();
                }
            }
            $this->end(true);
            return $this->success('保存成功',$this->url->get('bandwidth/edit/'.$bw->id));
        }else{
            $msg = '';
            foreach ($bw->getMessages() as $message) {
                $msg .= $message;
            }
            $this->end(false);
            return $this->error($msg);
        }
    }
    public function deleteAction($id = null){
        if($id){
            $bw = \Bandwidth::findFirst($id);
            if($bw->delete()){
                return $this->success('删除成功');
            }else{
                return $this->error('删除失败');
            }
        }else{
            return $this->error('无此机房');
        }
    }
}
