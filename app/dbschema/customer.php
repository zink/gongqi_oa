<?php
$db['customer'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'subject' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '客户主体'
        ],
        'certification' => [
            'type' => 'bool',
            'required' => true,
            'default'=>'false',
            'comment' => '认证状态',
        ],
        'province' => [ 
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '省',
        ],
        'city' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '市',
        ],
        'district' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '区',
        ],
        'address' => [
            'type' => 'varchar(200)',
            'required' => true,
            'default'=>'',
            'comment' => '详细地址',
        ],
        'artificial_person' => [
            'type' => 'varchar(10)',
            'required' => true,
            'default'=>'',
            'comment' => '法人代表',
        ],
        'tel' => [ 
            'type' => 'varchar(20)',
            'required' => true,
            'default'=>'',
            'comment' => '固定电话',
        ],
        'worker_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '责任销售',
        ],
        'remark' => [
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '备注',
        ],
        'license'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '营业执照' ,
        ],
        'legal_person_front'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '法人身份证正面' ,
        ],
        'legal_person_back'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '法人身份证反面' ,
        ],
        'contacts_front'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '负责人身份证正面' ,
        ],
        'contacts_back'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '负责人身份证反面' ,
        ]
    ],
    'comment' => '客户表',
    'index' => [
        'index_subject' => [ 
            'columns' => [
                0 => 'subject',
            ],
            'prefix' => 'UNIQUE'
        ],
        'index_worker_id' => [ 
            'columns' => [
                0 => 'worker_id',
            ],
        ],
        'index_province' => [ 
            'columns' => [
                0 => 'province',
            ],
        ],
        'index_city' => [ 
            'columns' => [
                0 => 'city',
            ],
        ],
        'index_district' => [ 
            'columns' => [
                0 => 'district',
            ],
        ],
        'index_address' => [ 
            'columns' => [
                0 => 'address',
            ],
        ],
        'index_person' => [ 
            'columns' => [
                0 => 'artificial_person',
            ],
        ]
    ]
];
