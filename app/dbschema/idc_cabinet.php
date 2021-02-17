<?php
$db['idc_cabinet'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
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
        'seat_num' => [ 
            'type' => 'int(3)',
            'default'=>0,
            'required' => true,
            'comment' => '机位数',
        ],
        'seat_price' => [ 
            'type' => 'money',
            'default'=>0,
            'required' => true,
            'comment' => '机位月单价',
        ],
        'stock' => [ 
            'type' => 'number',
            'default'=>0,
            'required' => true,
            'comment' => '库存',
        ],
        'sales' => [ 
            'type' => 'number',
            'default'=>0,
            'required' => true,
            'comment' => '已销售',
        ],
        'idc_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机房ID',
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
    ],
    'comment' => '机柜类型表',
    'index' => [
        'index_idc_id' => [ 
            'columns' => [
                0 => 'idc_id',
            ],
        ],
        'index_ampere' => [ 
            'columns' => [
                0 => 'ampere',
            ],
        ]
    ]
];
