<?php
$db['order_item'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'bigint unsigned',
            'required' => true,
            'pkey' => true,
        ),
        'order_id' => array(
            'type' => 'bigint unsigned',
            'default'=> 0,
            'required' => true,
            'comment' => '订单ID',
        ),
        'idc_id' => [
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '机房ID',
        ],
        'idc_name' => [
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '机房名称',
        ],
        'idc_province' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '省',
        ),
        'idc_city' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '市',
        ),
        'idc_district' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'',
            'comment' => '区',
        ),
        'idc_address' => array(
            'type' => 'varchar(200)',
            'required' => true,
            'default'=>'',
            'comment' => '详细地址',
        ),
        'product_type' => array(
            'type' =>'varchar(50)',
            'default'=> 'seat',
            'required' => true,
            'comment' => '商品类型',
        ),
        'product_name' => array(
            'type' =>'varchar(50)',
            'default'=> 'seat',
            'required' => true,
            'comment' => '商品名称',
        ),
        'price' => array(
            'type' => 'money',
            'default'=> 0,
            'required' => true,
            'comment' => '单件原价',
        ),
        'final_price' => array(
            'type' => 'money',
            'default'=> 0,
            'required' => true,
            'comment' => '单件最终价',
        ),
        'num' => array(
            'type' => 'number',
            'default' => 1,
            'required' => true,
            'comment' => '购买数量',
        ),
        'final_num' => array(
            'type' => 'number',
            'default' => 0,
            'required' => true,
            'comment' => '已经上架数量',
        ),
        'month' => array(
            'type' => 'number',
            'default' => 1,
            'required' => true,
            'comment' => '服务月',
        ),
        'status' => [ 
            'type' => [
                'loading'=>'待上架',
                'finish'=>'已完成'
            ],
            'default'=>'loading',
            'required' => true,
            'comment' => '上架状态',
        ],
        'customer_id' => [
            'type' => 'number',
            'required' => true,
            'default' => 0,
            'comment' => '客户ID'
        ],
    ),
    'comment' => ('订单项表'),
    'index' => array(
        'index_order_id'=>array(
            'columns' => array(
                0 => 'order_id',
            ),
        ),
    )
);
