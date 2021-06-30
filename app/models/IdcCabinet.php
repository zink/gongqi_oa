<?php
use Phalcon\Mvc\Model\Message as Message;
class IdcCabinet extends \BaseModel{
    public $id;
    public $purchase_price;
    public $price;
    public $seat_num;
    public $seat_price;
    public $stock;
    public $idc_id;
    public $ampere;
    public function initialize(){
        parent::initialize();
        $this->belongsTo("idc_id","Idc","id");
        $this->hasMany("id","IdcCabinetStock","idc_cabinet_id");
    }
    public function afterSave(){
        $newStock = $this->stock - $this->idcCabinetStock->count();
        if($newStock > 0){
            for($i = 0;$i < $newStock;$i++){
                $stock = new \IdcCabinetStock();
                $stock->idc_id = $this->idc_id;
                $stock->idc_cabinet_id = $this->id;
                $stock->seat_num = $this->seat_num;
                $stock->ampere = $this->ampere;
                if(!$stock->save()){
                    return false;
                }
            }
        }
        return true;
    } 
    public function beforeUpdate(){
        if($this->stock < $this->sales){
            $message = new Message(
                "库存不能小于已售卖库存"
            );
            $this->appendMessage($message);

            return false;
        }
        if($this->hasChanged('stock')){
            if($this->stock < $this->sales){
                $message = new Message(
                    "删除库存大于已售卖库存"
                );
                $this->appendMessage($message);
                return false;
            }
            $stock = $this->getSnapshotData()['stock'] - $this->stock;
            if($stock>0){
                $cabinetStock = \IdcCabinetStock::find([
                    "conditions"=>"idc_cabinet_id = ".$this->id." and used = 'false'",
                    "limit"=>$stock
                ]);
                foreach($cabinetStock as $key=>$item){
                    if(!$item->delete()){
                        $message = new Message(
                            "删除库存失败"
                        );
                        $this->appendMessage($message);
                        return false;
                    }
                }
            }
        }
        return true;
    }
}
