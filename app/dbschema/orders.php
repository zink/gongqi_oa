<?php
$db['orders'] = [
    'columns' => [
        'id' => [
            'type' => 'bigint unsigned',
            'required' => true,
            'pkey' => true,
        ],
        'subject' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '客户主体'
        ],
        'worker_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '责任销售'
        ],
        'worker_name' => [
            'type' => 'varchar(20)',
            'required' => false,
            'default'=>'',
            'comment' => '姓名',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '客户ID'
        ],
        'bill_type' => [ 
            'type' => [
                'year'=>'年付',
                'half_year'=>'半年付',
                'three_month'=>'季付',
                'month'=>'月付'
            ],
            'default'=>'year',
            'required' => true,
            'comment' => '付费方式',
        ],
        'total' => [
            'type' => 'money',
            'required' => true,
            'default'=>0,
            'comment' => '总价',
        ],
        'status' => [ 
            'type' => [
                'pending'=>'待审核',
                'refuse'=>'拒绝',
                'loading'=>'待上架',
                'doing'=>'上架中',
                'part_loading'=>'部分上架',
                'active'=>'活动订单',
                'dead'=>'作废订单',
                'finish'=>'已完成'
            ],
            'default'=>'pending',
            'required' => true,
            'comment' => '订单状态',
        ],
        'commission_ratio' => [
            'type' => 'float',
            'default'=>0,
            'required' => true,
            'comment' => '佣金比例',
        ],
        'pay_status' => array(
            'type' => array(
                'unpayed'=>'未支付',
                'payed'=>'已支付',
                'partial'=>'部分支付'
            ),
            'default'=>'unpayed',
            'required' => true,
            'comment' => '订单支付状态',
        ),
        'opening_time' => [
            'type' => 'time',
            'comment' => '开通时间',
        ],
        'billing_time' => [
            'type' => 'time',
            'comment' => '计费开始时间',
        ],
        'end_time' => [
            'type' => 'time',
            'comment' => '计费结束时间',
        ],
        'loading_time' => [
            'type' => 'time',
            'comment' => '上架开始时间',
        ],
        'remark' => array(
            'type' => 'text',
            'comment' => '订单备注',
        ),
        'refuse_remark' => array(
            'type' => 'text',
            'comment' => '拒绝理由',
        ),
    ],
    'comment' => '订单表',
    'index' => [
        'index_subject' => [ 
            'columns' => [
                0 => 'subject',
            ],
        ]
    ]
];
