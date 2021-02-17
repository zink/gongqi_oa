<?php
$db['cabinet_power_log'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'power_up' => [
            'type' => 'bool',
            'required' => true,
            'default'=>'false',
            'comment' => '通电状态',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '客户ID'
        ],
        'idc_cabinet_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机柜ID',
        ],
    ],
    'comment' => '机柜开电记录',
    'index' => [
        'index_cabinet_id' => [ 
            'columns' => [
                0 => 'idc_cabinet_id',
            ]
        ],
        'index_customer_id' => [ 
            'columns' => [
                0 => 'customer_id',
            ],
        ]
    ]
];
