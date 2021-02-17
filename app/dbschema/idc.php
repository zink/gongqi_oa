<?php
$db['idc'] = [
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
            'comment' => '机房名称',
        ],
        'province' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '省',
        ),
        'city' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '市',
        ),
        'district' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '区',
        ),
        'address' => array(
            'type' => 'varchar(200)',
            'required' => true,
            'default'=>'',
            'comment' => '详细地址',
        ),
        'bridge_purchase_price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '桥架一芯月采购价',
        ],
        'bridge_price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '桥架一芯月单价',
        ],
        'ampere_purchase_price' => [
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '一安培采购价',
        ],
        'ampere_price' => [
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '一安培月销售价',
        ],
        'ip_purchase_price' => [
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => 'IP采购价',
        ],
        'ip_price' => [
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => 'IP月销售价',
        ],
        'ipv6_purchase_price' => [
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => 'IPv6采购价',
        ],
        'ipv6_price' => [
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => 'IPv6月销售价',
        ]
    ],
    'comment' => '机房列表',
    'index' => [
        'index_name' => [ 
            'columns' => [
                0 => 'name',
            ],
        ]
    ]
];
