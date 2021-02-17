<?php
use Phalcon\Mvc\Model\Message as Message;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Regex;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\InclusionIn;
use Phalcon\Validation\Validator\Uniqueness as UniquenessValidator;
class IpPool extends \BaseModel{
    public $id;
    public $ip;
    public $province;
    public $city;
    public $district;
    public $customer_id;
    public function initialize(){
        parent::initialize();
        $this->hasMany("id","IpIdc","ip_id");
    }
    public function beforeDelete(){
        if($this->customer_id != 0){
            $message = new Message("请先释放该IP");
            $this->appendMessage($message);
            return false;
        }
        return true;
    }
    public function validation(){
        $validator = new Validation();
        $validator->add(
            ['type'],
            new InclusionIn(
                [
                    'message'=>[
                        'type' => "类型不合法",
                    ],
                    'domain' => [
                        'type'=>[
                            'bgp_ipv4',
                            'bgp_ipv6',
                            'unicom_ipv4',
                            'unicom_ipv6',
                            'telecom_ipv4',
                            'telecom_ipv6',
                            'mobile_ipv4',
                            'mobile_ipv6' 
                        ]
                    ]
                ]
            )
        );
        $validator->add(
            "ip",
            new UniquenessValidator([
                "message" => "ip唯一",
            ])
        );
        switch($this->type){
            case 'bgp_ipv4':
            case 'unicom_ipv4':
            case 'telecom_ipv4':
            case 'mobile_ipv4':
                $validator->add(
                    'ip',
                    new Regex([
                            "pattern" => "/^((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})(\.((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})){3}$/",
                            "message" => "IPv4地址格式错误",
                        ]
                    )
                );
            break;
            case 'bgp_ipv6':
            case 'unicom_ipv6':
            case 'telecom_ipv6':
            case 'mobile_ipv6':
                $validator->add(
                    'ip',
                    new Regex([
                            "pattern" => "/^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/",
                            "message" => "IPv6地址格式错误",
                        ]
                    )
                );
            break;
        }
        $validator->add(
            "province",
            new PresenceOf(
                [
                    "message" => "省必填",
                ]
            )
        );
        return $this->validate($validator);
    }
    public function toDetailArray($columns = null){
        $_return = parent::toArray($columns);
        $_return['idc'] = $this->ipIdc->toArray();
        return $_return;
    }
}
