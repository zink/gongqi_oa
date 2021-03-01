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
        'status' => [ 
            'type' => [
                'pending'=>'待确认',
                'finish'=>'已完成'
            ],
            'default'=>'pending',
            'required' => true,
            'comment' => '财务确认状态',
        ],
        'contract'=>[
            'type' => 'varchar(200)',
            'required' => true,
            'default' => '',
            'comment' => '支付凭证' ,
        ],
        'billing_time' => [
            'type' => 'time',
            'required' => true,
            'default'=>0,
            'comment' => '计费开始时间',
        ],
        'end_time' => [
            'type' => 'time',
            'required' => true,
            'default'=>0,
            'comment' => '计费结束时间',
        ],
        'finish_time' => [
            'type' => 'time',
            'required' => true,
            'default'=>0,
            'comment' => '确收时间',
        ],
        'finish_worker' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '确收员工'
        ],
        'finish_worker_name' => [
            'type' => 'varchar(20)',
            'required' => false,
            'default'=>'',
            'comment' => '确收员工姓名'
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
        'index_billing_time'=>array(
            'columns' => array(
                0 => 'billing_time',
            ),
        ),
        'index_end_time'=>array(
            'columns' => array(
                0 => 'end_time',
            ),
        ),
        'index_finish_time'=>array(
            'columns' => array(
                0 => 'finish_time',
            ),
        ),
    )
);
