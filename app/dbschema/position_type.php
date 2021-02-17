<?php
$db['position_type'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'name' => array(
            'type' => 'varchar(20)',
            'required' => true,
            'default'=>'合同工',
            'comment' => '职位类型',
        ),
    ),
    'comment' => ('职位类型表'),
    'index' => array(
        'index_name'=>array(
            'columns' => array(
                0 => 'name',
            ),
            'prefix' => 'UNIQUE'
        )
    )
);
