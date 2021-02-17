<?php
$db['opportunity_contact'] = [
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
            'comment' => '销售机会ID',
        ],
        'name' => [ 
            'type' => 'varchar(10)',
            'required' => true,
            'default'=>'',
            'comment' => '联系人姓名',
        ],
        'type' => [
            'type' => [
                'key'=>'关键人',
                'decision'=>'决策人',
                'contact'=>'联系人',
                'other'=>'其他',
            ],
            'required' => true,
            'default'=>'contact',
            'comment' => '联系人类别',
        ],
        'position' => [
            'type' => 'varchar(10)',
            'required' => true,
            'default'=>'',
            'comment' => '岗位',
        ],
        'mobile' => [
            'type' => 'varchar(11)',
            'required' => false,
            'default'=>'',
            'comment' => '联系电话',
        ],
        'remark' => [
            'type' => 'varchar(100)',
            'required' => false,
            'default'=>'',
            'comment' => '备注',
        ]
    ],
    'comment' => '销售机会联系人表',
    'index' => [
        'index_opportunity' => [ 
            'columns' => [
                'opportunity_id',
            ]
        ]
    ]
];
