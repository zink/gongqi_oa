<?php
$db['ip_pool'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'ip' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'0.0.0.0',
            'comment' => 'IP',
        ],
        'type' => [
            'type' => [
                'ipv4'=>'ipv4',
                'ipv6'=>'ipv6',
                'bgp_ipv4'=>'BGPipv4',
                'bgp_ipv6'=>'BGPipv6',
                'unicom_ipv4'=>'联通ipv4',
                'unicom_ipv6'=>'联通ipv6',
                'telecom_ipv4'=>'电信ipv4',
                'telecom_ipv6'=>'电信ipv6',
                'mobile_ipv4'=>'移动ipv4',
                'mobile_ipv6'=>'移动ipv6',
            ],
            'required' => true,
            'default'=>'bgp_ipv4',
            'comment' => 'IP类型',
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
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '客户ID'
        ],
        'order_item_id' => [
            'type' => 'bigint unsigned',
            'required' => true,
            'default' => 0,
            'comment' => '订单明细ID'
        ],
        'purchase_price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '进货价',
        ],
        'price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '月单价',
        ],
    ],
    'comment' => 'IP池',
    'index' => [
        'index_ip' => [ 
            'columns' => [
                0 => 'ip',
            ],
        ],
        'index_customer_id' => [ 
            'columns' => [
                0 => 'customer_id',
            ],
        ]
    ]
];
