<?php
$db['customer_attachment'] = [
    'columns' => [
        'id' => [
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ],
        'customer_id' => [ 
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '客户ID',
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
    'comment' => '客户认证材料表',
    'index' => [
        'index_customer' => [ 
            'columns' => [
                'customer_id',
            ]
        ]
    ]
];
