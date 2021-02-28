<?php
$db['order_bill'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'order_id' => array(
            'type' => 'bigint unsigned',
            'default'=> 0,
            'required' => true,
            'comment' => '订单ID',
        ),
        'pay_status' => array(
            'type' => array(
                'unpayed'=>'未支付',
                'payed'=>'已支付',
                'partial'=>'部分支付'
            ),
            'default'=>'unpayed',
            'required' => true,
            'comment' => '账单支付状态',
        ),
        'contract'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '支付凭证' ,
        ],
        'billing_time' => [
            'type' => 'time',
            'comment' => '计费开始时间',
        ],
        'end_time' => [
            'type' => 'time',
            'comment' => '计费结束时间',
        ],
        'total' => [
            'type' => 'money',
            'required' => true,
            'default'=>0,
            'comment' => '总价',
        ],
    ),
    'comment' => ('账单表'),
    'index' => array(
        'index_order_id'=>array(
            'columns' => array(
                0 => 'order_id',
            ),
        ),
    )
);
