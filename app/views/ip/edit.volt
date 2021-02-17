{{content_header(['title':title])}}
{{content_body()}}
    <div class="card">
        {{ form('ip/save','method':'post','class':'form-horizontal') }}
        <div class="card-body" id="J_ip_edit">
            <div class="form-group row">
                <input type="hidden" v-if="id" name="id" :value="id"/>
                <label class="col-sm-2 col-form-label">
                    ip
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="ip" v-model="ip" class="form-control" placeholder="请输入ip"/>
                </div>
            </div>
            <div class="form-group row">
                <input type="hidden" v-if="id" name="id" :value="id"/>
                <label class="col-sm-2 col-form-label">
                    ip类型
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <select name="type" v-model="type" class="form-control">
                        <option value="bgp_ipv4">BGP IPv4</option>
                        <option value="bgp_ipv6">BGP IPv6</option>
                        <option value="unicom_ipv4">联通IPv4</option>
                        <option value="unicom_ipv6">联通IPv6</option>
                        <option value="telecom_ipv4">电信IPv4</option>
                        <option value="telecom_ipv6">电信IPv6</option>
                        <option value="mobile_ipv4">移动IPv4</option>
                        <option value="mobile_ipv6">移动IPv6</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    地区
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <address-object v-model="address" :has-address="false"></address-object>
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
        el:'#J_ip_edit',
        delimiters:['<%','%>'],
        data:{ 
            'id':{{ip['id']?ip['id']:0}},
            'ip':"{{ip['ip']?ip['ip']:''}}",
            'type':"{{ip['type']?ip['type']:''}}",
            'idc_id':{{ip['idc_id']?json_encode(ip['idc_id']):"[]"}},
            purchase_price:{{ip['purchase_price']?ip['purchase_price']:0}},
            price:{{ip['price']?ip['price']:0}},
            'address'      :{
                province  :"{{ip['province']}}",
                city      :"{{ip['city']}}",
                district  :"{{ip['district']}}"
            },
            'customer_id':{{ip['customer_id']?ip['customer_id']:0}}
        },
    });
})();
</script>
<!-- /.content -->
