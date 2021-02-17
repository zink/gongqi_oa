<?php
$db['bandwidth_idc'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'bandwidth_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '带宽ID',
        ],
        'idc_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机房ID',
        ],
    ],
    'comment' => '带宽 IDC关联表',
    'index' => [
        'index_bandwidth_id' => [ 
            'columns' => [
                0 => 'bandwidth_id',
            ],
        ],
        'index_idc_id' => [ 
            'columns' => [
                0 => 'idc_id',
            ],
        ],
    ]
];
