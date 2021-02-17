<?php

namespace AbstractClass;
use Common\BusinessException;

/**
 * BaseApi
 *
 * @property array $requestFields
 * @property \Service\RedisDb $redis
 */
abstract class BaseApi extends \Phalcon\Mvc\User\Component
{
    protected function success($data = 'ok')
    {
        if(is_string($data)){
            $jsonArray =  array(
                'success'=>true,
                'msg'=>$data
            );
        }else{
            $jsonArray = $data;
        }
        return json_decode(json_encode($jsonArray),1);
    }

    protected function error($msg = 'failed', $code = 400){
        $jsonArray = array(
            'error_code'=>$code,
            'msg' =>$msg
        );
        return json_decode(json_encode($jsonArray),1);
    }

    protected function beginTransaction()
    {
        $this->db->begin();
    }

    protected function commitTransaction()
    {
        $this->db->commit();
    }

    protected function rollbackTransaction()
    {
        $this->db->commit();
    }
}
