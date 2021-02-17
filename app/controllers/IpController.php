<?php
use Phalcon\Paginator\Adapter\QueryBuilder;
class IpController extends ControllerBase {
    public function indexAction(){
        $builder = $this->modelsManager
            ->createBuilder()
            ->columns("*")
            ->from('IpPool')
            ->orderBy("create_time desc");

        $paginator = new QueryBuilder([
            "builder" => $builder,
            "limit" => $this->limit,
            "page" => $this->page
        ]);

        $this->view->ip = $paginator->getPaginate();
    }
    public function templateAction(){
        $file = $this->config->application->assetPath.'ip_template.csv';
        header('Content-Type: text/csv');
        header('Content-Disposition: attachment;filename="'.basename($file).'"');
        header('Cache-Control: max-age=0');
        // 如果您正在使用IE 9，则可能需要以下操作
        header('Cache-Control: max-age=1');

        // 如果您通过SSL服务于IE，则可能需要以下操作
        header ('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
        header ('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT'); // always modified
        header ('Cache-Control: cache, must-revalidate'); // HTTP/1.1
        header ('Pragma: public'); // HTTP/1.0
        readfile($file);
        exit;
    }
    public function upload_csvAction(){
        $file = current($this->request->getUploadedFiles());
        $handle = fopen($file->getTempName(),'r');
        if(!$handle){
            return $this->error('文件读取失败');
        }
        //stream_filter_append($handler, "convert.iconv.gbk/utf-8");
        $ip_list = [];
        while(($data = fgetcsv($handle)) !== false){
            if($data[0] == 'IP'){
                continue;
            }
            $ip_list[] = eval('return '.iconv('gbk','utf-8',var_export($data,true)).';');
        }
        fclose($handle);
        foreach($ip_list as $ip){
            $ipMdl = new \IpPool();
            $ipMdl->ip = $ip[0];
            $ipMdl->type = $ip[1];
            $ipMdl->province = $ip[2];
            $ipMdl->city = $ip[3];
            $ipMdl->district = $ip[4];
            $ipMdl->purchase_price = $ip[6];
            $ipMdl->price = $ip[7];
            if($ipMdl->save()){
                if($ip[5]){
                    $idc = explode(':',$ip[5]);
                    foreach($idc as $item){
                        $ipIdc = new \IpIdc();
                        $ipIdc->ip_id = $ipMdl->id;
                        $ipIdc->idc_id = $item;
                        $ipIdc->save();
                    }
                }
            };
        }
        return $this->success('导入成功');
    }
    public function editAction($id=null){
        if($id){
            $ipM = \IpPool::findFirst($id);
            $ip = $ipM->toDetailArray();
            if(count($ip['idc']) > 0){
                $idcId = [];
                foreach($ip['idc'] as $item){
                    array_push($idcId,$item['idc_id']);
                }
                $ip['idc_id'] = $idcId;
            }else{
                $ip['idc_id'] = [];
            }
            $this->view->ip = $ip;
        }
        $this->view->title = '新增IP';
        $this->view->breadcrumb = [
            array(
                'name'=>'IP列表',
                'url'=>'ip'
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
            $ip = \IpPool::findFirst($data['id']);
        }else{
            $ip = new \IpPool();
        }
        $ip->ip = $data['ip'];
        $ip->type = $data['type'];
        $ip->province = $data['province'];
        $ip->purchase_price = $data['purchase_price'];
        $ip->price = $data['price'];
        if($data['city']){
            $ip->city = $data['city'];
        }
        if($data['district']){
            $ip->district = $data['district'];
        }
        if($ip->save()){
            if($data['idc_id']){
                $idc = explode(',',$data['idc_id']);
                $ip->ipIdc->delete();
                foreach($idc as $item){
                    $ipIdc = new \IpIdc();
                    $ipIdc->ip_id = $ip->id;
                    $ipIdc->idc_id = $item;
                    $ipIdc->save();
                }
            }
            $this->end(true);
            return $this->success('保存成功',$this->url->get('ip/edit/'.$ip->id));
        }else{
            $msg = '';
            foreach ($ip->getMessages() as $message) {
                $msg .= $message;
            }
            $this->end(false);
            return $this->error($msg);
        }
    }
    public function deleteAction($id = null){
        if($id){
            $ip = \IpPool::findFirst($id);
            if($ip->delete()){
                return $this->success('删除成功');
            }else{
                return $this->error('删除失败');
            }
        }else{
            return $this->error('无此机房');
        }
    }
}
