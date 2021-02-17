<?php
$db['customer_invoice'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '客户ID'
        ],
        'title' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '抬头'
        ],
        'tax_number' => [ 
            'type' => 'varchar(30)',
            'required' => true,
            'default'=>'',
            'comment' => '税号',
        ],
        'bank' => [ 
            'type' => 'varchar(30)',
            'required' => true,
            'default'=>'',
            'comment' => '开户行',
        ],
        'bank_account' => [ 
            'type' => 'varchar(30)',
            'required' => true,
            'default'=>'',
            'comment' => '开户行账号',
        ],
        'province' => [ 
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '省',
        ],
        'city' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '市',
        ],
        'district' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '区',
        ],
        'address' => [
            'type' => 'varchar(200)',
            'required' => true,
            'default'=>'',
            'comment' => '详细地址',
        ],
        'mobile' => [
            'type' => 'varchar(11)',
            'required' => false,
            'default'=>'',
            'comment' => '手机',
        ],
        'tel' => [ 
            'type' => 'varchar(20)',
            'required' => true,
            'default'=>'',
            'comment' => '固定电话',
        ]
    ],
    'comment' => '客户开票信息表',
    'index' => [
        'index_title' => [ 
            'columns' => [
                0 => 'title',
            ],
            'prefix' => 'UNIQUE'
        ],
        'index_customer_id' => [ 
            'columns' => [
                0 => 'customer_id',
            ]
        ]
    ]
];
