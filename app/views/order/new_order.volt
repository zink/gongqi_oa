{{content_header(['title':'新建订单'])}}
{{content_body()}}
    <div class="card" id="J_order_new">
        {{ form('order/save','method':'post','class':'form-horizontal') }}
        <div class="card-body">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    客户主体
                </label>
                <div class="col-sm-6">
                    <input type="hidden" name="customer_id" value="{{customer['id']}}"/>
                    <p class="form-control-plaintext">
                        {{customer['subject']}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    责任销售
                </label>
                <div class="col-sm-6">
                    <input type="hidden" name="worker_id" value="{{_account['id']}}"/>
                    <p class="form-control-plaintext">
                        {{_account['name']}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    开通时间
                </label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                            </span>
                        </div>
                        <time-input name="opening_time" v-model.trim="opening_time"></time-input>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    计费开始时间
                </label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                            </span>
                        </div>
                        <time-input name="billing_time" v-model.trim="billing_time"></time-input>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    计费结束时间
                </label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                            <i class="far fa-calendar-alt"></i>
                            </span>
                        </div>
                        <time-input name="end_time" v-model.trim="end_time"></time-input>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    收费方式
                </label>
                <div class="col-sm-6 clearfix">
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="year" name="bill_type" v-model="bill_type" value="year">
                        <label for="year">一年付</label>
                    </div>
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="half_year" name="bill_type" v-model="bill_type" value="half_year" checked="">
                        <label for="half_year">半年付</label>
                    </div>
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="three_month" name="bill_type" v-model="bill_type" value="three_month" checked="">
                        <label for="three_month">季付</label>
                    </div>
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="month" name="bill_type" v-model="bill_type" value="month" checked="">
                        <label for="month">月付</label>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    开票信息
                </label>
                <div class="col-sm-6">
                    <div class="card">
                        <div class="card-body p-0">
                            <table class="table table-striped">
                                <tr>
                                    <th>抬头</th>
                                    <td>
                                    {{customer['invoice'][0]['title']}}
                                    </td>
                                </tr>
                                <tr>
                                    <th>税号</th>
                                    <td>
                                    {{customer['invoice'][0]['tax_number']}}
                                    </td>
                                </tr>
                                <tr>
                                    <th>开户行</th>
                                    <td>
                                    {{customer['invoice'][0]['bank']}}
                                    </td>
                                </tr>
                                <tr>
                                    <th>开户行账号</th>
                                    <td>
                                    {{customer['invoice'][0]['bank_account']}}
                                    </td>
                                </tr>
                                <tr>
                                    <th>企业地址</th>
                                    <td>
                                    {{customer['invoice'][0]['province']}}
                                    {{customer['invoice'][0]['city']}}
                                    {{customer['invoice'][0]['district']}}
                                    <hr />
                                    {{customer['invoice'][0]['address']}}
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    折后总价
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        <h2 class="text-red">￥<%computedTotal%></h2>
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    备注
                </label>
                <div class="col-sm-6">
                    <textarea class="form-control" v-model="remark"></textarea>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    销售清单
                </label>
                <div class="col-sm-10">
                    <button class="btn btn-primary" @click.stop.prevent="getIdcList">
                        添加IDC
                    </button>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <div class="card" v-for="idc,k in idcList" :key="k">
                        <div class="card-header">
                            <div class="card-title">
                                <%idc.name%>
                            </div>
                            <div class="card-tools">
                                <button class="btn btn-danger btn-sm" @click.stop.prevent="deleteIdc(k)">
                                    删除
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-striped">
                                <tr>
                                    <th>产品</th>
                                    <th>建议销售价/月</th>
                                    <th>实际售价/月</th>
                                    <th>数量</th>
                                    <th>购买月</th>
                                    <th>总价</th>
                                    <th>实际总价</th>
                                    <th>操作</th>
                                </tr>
                                <tr v-for="item,index in orderItem[idc.id]" :key="index">
                                    <td>
                                    <%item.name|productType%>
                                    </td>
                                    <td>
                                    <%item.price%>
                                    </td>
                                    <td>
                                    <input type="number" class="form-control form-control-sm" v-model="orderItem[idc.id][index].final_price"/>
                                    </td>
                                    <td>
                                    <input type="number" class="form-control form-control-sm" v-model="orderItem[idc.id][index].num"/>
                                    </td>
                                    <td>
                                    <input type="number" class="form-control form-control-sm" v-model="orderItem[idc.id][index].month"/>
                                    </td>
                                    <td>
                                    ￥<%item.num * item.price * item.month%>
                                    </td>
                                    <td>
                                        <span class="text-red">
                                            ￥<%item.num * item.final_price * item.month%>
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-xs btn-danger" @click.stop.prevent="deleteItem(index)">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-secondary" @click.stop.prevent="addProduct(idc.id)">
                                添加产品
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary" @click.stop.prevent="saveOrder()">
                保存
            </button>
        </div>
        {{ endform() }}
    </div>
{{end_content_body()}}
<script>
(function(){
    var orderNew = new Vue({
        el:'#J_order_new',
        delimiters:['<%','%>'],
        data:{
            orderItem:{},
            idc_id:[],
            idcList:[],
            opening_time:0,
            billing_time:0,
            end_time:0,
            bill_type:'year',
            remark:''
        },
        computed:{
            'computedTotal':function(){
                var total = 0;
                var self = this;
                $.each(self.orderItem,function(index,item){
                    for(var i = 0;i<item.length;i++){
                        total += item[i].final_price *item[i].num*item[i].month;
                    }
                });
                return total;
            }
        },
        watch:{
            'idc_id':function(){
                var self = this;
                if(self.idc_id.length > 0){
                    $.ajax({
                        'url':"{{url('idc/get_list')}}",
                        'data':{
                            id:self.idc_id
                        },
                        'success':function(re){
                            self.idcList = re;
                        }
                    });
                }
            }
        },
        filters:{
            'productType':function(type){
                switch(type){
                    case 'bandwidth_bgp':
                        return '带宽(bgp)';
                    break;
                    case 'bandwidth_unicom':
                        return '带宽(联通)';
                    break;
                    case 'bandwidth_telecom':
                        return '带宽(电信)';
                    break;
                    case 'bandwidth_mobile':
                        return '带宽(移动)';
                    break;
                    case 'ampere':
                        return '加电';
                    break;
                    case 'bridge':
                        return '桥架';
                    break;
                    case 'bgp_ipv4':
                      return 'BGP IPv4';
                    break;
                    case 'bgp_ipv6':
                      return 'BGP IPv6';
                    break;
                    case 'unicom_ipv4':
                      return '联通 IPv4';
                    break;
                    case 'unicom_ipv6':
                      return '联通 IPv6';
                    break;
                    case 'telecom_ipv4':
                      return '电信 IPv4';
                    break;
                    case 'telecom_ipv6':
                      return '电信 IPv6';
                    break;
                    case 'mobile_ipv4':
                      return '移动 IPv4';
                    break;
                    case 'mobile_ipv6':
                      return '移动 IPv6';
                    break;
                    case '10A':
                        return '10A整柜';
                    break;
                    case '16A':
                        return '16A整柜';
                    break;
                    case '20A':
                        return '20A整柜';
                    break;
                    case '25A':
                        return '25A整柜';
                    break;
                    case '32A':
                        return '32A整柜';
                    break;
                    case '45A':
                        return '45A整柜';
                    break;
                    case '64A':
                        return '64A整柜';
                    break;
                    case '10A_seat':
                        return '10A散位';
                    break;
                    case '16A_seat':
                        return '16A散位';
                    break;
                    case '20A_seat':
                        return '20A散位';
                    break;
                    case '25A_seat':
                        return '25A散位';
                    break;
                    case '32A_seat':
                        return '32A散位';
                    break;
                    case '45A_seat':
                        return '45A散位';
                    break;
                    case '64A_seat':
                        return '64A散位';
                    break;
                    default:
                        return '非法资源'
                    break;
                }
            }
        },
        methods:{
            'deleteIdc':function(index){
                var self = this;
                bootbox.confirm({
                    'message':"确定要删除该机房吗？",
                    'buttons':{
                        confirm: {
                            label: '确定',
                        },
                        cancel: {
                            label: '取消',
                        }
                    },
                    'size':'small',
                    'callback':function(result){
                        if(result){
                            var id = self.idcList[index].id;
                            for(var i = 0;i< self.idc_id.length;i++){
                                if(self.idc_id[i] == id){
                                    self.$delete(self.idc_id,i);
                                    self.$delete(self.orderItem,id);
                                    self.$delete(self.idcList,index);
                                    break;
                                }
                            }
                        }
                    }
                });
            },
            'deleteItem':function(index){
                this.$delete(this.orderItem,index);
            },
            'addProduct':function(id){
                var self = this;
                $.ajax({
                    'url':"{{url('order/get_product/')}}"+id,
                    'success':function(re){
                        var modal = $(re).appendTo($('body'));
                        modal.on('hidden.bs.modal',function(){
                            modal.remove();
                        }).on('click','.submit',function(){
                            var checked = modal.find('td input:checked');
                            var value = [];
                            if(checked.length > 0){
                                $.each(checked,function(index,item){
                                    var $el = $(item);
                                    value.push({
                                        'id':$el.data('id')?$el.data('id'):0,
                                        'type':$el.data('type'),
                                        'name':$(item).val(),
                                        'price':$(item).data('price'),
                                        'final_price':0,
                                        'num':1,
                                        'month':1
                                    });
                                });
                            }
                            self.$set(self.orderItem,id,value);
                            modal.modal('hide');
                        });
                        modal.modal('show');
                    }
                });
            },
            'saveOrder':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('order/save')}}",
                    'type':'POST',
                    'data':{
                        'subject':"{{customer['subject']}}",
                        'customer_id':{{customer['id']}},
                        'worker_id':{{_account['id']}},
                        'opening_time':self.opening_time,
                        'billing_time':self.billing_time,
                        'end_time':self.end_time,
                        'bill_type':self.bill_type,
                        'items':self.orderItem,
                        'remark':self.remark
                    },
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage(re.redirect);
                        }
                    }
                });
            },
            'getIdcList':function(){
                var self = this;
                var url = "{{url('idc/idc_modal/1')}}";
                $.ajax({
                    'url':url,
                    'success':function(re){
                        var modal = $(re).appendTo($('body'));
                        modal.on('hidden.bs.modal',function(){
                            modal.remove();
                        }).on('click','.submit',function(){
                            var checked = modal.find('td input:checked');
                            var value = [];
                            if(checked.length > 0){
                                $.each(checked,function(index,item){
                                    value.push($(item).val())
                                });
                            }
                            self.idc_id = Array.from(new Set($.merge($.merge([],self.idc_id),value)));
                            modal.modal('hide');
                        });
                        modal.modal('show');
                    }
                });
            }
        }
    });
})();
</script>
<!-- /.content -->
