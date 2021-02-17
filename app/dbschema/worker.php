<?php
$db['worker'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'department_id' => array(
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '部门ID',
        ),
        'position_id' => array(
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '职位ID',
        ),
        'password' => array(
            'type' => 'varchar(255)',
            'required' => true,
            'comment' => '登陆密码',
        ),
        'avatar' => array(
            'type' => 'varchar(255)',
            'required' => false,
            'default'=>'',
            'comment' => '头像',
        ),
        'name' => array(
            'type' => 'varchar(20)',
            'required' => false,
            'default'=>'',
            'comment' => '姓名',
        ),
        'mobile' => array(
            'type' => 'varchar(11)',
            'required' => false,
            'default'=>'',
            'comment' => '手机号码',
        ),
        'tel' => array(
            'type' => 'varchar(50)',
            'required' => false,
            'default'=>'',
            'comment' => '固定电话',
        ),
        'email' => array(
            'type' => 'varchar(50)',
            'required' => false,
            'default'=>'',
            'comment' => '邮件',
        ),
        'b_year' => array(
            'type' => 'varchar(50)',
            'required' => false,
            'default'=>'',
            'comment' => '生年',
        ),
        'b_month' => array(
            'type' => 'varchar(50)',
            'required' => false,
            'default'=>'',
            'comment' => '生月',
        ),
        'b_day' => array(
            'type' => 'varchar(50)',
            'required' => false,
            'default'=>'',
            'comment' => '生日',
        ),
        'sex' => array(
            'type' => array(
                'male'=>'男',
                'female'=>'女',
            ),
            'required' => false,
            'comment' => '性别',
        ),
        'reg_ip' => array(
            'type' => 'varchar(16)',
            'required' => false,
            'default'=>null,
            'comment' => '注册时IP地址',
        ),
        'login_count' => array(
            'type' => 'int(11)',
            'required' => false,
            'default'=>0,
            'comment' => '登陆次数',
        ),
        'remark' => array(
            'type' => 'text',
            'required' => false,
            'default'=>null,
            'comment' => '备注',
        ),
        'disabled' => array(
            'type' => array(
                'true'=>'禁用',
                'false'=>'可用'
            ),
            'required' => false,
            'default'=>'false',
            'comment' => '是否禁用',
        ),
    ),
    'comment' => ('工作者表'),
    'index' => array(
        'index_department_id'=>array(
            'columns' => array(
                0 => 'department_id',
            )
        ),
        'index_position_id'=>array(
            'columns' => array(
                0 => 'position_id',
            )
        ),
        'index_mobile'=>array(
            'columns' => array(
                0 => 'mobile',
            ),
            'prefix' => 'UNIQUE'
        ),
        'index_email'=>array(
            'columns' => array(
                0 => 'email',
            ),
            'prefix' => 'UNIQUE'
        ),
    )
);
