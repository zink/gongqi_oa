<?php
$db['acl_role'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'name' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '角色名称',
        ],
        'resource' => [
            'type' => 'longtext',
            'comment' => '权限资源',
        ],
        'is_super' => [
            'type' => 'bool',
            'required' => true,
            'default' => 'false',
            'comment' => '是否超级管理员',
        ]
    ],
    'comment' => '权限角色',
    'index' => [
        'index_name' => [ 
            'columns' => [
                0 => 'name',
            ],
        ]
    ]
];
