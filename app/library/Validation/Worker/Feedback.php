<?php

namespace Validation\Worker;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Validation\Validator\Regex;
use Phalcon\Validation\Validator\InclusionIn;

class Feedback extends Validation{
  public function initialize(){
    $this->setFilters('mobile','trim');

    $this->add('mobile', new PresenceOf(array(
      'message' => '手机号码不能为空',
      'cancelOnFail' => true,
    )));
    $this->add('mobile',new Regex(array(
      "pattern" => "/^(1[34578]{1}[0-9]{9})$/",
      "message" => "请使用正确的手机号码",
    )));
    $this->add('type',new PresenceOf(array(
      'message' => '反馈类型不能为空',
      'cancelOnFail' => true,
    )));
    $this->add('content',new PresenceOf(array(
        'message' => '反馈内容不能为空',
        'cancelOnFail' => true,
    )));
  }
}

