<?php
$db['opportunity_worker'] = [ 
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
        'active' => [
            'type' => 'bool',
            'required' => true,
            'default'=>'true',
            'comment' => '是否负责人',
        ]
    ],
    'comment' => '销售机会表',
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
