<?php
$db['position'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'name' => array(
            'type' => 'varchar(50)',
            'required' => true,
            'default'=>'员工',
            'comment' => '职位名称',
        ),
        'position_type_id' => array(
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '职位类型',
        ),
        'position_rank_id' => array(
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '职等职级',
        ),
    ),
    'comment' => ('职位表'),
    'index' => array(
        'index_name'=>array(
            'columns' => array(
                0 => 'name',
            )
        ),
        'index_position_rank'=>array(
            'columns' => array(
                0 => 'position_rank_id',
            )
        ),
        'index_position_type_id'=>array(
            'columns' => array(
                0 => 'position_type_id',
            )
        ),
        'index_position'=>array(
            'columns' => array(
                0 => 'name',
                1 => 'position_rank_id',
            ),
            'prefix' => 'UNIQUE'
        )
    )
);
