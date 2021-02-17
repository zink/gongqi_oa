<?php
namespace Component;
use Phalcon\Mvc\User\Component;
class FunctionExtension extends Component{
    public function compileFunction($name, $arguments){
        if (function_exists($name)) {
            return $name . "(". $arguments . ")";
        }elseif(method_exists($this , $name)){
            return "call_user_func_array(array(new \\Component\\FunctionExtension() ,'$name') ,array($arguments))";
        }
    }


    public function compileFilter($name, $arguments){
        if (function_exists($name)) {
            return $name . "(". $arguments . ")";
        }elseif(method_exists($this , $name)){
            return "call_user_func_array(array(new \\Component\\FunctionExtension() ,'$name') ,array($arguments))";
        }
    }
    /*页面相关*/
    public function content_body($params = []){
        $params['class'] = 'content '.$params['class'];
        $attr = [];
        foreach($params as $index=>$item){
            $attr[] = $index.'="'.$item.'"';
        }
        return "<section ".implode(' ',$attr)."><div class=\"container-fluid\">";
    }
    public function end_content_body(){
        return "</div></section>";
    }

    //对象选择
    public function input_object($params){
        $params['input_id'] = 'f_'.$this->_apply_id(8);
        return $this->view->getPartial('backstage/input_object' , $params);
    }
    //翻页
    public function pagination($params){
        $query = $this->request->getQuery();
        $url =  $query['_url'];
        unset($query['_url']);
        $page = $query['page']?$query['page']:1;
        $params['current']   = $page;
        $params['first']     = 1; $params['first_url'] = $this->url->get($url,array_merge($query,array('page'=>$params['first'])));
        $params['prev']      = max(1,$page - 1);
        $params['prev_url']  = $this->url->get($url,array_merge($query,array('page'=>$params['prev'])));
        $params['next']      = min($page + 1,$params['last']);
        $params['next_url']  = $this->url->get($url,array_merge($query,array('page'=>$params['next'])));
        $params['last_url']  = $this->url->get($url,array_merge($query,array('page'=>$params['last'])));
        $params['pagination_id'] = 'p_'.$this->_apply_id(8);
        return $this->view->getPartial('backstage/pagination' , $params);
    }
    //上传文件
    public function upload_object($params = null){
        $params['id'] = 'upload_'.$this->_apply_id();
        return $this->view->getPartial('backstage/upload_object/object',$params);
    }
    //地址选择
    public function address_object($params = null){
        $params['id'] = 'addr_'.$this->_apply_id(8);
        return $this->view->getPartial('backstage/address_object/object' , $params);
    }
    //搜索
    public function search($params){
        if(!$params['url']){
            return 'search组件,需要url参数';
        }
        $params['id'] = 'sh_'.$this->_apply_id();
        $params['url'] = $this->url->get($params['url']);
        return $this->view->getPartial('backstage/search',$params);
    }
    //标题
    public function content_header($params){
        return $this->view->getPartial('backstage/content_header',$params);
    }
    //全选框
    public function select_all(){
        $params['id'] = 'se_'.$this->_apply_id();
        return $this->view->getPartial('backstage/select_all',$params);
    }
    //批量操作
    public function batch($params = []){
        $params['id'] = 'ba_'.$this->_apply_id();
        return $this->view->getPartial('backstage/batch',$params);
    }
    //fixed btn bar
    public function fixed_bar($params){
        return $this->view->getPartial('backstage/fixed_bar',$params);
    }
    public function data_table_head(){
        return $this->view->getPartial('backstage/data_table_head',$params);
    }
    //department object
    public function department_object($params = []){
        $params['id'] = 'dpo_'.$this->_apply_id(8);
        return $this->view->getPartial('department/department_object/object',$params);
    }
    public function worker_object($params = []){
        $params['id'] = 'worker_'.$this->_apply_id(8);
        return $this->view->getPartial('worker/worker_object/object',$params);
    }
    public function idc_object($params = []){
        $params['id'] = 'idc_'.$this->_apply_id(8);
        return $this->view->getPartial('idc/idc_object/object',$params);
    }
    //权限校验
    public function permission($acl = '',$menu = false){
        if($this->view->_account['is_super']){
            return true;
        }
        if($menu){
            $top = [];
            foreach($this->access->acl as $key=>$actions){
                if($key == $acl){
                    foreach($actions->actions as $control=>$action){
                        foreach($action as $item){
                            $acl = $control.'-'.$item->action;
                            $top[] = $acl;
                        }
                    }
                    break;
                }
            }
            $intersect = array_intersect($top,$this->view->_account['resource']);
            if(count($intersect) > 0){
                return true;
            }else{
                return false;
            }
        }else{
            return in_array($acl,$this->view->_account['resource']);
        }
    }
    //生成随机id
    private function _apply_id($length = 6){
        $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $id = time().'_';
        for ($i = 0; $i < $length; $i++) {
            $id .= $chars[mt_rand(0, strlen($chars) - 1)];
        }
        return $id;
    }
}
