<?php
$db['opportunity_track'] = [ 
    'columns' => [ 
        'id' => [ 
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'opportunity_id' => [ 
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '线索ID',
        ],
        'worker_id' => [ 
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '员工ID',
        ],
        'status' => [ 
            'type' => [
                'active'=>'跟踪中',
                'dead'=>'作废',
                'success'=>'成单'
            ],
            'required' => true,
            'default'=>'active',
            'comment' => '状态',
        ],
        'track_info' => [
            'type' => 'text',
            'required' => true,
            'default'=>'',
            'comment' => '追踪详情',
        ]
    ],
    'comment' => '销售机会跟踪信息表',
    'index' => [
        'index_worker' => [ 
            'columns' => [
                'worker_id',
            ]
        ],
        'index_opportunity' => [ 
            'columns' => [
                'opportunity_id',
            ]
        ],
    ]
];
