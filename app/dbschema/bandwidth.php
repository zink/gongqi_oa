<?php
$db['bandwidth'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'total' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '带宽总量',
        ],
        'used' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '用量',
        ],
        'type' => [
            'type' => [
                'bgp'=>'bgp',
                'unicom'=>'联通',
                'telecom'=>'电信',
                'mobile'=>'移动',
            ],
            'required' => true,
            'default'=>'bgp',
            'comment' => '带宽类型',
        ],
        'purchase_price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => 'MB进货价',
        ],
        'price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => 'MB月单价',
        ],
    ],
    'comment' => '带宽',
    'index' => []
];
