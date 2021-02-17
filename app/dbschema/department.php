<?php
$db['department'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'parent_id' => array(
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '父ID',
        ),
        'name' => array(
            'type' => 'varchar(50)',
            'default'=>0,
            'required' => true,
            'comment' => '部门名称',
        ),
    ),
    'comment' => ('部门表'),
    'index' => array(
        'index_parent_id'=>array(
            'columns' => array(
                0 => 'parent_id',
            )
        ),
        'index_name'=>array(
            'columns' => array(
                0 => 'name',
            )
        )
    )
);
