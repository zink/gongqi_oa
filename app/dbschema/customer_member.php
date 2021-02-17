<?php
$db['customer_member'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'type' => [
            'type' => [ 
                'main'=>'主账户',
                'sub'=>'子账户'
            ],
            'required' => true,
            'default'=>'main',
            'comment' => '账户类型',
        ],
        'disabled' => [ 
            'type' => [ 
                'true'=>'禁用',
                'false'=>'可用'
            ],
            'required' => true,
            'default'=>'false',
            'comment' => '是否禁用',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '客户ID'
        ],
        'member_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '账户ID',
        ],
    ],
    'comment' => '客户账户关联表',
    'index' => [
        'index_customer_id' => [ 
            'columns' => [
                0 => 'customer_id',
            ],
        ],
        'index_member_id' => [ 
            'columns' => [
                0 => 'member_id',
            ],
        ]
    ]
];
