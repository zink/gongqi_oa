<?php
use Phalcon\Mvc\Controller;
class BackstageController extends Controller {
    public function loadpageAction(){
        $this->_setAssets();
        $this->view->setLayout('index');
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

    //加载静态资源
    protected function _setAssets(){
        $cssList = [
            "plugins/fontawesome-free/css/all.min.css",
            "plugins/ionicons/css/ionicons.min.css",
            "plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css",
            "plugins/icheck-bootstrap/icheck-bootstrap.min.css",
            "dist/css/adminlte.min.css",
            "dist/css/style.css",
            "plugins/overlayScrollbars/css/OverlayScrollbars.min.css",
            "plugins/pace-progress/themes/black/pace-theme-flat-top.css",
            "plugins/jsoneditor/jsoneditor.min.css",
            "plugins/toastr/toastr.min.css",
            "plugins/summernote/summernote-bs4.css",
            "plugins/google/css/fonts.css",
            "plugins/datepicker/datepicker3.css",
            "plugins/daterangepicker/daterangepicker.css",
            "plugins/fullcalendar/main.min.css",
            "plugins/fullcalendar-daygrid/main.min.css",
            "plugins/fullcalendar-timegrid/main.min.css",
            "plugins/fullcalendar-bootstrap/main.min.css",
            "plugins/vue-tagsinput/vue-tagsinput.min.css"
        ];
        $jsList = [
            "plugins/jquery/jquery.min.js",
            "plugins/jquery-ui/jquery-ui.min.js",
            "plugins/jquery-fileupload/jquery.fileupload.js",
            "plugins/bootstrap/js/bootstrap.bundle.min.js",
            "plugins/pace-progress/pace.min.js",
            "plugins/chart.js/Chart.min.js",
            "plugins/sparklines/sparkline.js",
            "plugins/moment/moment.min.js",
            "plugins/datepicker/bootstrap-datepicker.js",
            "plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js",
            "plugins/daterangepicker/daterangepicker.js",
            "plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js",
            "plugins/summernote/summernote-bs4.min.js",
            "plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js",
            "plugins/toastr/toastr.min.js",
            "plugins/jsoneditor/jsoneditor.min.js",
            "plugins/bootbox/bootbox.all.min.js",
            "plugins/vue/vue.min.js",
            "plugins/vue-tagsinput/vue-tagsinput.min.js",
            "plugins/sortable/Sortable.min.js",
            "plugins/vue-draggable/vuedraggable.umd.min.js",
            "dist/js/adminlte.js",
            "plugins/moment/moment.min.js",
            "plugins/fullcalendar/main.min.js",
            "plugins/fullcalendar-daygrid/main.min.js",
            "plugins/fullcalendar-timegrid/main.min.js",
            "plugins/fullcalendar-interaction/main.min.js",
            "plugins/fullcalendar-bootstrap/main.min.js",
            "dist/js/districts.js",
            "dist/js/relax.js"
        ];
        //加载头部资源
        $assetPath = $this->config->application->assetUri;
        foreach($cssList as $css){
            $this->assets->collection('header')->addCss($assetPath.$css);
        }
        //加载底部资源
        foreach($jsList as $js){
            $this->assets->collection('footer')->addjs($assetPath.$js);
        }
    }
    public function finder_selectedAction($modelName = null,$id = null){
        if(!$modelName){
            return $this->error('未指定模型');
        }
        $id = explode(',',$id);
        $id = implode(',',$id);
        $modelName = "\\".ucfirst($modelName);
        $model = new $modelName;
        $this->view->list = $model::find("id in (".$id.")")->toArray();
        $this->view->columns = $model->getColumns();
    }
    public function finderAction($finder_id,$title = '',$modelName = null,$multiple = 'false'){
        if(!$modelName){
            return $this->error('未指定模型');
        }
        $modelName = "\\".ucfirst($modelName);
        $model = new $modelName;
        $page = $this->request->get('page')?$this->request->get('page'):1;
        $list = $model::find(array(
            'limit'=>20,
            'offset'=>($page - 1) * 20
        ));
        $this->view->title=$title;
        $this->view->list = $list->toArray();
        $this->view->last = ceil($model::count()/20);
        $this->view->finder_id = $finder_id;
        $this->view->columns = $model->getColumns();
        $this->view->multiple = $multiple == 'false'?false:true;
        if($this->request->get('onlydata')){
            $this->view->pick('backstage/finder_data');
        }
    }
}
