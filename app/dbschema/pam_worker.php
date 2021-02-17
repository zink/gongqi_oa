<?php
$db['pam_worker'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'worker_id' => array(
            'type' => 'number',
            'required' => true,
            'comment' => ('工作者ID')
        ),
        'login_account' => array(
            'type' => 'varchar(100)',
            'required' => true,
            'comment' => '登陆帐户'
        ),
        'login_type' => array(
            'type' => array(
                'mobile'=>'手机类型',
                'email'=>'邮箱类型',
            ),
            'default' => 'email',
            'required' => true,
            'comment' => '登陆类型',
        ),
    ),
    'comment' => ('工作者帐户表'),
    'index' => array(
        'index_worker_id'=>array(
            'columns' => array(
                0 => 'worker_id',
            ),
        ),
        'index_login_account'=>array(
            'columns' => array(
                0 => 'login_account',
            ),
        )
    )
);
