<?php
use Phalcon\Mvc\Model\Behavior\Timestampable;
class BaseModel extends \Phalcon\Mvc\Model{
    public function initialize(){
        $this->useDynamicUpdate(true);
        // Skips only when updating
        $this->skipAttributesOnUpdate(
            [
                'create_time',
            ]
        );
        $this->addBehavior(
            new Timestampable(
                [
                    'beforeCreate' => [
                        'field'  => 'create_time'
                    ],
                    'beforeUpdate' => [
                        'field'  => 'update_time'
                    ]
                ]
            )
        );
    }
}
