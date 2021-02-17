<?php
use Phalcon\Cli\Task;

class DbTask extends Task{
    var $datatypes = array(
        'money' => array(
            'sql' => 'decimal(20,3)',
            'match' => '[0-9]{1,18}(\.[0-9]{1,3}|)',
        ),
        'email' => array(
            'sql' => 'varchar(255)'
        ) ,
        'bn' => array(
            'sql' => 'varchar(255)'
        ) ,
        'html' => array(
            'sql' => 'text',
        ) ,
        'bool' => array(
            'sql' => 'enum(\'true\',\'false\')'
        ) ,
        'time' => array(
            'sql' => 'integer(10) unsigned'
        ) ,
        'cdate' => array(
            'sql' => 'integer(10) unsigned'
        ) ,
        'intbool' => array(
            'sql' => 'enum(\'0\',\'1\')'
        ) ,
        'region' => array(
            'sql' => 'varchar(255)'
        ) ,
        'password' => array(
            'sql' => 'varchar(32)'
        ) ,
        'tinybool' => array(
            'sql' => 'enum(\'Y\',\'N\')'
        ) ,
        'number' => array(
            'sql' => 'mediumint unsigned'
        ) ,
        'float' => array(
            'sql' => 'float'
        ) ,
        'gender' => array(
            'sql' => 'enum(\'male\',\'female\')',
        ) ,
        'ipaddr' => array(
            'sql' => 'varchar(20)',
        ) ,
        'serialize' => array(
            'sql' => 'longtext',
        ) ,
        'last_modify' => array(
            'sql' => 'integer(10) unsigned'
        ),
    );

    //运行数据库迁移任务
    function mainAction(){
        $update_info = $this->diff();
        if($update_info){
            $this->merge($update_info);
        }
    }

    //通过dbschema获取sql语句
    function get_sql($tableName=null,$tmpName = null){
        $define = $this->load($tableName);
        $rows = array();
        foreach($define['columns'] as $k=>$v){
            $rows[] = '`'.$k.'` '.$this->get_column_define($v);
        }
        if($define['pkeys']){
            $rows[] = $this->get_index_sql('PRIMARY',$tableName);
        }
        if(is_array($define['index'])){
            foreach($define['index'] as $key=>$value){
                $rows[] = $this->get_index_sql($key,$tableName);
            }
        }
        if($tmpName){
            $sql = 'CREATE TABLE `'.$tmpName."` (\n\t".implode(",\n\t",$rows)."\n)";
        }else{
            $sql = 'CREATE TABLE `'.$tableName."` (\n\t".implode(",\n\t",$rows)."\n)";
        }
        $sql.= 'ENGINE = InnoDB DEFAULT CHARACTER SET utf8;';
        return $sql;
    }
    //读取dbschema文件
    function load($tableName){
        require($this->config->application->dbschemaDir.($tableName).'.php');
        $define = $db[$tableName];
        $define['columns']['create_time'] = array(
            'type' => 'time',
            'label' => ('数据创建时间') ,
        );
        $define['columns']['update_time'] = array(
            'type' => 'time',
            'label' => ('数据更新时间') ,
        );
        foreach($define['columns'] as $k=>$v){
            if($v['pkey']){
                $define['idColumn'][$k] = $k;
            }
            $define['columns'][$k] = $this->_prepare_column($k, $v);
            if(isset($v['pkey']) && $v['pkey']){
                $define['pkeys'][$k] = $k;
            }
        }
        if(!$define['idColumn']){
            $define['idColumn'] = key($define['columns']);
        }elseif(count($define['idColumn'])==1){
            $define['idColumn'] = current($define['idColumn']);
        }
        return $define;
    }

    function get_column_define($v){
        $r = $v['realtype'];
        if(isset($v['required']) && $v['required']){
            $r.=' not null';
        }
        if(isset($v['default'])){
            if($v['default']===null){
                $r.=' default null';
            }elseif(is_string($v['default'])){
                $r.=' default \''.$v['default'].'\'';
            }else{
                $r.=' default '.$v['default'];
            }
        }
        if(isset($v['extra'])){
            $r.=' '.$v['extra'];
        }
        if(isset($v['comment'])){
            $r .= ' comment \'' . $v['comment'] . '\'';
        }elseif(isset($v['label'])){
            $r .= ' comment \'' . $v['label'] . '\'';
        }
        return $r;
    }

    function _prepare_column($col_name, $col_set){
        $col_set['realtype'] = $col_set['type'];
        if(is_array($col_set['type'])){
            $col_set['realtype'] = 'enum(\''.implode('\',\'',array_keys($col_set['type'])).'\')';
        }elseif($this->type_define($col_set['type'])){
            $col_set['realtype'] = $this->type_define($col_set['type']);
        }

        if(substr(trim($col_set['realtype']),-4,4)=='text'){
            unset($col_set['default']);
        }else{
            //int
            $col_set['realtype'] = str_replace('integer','int',$col_set['realtype']);
            if(false===strpos($col_set['realtype'],'(')){
                $int_length = 0;
                if(false!==strpos($col_set['realtype'],'tinyint')){
                    $int_length = 4;
                }elseif(false!==strpos($col_set['realtype'],'smallint')){
                    $int_length = 6;
                }elseif(false!==strpos($col_set['realtype'],'mediumint')){
                    $int_length = 9;
                }elseif(false!==strpos($col_set['realtype'],'bigint')){
                    $int_length = 20;
                }elseif(false!==strpos($col_set['realtype'],'int')){
                    $int_length = 11;
                }
                if($int_length){
                    if($int_length<20 && false!==strpos($col_set['realtype'],'unsigned')){
                        $int_length--;
                    }
                    $col_set['realtype'] = str_replace('int','int('.$int_length.')',$col_set['realtype']);
                }
            }
        }
        return $col_set;
    }

    function type_define($type){
        //require($this->config->application->libraryDir.'datatypes.php');
        $types = array();
        foreach($this->datatypes as $k=>$v){
            if($v['sql']){
                $types[$k] = $v['sql'];
            }
        }
        return isset($types[$type])?$types[$type]:false;
    }


    private function get_current_define($tbname){
        $define = $this->db->fetchAll("show tables like '".$tbname."'");
        if(!empty($define)){
            $rows = $this->db->fetchAll('show columns from '.$tbname);
            $columns = array();
            if($rows){
                foreach($rows as $c){
                    $columns[$c['Field']] = array(
                        'type'=>$c['Type'],
                        'default'=>$c['Default'],
                        'required'=>!($c['Null']=='YES'),
                    );
                }
            }
            $rows = $this->db->fetchAll('show index from '.$tbname);
            $index = array();
            if($rows){
                foreach($rows as $row){
                    $index[$row['Key_name']] = array(
                        'Column_name'=>$row['Column_name'],
                        'Non_unique'=>$row['Non_unique'],
                        'Collation'=>$row['Collation'],
                        'Sub_part'=>$row['Sub_part'],
                        'Index_type'=>$row['Index_type'],
                    );
                }
            }
            return array('columns'=>$columns, 'index'=>$index);
        }else{
            return false;
        }
    }


    function get_index_sql($name,$tableName){
        $define = $this->load($tableName);
        foreach ($define['pkeys'] as $k => $pkey) {
            $define['pkeys'][$k] = '`'.$pkey.'`';
        }
        if($name=='PRIMARY'){
            if($define['pkeys']){
                return 'primary key ('.implode(',',$define['pkeys']).')';
            }
        }else{
            $value = $define['index'][$name];

            return $value['prefix'].' INDEX '.$name.($value['type']?(' USING '.$value['type']):'').'(`'.implode('`,`',$value['columns']).'`)';
        }
    }

    function diffSql($tableName){
        if(!$tableName){
            return array();
        }
        $diff = array();
        $old_define = $this->get_current_define($tableName);
        if($old_define){
            $tb_define = $this->load($tableName);
            $tmp_table = 'tmp_'.uniqid();
            if(!$this->db->execute($this->get_sql($tableName,$tmp_table))){
                return false;
            }
            $new_define = $this->get_current_define($tmp_table);
            $this->db->execute('drop table if exists '.$tmp_table);

            if($new_define==$old_define){
                return array();
            }else{
                foreach($new_define['columns'] as $key=>$define){
                    if(isset($old_define['columns'][$key])){
                        if($old_define['columns'][$key] != $new_define['columns'][$key]){
                            if(!$old_define['columns'][$key]['required'] && $new_define['columns'][$key]['required']){
                                $default=$new_define['default']?$new_define['default']:"''";
                                $diff[] = "update {$tableName} set `{$key}`={$default} where `{$key}`=null;\n";
                            }
                            $alter[]='MODIFY COLUMN `'.$key.'` '.$this->get_column_define($tb_define['columns'][$key]);
                        }
                    }else{
                        $alter[]='ADD COLUMN `'.$key.'` '.$this->get_column_define($tb_define['columns'][$key]).' '.($last?('AFTER '.$last):'FIRST');
                    }
                    unset($old_define['columns'][$key]);
                    $last = $key;
                }

                if(is_array($old_define['columns'])){
                    foreach($old_define['columns'] as $c=>$def){
                        $alter[]='DROP COLUMN `'.$c.'`'; //设置默认值或者允许空值
                    }
                }

                if($alter){
                    $diff[]='ALTER TABLE `'.$tableName."` \n\t".implode(",\n\t",$alter).';';
                }

                //todo: 索引和主键

                $old_define_index = $old_define['index'];

                foreach($new_define['index'] as $key=>$define){
                    if(isset($old_define['index'][$key])){
                        if($old_define['index'][$key] != $new_define['index'][$key]){
                            print_r($old_define['index'][$key]);
                            print_r($new_define['index'][$key]);
                            echo "=====================\n";
                            $diff[] = 'ALTER TABLE `'.$tableName.'` DROP PRIMARY KEY, ADD '.$this->get_index_sql($key,$tableName);
                        }
                        unset($old_define_index[$key]);
                    }else{
                        $diff[] = 'ALTER TABLE `'.$tableName.'` ADD '.$this->get_index_sql($key,$tableName);
                    }
                }

                if(is_array($old_define_index)){
                    foreach($old_define_index AS $key=>$define){
                        if($key === 'PRIMARY'){
                            $diff[] = 'ALTER TABLE `'.$tableName.'` DROP PRIMARY KEY';
                        }else{
                            $diff[] = 'ALTER TABLE `'.$tableName.'` DROP KEY `' . $key . '`';
                        }
                    }
                }
            }
        }else{
            $diff[]= $this->get_sql($tableName);
        }
        return $diff;
    }
    //获取dbschema文件
    function getDbschemaIterator($DirIterator){
        if($DirIterator){
            foreach($DirIterator as $key=>$item){
                if(!$item->isDot() && $item->isFile()){
                    yield substr($item->getFilename(),0,-4);
                }
            }
        }
    }

    function diff(){
        $diff = array();
        $dbschemaDir = new \DirectoryIterator($this->config->application->dbschemaDir);
        $dbschemaIterator = $this->getDbschemaIterator($dbschemaDir);
        foreach($dbschemaIterator as $item){
            $item_sql_arr = $this->diffSql(strtolower($item));
            if(is_array($item_sql_arr)){
                $diff = array_merge($diff, $item_sql_arr);
            }
        }
        return $diff;
    }

    function merge($diff){
       if($diff){
            foreach($diff as $sql ){
                print_r($sql);
                $this->db->execute($sql);
                echo PHP_EOL.'ok!'.PHP_EOL;
            }
        }
    }

}
