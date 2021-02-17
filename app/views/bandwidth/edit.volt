{{content_header(['title':title])}}
{{content_body()}}
    <div class="card">
        {{ form('bandwidth/save','method':'post','class':'form-horizontal') }}
        <div class="card-body" id="J_bandwidth_edit">
            <input v-if="id" type="hidden" :value="id" name="id"/>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    类型
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <select name="type" class="form-control" v-model="type">
                        <option value="bgp">BGP</option>
                        <option value="unicom">联通</option>
                        <option value="telecom">电信</option>
                        <option value="mobile">移动</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    可分配IDC
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="hidden" :value="idc_id" name="idc_id"/>
                    <idc-object :multiple="true" v-model="idc_id"></idc-object>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    带宽总量
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <div class="input-group input-group-sm">
                        <input type="number" name="total" v-model.trim="total" class="form-control"/>
                        <div class="input-group-append">
                            <span class="input-group-text">
                            MB
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    进货价/MB
                </label>
                <div class="col-sm-6">
                    <input type="number" name="purchase_price" v-model.trim="purchase_price" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    销售价/MB
                </label>
                <div class="col-sm-6">
                    <input type="number" name="price" v-model.trim="price" class="form-control"/>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary">
                保存
            </button>
        </div>
        {{ endform() }}
    </div>
{{end_content_body()}}
<script>
(function(){
    var ipEdit = new Vue({
        el:'#J_bandwidth_edit',
        delimiters:['<%','%>'],
        data:{
            id:{{bandwidth['id']?bandwidth['id']:0}},
            type:"{{bandwidth['type']?bandwidth['type']:'bgp'}}",
            total:{{bandwidth['total']?bandwidth['total']:0}},
            idc_id:{{bandwidth['idc_id']?json_encode(bandwidth['idc_id']):"[]"}},
            purchase_price:{{bandwidth['purchase_price']?bandwidth['purchase_price']:0}},
            price:{{bandwidth['price']?bandwidth['price']:0}},
            address      :{
                province  :"{{bandwidth['province']}}",
                city      :"{{bandwidth['city']}}",
                district  :"{{bandwidth['district']}}"
            },
        },
    });
})();
</script>
<!-- /.content -->
