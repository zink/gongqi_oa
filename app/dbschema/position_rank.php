<?php
$db['position_rank'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'rank' => array(
            'type' => 'varchar(10)',
            'required' => true,
            'default'=>'',
            'comment' => '职等',
        ),
        'level' => array(
            'type' => 'varchar(10)',
            'required' => true,
            'default'=>'',
            'comment' => '职级',
        ),
    ),
    'comment' => ('职等职级表'),
    'index' => array(
        'index_rank'=>array(
            'columns' => array(
                0 => 'rank',
            )
        ),
        'index_level'=>array(
            'columns' => [ 
                'rank',
                'level',
            ],
            'prefix' => 'UNIQUE'
        )
    )
);
