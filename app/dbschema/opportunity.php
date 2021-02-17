<?php
$db['opportunity'] = [ 
    'columns' => [ 
        'id' => [ 
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'origin' => [
            'type'=>'varchar(10)',
            'required' => true,
            'default'=>'',
            'comment' => '来源',
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
        'area' => [ 
            'type' => [
                'east_china'=>'华东',
                'south_china'=>'华南',
                'northwest_china'=>'西北',
                'southwest_china'=>'西南',
                'north _china'=>'华北',
                'northeast_china'=>'东北',
                'central_china'=>'华中',
                'foreign'=>'海外',
            ],
            'required' => true,
            'default'=>'east_china',
            'comment' => '中国地理大区',
        ],
        'province' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '省',
        ),
        'city' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '市',
        ),
        'district' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '区',
        ),
        'address' => array(
            'type' => 'varchar(200)',
            'required' => true,
            'default'=>'',
            'comment' => '详细地址',
        ),
        'worker_id' => [ 
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '员工ID',
        ],
        'needs' => [
            'type' => 'varchar(250)',
            'required' => false,
            'default'=>'',
            'comment' => '需求',
        ],
        'company' => [ 
            'type' => 'varchar(100)',
            'required' => true,
            'default'=>'',
            'comment' => '公司名称'
        ],
        'signing_time'=>[
            'type' => 'time',
            'required' => true,
            'default'=>0,
            'comment' => '预计签约时间'
        ],
        'contract_amount'=>[
            'type' => 'money',
            'required' => true,
            'default'=>0,
            'comment' => '预计合同金额'
        ],
        'payment_for_year'=>[
            'type' => 'money',
            'required' => true,
            'default'=>0,
            'comment' => '当年预计收款'
        ],
        'success_rate'=>[
            'type' => 'float',
            'required' => true,
            'default'=>0,
            'comment' => '成功率'
        ],
        'remark' => [
            'type' => 'varchar(200)',
            'required' => false,
            'default'=>'',
            'comment' => '备注',
        ]
    ],
    'comment' => '销售机会表',
    'index' => [
        'index_worker' => [ 
            'columns' => [
                'worker_id'
            ]
        ],
        'index_origin' => [ 
            'columns' => [
                'origin'
            ]
        ],
        'index_area' => [ 
            'columns' => [
                'area'
            ]
        ],
        'index_province' => [ 
            'columns' => [
                'province'
            ]
        ],
        'index_city' => [ 
            'columns' => [
                'city'
            ]
        ],
        'index_district' => [ 
            'columns' => [
                'district'
            ]
        ],
        'index_address' => [ 
            'columns' => [
                'address'
            ]
        ],
        'index_status' => [ 
            'columns' => [
                'status'
            ]
        ],
        'index_company' => [ 
            'columns' => [
                'company'
            ]
        ]
    ]
];
