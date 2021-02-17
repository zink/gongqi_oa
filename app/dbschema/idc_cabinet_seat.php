<?php
$db['idc_cabinet_seat'] = [
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
            'comment' => '机位名称',
        ],
        'idc_cabinet_stock_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机柜ID',
        ],
        'used' => [
            'type' => 'bool',
            'required' => true,
            'default'=>'false',
            'comment' => '是否使用',
        ],
        'equipment' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '使用设备',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '客户ID'
        ]
    ],
    'comment' => '机位列表',
    'index' => [
        'index_name' => [ 
            'columns' => [
                0 => 'name',
            ],
        ],
        'index_stock_id' => [ 
            'columns' => [
                0 => 'idc_cabinet_stock_id',
            ],
        ],
        'index_customer_id' => [ 
            'columns' => [
                0 => 'customer_id',
            ],
        ]
    ]
];
