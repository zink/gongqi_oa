<?php
$db['idc_cabinet_stock'] = [
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
            'comment' => '机柜名称',
        ],
        'used' => [
            'type' => 'bool',
            'required' => true,
            'default'=>'false',
            'comment' => '是否使用',
        ],
        'seat_num' => [ 
            'type' => 'int(3)',
            'default'=>0,
            'required' => true,
            'comment' => '机位数',
        ],
        'used_seat_num' => [ 
            'type' => 'int(3)',
            'default'=>0,
            'required' => true,
            'comment' => '已使用机位数',
        ],
        'idc_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机房ID',
        ],
        'idc_cabinet_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机柜类型ID',
        ],
        'ampere' => [
            'type' => [
                '10A'=>'10安培',
                '16A'=>'16安培',
                '20A'=>'20安培',
                '25A'=>'25安培',
                '32A'=>'32安培',
                '45A'=>'45安培',
                '64A'=>'64安培',
            ],
            'required' => true,
            'default'=>'10A',
            'comment' => '安培数',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '客户ID'
        ]
    ],
    'comment' => '机柜库存列表',
    'index' => [
        'index_idc_id' => [ 
            'columns' => [
                0 => 'idc_id',
            ],
        ],
        'index_cabinet_id' => [ 
            'columns' => [
                0 => 'idc_cabinet_id',
            ],
        ],
        'index_customer_id' => [ 
            'columns' => [
                0 => 'customer_id',
            ],
        ],
        'index_ampere' => [ 
            'columns' => [
                0 => 'ampere',
            ],
        ]
    ]
];
