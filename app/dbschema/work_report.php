<?php
$db['work_report'] = array(
    'columns' => array(
        'id' => array(
            'type' => 'number',
            'required' => true,
            'pkey' => true,
            'extra' => 'auto_increment',
        ),
        'worker_id' => array(
            'type' => 'number',
            'required' => true,
            'default'=>0,
            'comment' => '员工ID',
        ),
        'report' => array(
            'type' => 'text',
            'default'=>'',
            'required' => true,
            'comment' => '报告内容',
        ),
        'report_data' => array(
            'type' => 'time',
            'default'=>0,
            'required' => true,
            'comment' => '报告日期',
        ),
    ),
    'comment' => ('工作报告'),
    'index' => array(
        'index_worker_id'=>array(
            'columns' => array(
                0 => 'worker_id',
            )
        ),
        'index_report_data'=>array(
            'columns' => array(
                0 => 'report_data',
            )
        )
    )
);
