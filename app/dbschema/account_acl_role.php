<?php
$db['account_acl_role'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'account_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '账户ID'
        ],
        'acl_role_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '角色ID'
        ],
    ],
    'comment' => '账户角色关联表',
    'index' => [
        'index_account_id' => [ 
            'columns' => [
                0 => 'account_id',
            ],
        ],
        'index_acl_id' => [ 
            'columns' => [
                0 => 'acl_role_id',
            ],
        ]
    ]
];
