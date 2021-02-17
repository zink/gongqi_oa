<?php
$db['ip_idc'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'ip_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机房ID',
        ],
        'idc_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机房ID',
        ],
    ],
    'comment' => 'IP IDC关联表',
    'index' => [
        'index_ip_id' => [ 
            'columns' => [
                0 => 'ip_id',
            ],
        ],
        'index_idc_id' => [ 
            'columns' => [
                0 => 'idc_id',
            ],
        ],
    ]
];
