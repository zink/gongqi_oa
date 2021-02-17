{{content_header(['title':'上架单'])}}
{{content_body()}}
    <div class="card form-horizontal">
        <div class="card-header">
            <h3 class="card-title">
                主体信息
            </h3>
        </div>
        <div class="card-body">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    订单编号
                </label>
                <div class="col-sm-4">
                    <h2>
                        {{order['id']}}
                    </h2>
                </div>
                <label class="col-sm-2 col-form-label">
                    订单状态
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {%switch order['status']%}
                        {%case 'doing'%}
                        <span class="badge badge-warning">上架中</span>
                        {%break%}
                        {%case 'loading'%}
                        <span class="badge badge-danger">待上架</span>
                        {%break%}
                        {%case 'part_loading'%}
                        <span class="badge badge-warning">部分上架</span>
                        {%break%}
                        {%endswitch%}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    客户主体
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {{order['subject']}}
                    </p>
                </div>
                <label class="col-sm-2 col-form-label">
                    责任销售
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {{order['worker_name']}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    计费开始时间
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {{date('Y-m-d',order['billing_time'])}}
                    </p>
                </div>
                <label class="col-sm-2 col-form-label">
                    计费结束时间
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {{date('Y-m-d',order['end_time'])}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    开通时间
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {{date('Y-m-d',order['opening_time'])}}
                    </p>
                </div>
                <label class="col-sm-2 col-form-label">
                    上架开始时间
                </label>
                <div class="col-sm-4">
                    <p class="form-control-plaintext">
                        {{order['loading_time']?date('Y-m-d',order['loading_time']):'未开始'}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    备注
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                    {{order['remark']?order['remark']:'无'}}
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div id="J_order_up">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            资源清单
                        </h3>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table class="table table-striped table-hover">
                            <tr>
                                <th>IDC</th>
                                <th>产品</th>
                                <th>数量</th>
                                <th>上架</th>
                                <th>购买月</th>
                            </tr>
                            <tr v-for="item,index in products" :key="index">
                                <td>
                                <%item.idc_name%>
                                </td>
                                <td>
                                <%item.product_name|productType%>
                                </td>
                                <td>
                                <%item.num%>
                                </td>
                                <td>
                                    <span v-if="item.status == 'finish'" class="badge badge-success">是</span>
                                    <span v-else class="badge badge-danger">否</span>
                                </td>
                                <td>
                                <%item.month%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="card-footer row" v-if="orderStatus == 'loading'">
                        <div class="col-sm-6">
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        上架时间
                                    </span>
                                </div>
                                <time-input name="doing_time" v-model.trim="doingTime"></time-input>
                                <div class="input-group-append">
                                    <button class="btn btn-primary" @click.stop.prevent="doUp">
                                        开始上架
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" v-if="orderStatus != 'loading'">
            <div class="col-4">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            上架清单
                        </h3>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table class="table table-striped table-sm table-hover">
                            <tr>
                                <th>IDC</th>
                                <th>产品</th>
                                <th>数量</th>
                                <th>上架</th>
                                <th>购买月</th>
                                <th></th>
                            </tr>
                            <tr v-for="item,index in products" :key="index">
                                <td>
                                <%item.idc_name%>
                                </td>
                                <td>
                                <%item.product_name|productType%>
                                </td>
                                <td>
                                <%item.num%>
                                </td>
                                <td>
                                    <span v-if="item.status == 'finish'" class="badge badge-success">是</span>
                                    <span v-else class="badge badge-danger">否</span>
                                </td>
                                <td>
                                <%item.month%>
                                </td>
                                <th>
                                    <a class="btn btn-xs btn-primary" href="javascript:;"  @click.stop.prevent="upProduct(index)">
                                    <i class="fas fa-edit"></i>
                                    </a>
                                </th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-8">
                <div class="card" v-if="productType == 'seat'">
                    <div class="card-body">
                        <div class="alert alert-success">
                            最多分配<%maxSeat%>个散位
                        </div>
                        <div v-if="cabinetList.length == 0" class="alert alert-warning">
                            暂无可用机柜
                        </div>
                        <table v-else class="table">
                            <tr>
                                <th></th>
                                <th>#</th>
                                <th>
                                    名称
                                </th>
                            </tr>
                            <tr v-for="cabinet,index in cabinetList" :key="index">
                                <td>
                                    <div class="icheck-primary d-inline">
                                        <input :disabled="cabinet.used == 'true'" :id="'check_'+index" :value="cabinet.id" type="checkbox" v-model="cabinet.check"/>
                                        <label :for="'check_'+index"></label>
                                    </div>
                                </td>
                                <td>
                                    <%index + 1%>
                                </td>
                                <td>
                                    <input :readonly="cabinet.used == 'true'" type="text" class="form-control form-control-sm" v-model="cabinet.name"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-sm btn-primary" @click.stop.prevent="saveCabinet">
                            确认
                        </button>
                    </div>
                </div>
                <div class="card" v-if="productType == 'cabinet'">
                    <div class="card-body">
                        <div class="alert alert-success">
                            最多分配<%maxCabinet%>个柜
                        </div>
                        <div v-if="cabinetList.length == 0" class="alert alert-warning">
                            暂无可用机柜
                        </div>
                        <table v-else class="table">
                            <tr>
                                <th></th>
                                <th>#</th>
                                <th>
                                    名称
                                </th>
                            </tr>
                            <tr v-for="cabinet,index in cabinetList" :key="index">
                                <td>
                                    <div class="icheck-primary d-inline">
                                        <input :disabled="cabinet.used == 'true'" :id="'check_'+index" :value="cabinet.id" type="checkbox" v-model="cabinet.check"/>
                                        <label :for="'check_'+index"></label>
                                    </div>
                                </td>
                                <td>
                                    <%index + 1%>
                                </td>
                                <td>
                                    <input :readonly="cabinet.used == 'true'" type="text" class="form-control form-control-sm" v-model="cabinet.name"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-sm btn-primary" @click.stop.prevent="saveCabinet">
                            确认
                        </button>
                    </div>
                </div>
                <div class="card" v-if="productType == 'bandwidth_bgp' || productType == 'bandwidth_unicom' || productType == 'bandwidth_telecom' || productType == 'bandwidth_mobile'">
                    <div class="card-footer">
                        <button type="submit" class="btn btn-sm btn-primary" @click.stop.prevent="saveProduct">
                            确认
                        </button>
                    </div>
                </div>
                <div class="card" v-if="productType == 'ampere' || productType == 'bridge'">
                    <div class="card-footer">
                        <button type="submit" class="btn btn-sm btn-primary" @click.stop.prevent="saveProduct">
                            确认
                        </button>
                    </div>
                </div>
                <div class="card" v-if="productType == 'ip'">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6">
                                <div class="alert alert-success">
                                    最多分配<%maxIp%>个IP
                                </div>
                                <div class="alert alert-danger" v-if="canUseIp.length == 0">
                                    当前IDC下IP池为空
                                </div>
                                <ul v-else class="list-group overflow-auto" style="height:300px">
                                    <li class="list-group-item" v-for="ip,index in canUseIp" :key="index">
                                        <%ip.ip%>
                                        <div class="float-right">
                                            <button class="btn btn-default btn-xs" @click.stop.prevent="addIp(index)">>></button>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-6">
                                <div v-if="usedIp.length == 0" class="alert alert-danger">
                                    未分配
                                </div>
                                <ul v-else class="list-group overflow-auto" style="height:300px">
                                    <li class="list-group-item" v-for="ip,index in usedIp" :key="index">
                                        <%ip.ip%>
                                        <div class="float-right">
                                            <button class="btn btn-danger btn-xs" @click.stop.prevent="doDeleteIp(index)">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-sm btn-primary" @click.stop.prevent="saveIp">
                            保存
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    var ipEdit = new Vue({
        el:'#J_order_up',
        delimiters:['<%','%>'],
        data:{
            'orderStatus':"{{order['status']}}",
            'orderId':"{{order['id']}}",
            'doingTime':"",
            'customerId':{{order['customer_id']}},
            'products':{{json_encode(order['items'])}},
            'productType':'',
            'canUseIp':[],
            'usedIp':[],
            'newIp':{},
            'deleteIp':{},
            'maxIp':0,
            'maxCabinet':0,
            'maxSeat':0,
            'cabinetList':[],
            'activeItemId':0
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
            'upProduct':function(index){
                var self = this;
                var product = this.products[index];
                self.activeItemId = product.id;
                switch(product.product_type){
                    case 'bandwidth_bgp':
                    case 'bandwidth_unicom':
                    case 'bandwidth_telecom':
                    case 'bandwidth_mobile':
                        self.productType = product.product_type;
                    break;
                    case 'ampere':
                        self.productType = 'ampere';
                    break;
                    case 'bridge':
                        self.productType = 'bridge';
                    break;
                    case 'ip':
                        self.productType = 'ip';
                        self.maxIp = product.num - product.final_num;
                        $.ajax({
                            'url':"{{url('up/get_ip_list/')}}"+product.product_name+'/'+product.idc_id+'/'+product.customer_id+'/'+product.id,
                            'success':function(re){
                                self.canUseIp = re.can_use_ip;
                                self.usedIp = re.used_ip;
                                self.newIp = {};
                                self.deleteIp = {};
                            }
                        });
                    break;
                    case 'seat':
                        self.productType = 'seat';
                        self.maxSeat = product.num - product.final_num;
                        $.ajax({
                            'url':"{{url('up/get_cabinet_seat/')}}"+product.idc_id+'/'+product.product_name,
                            'success':function(re){
                                self.cabinetList = re;
                            }
                        });
                    break;
                    case 'cabinet':
                        self.productType = 'cabinet';
                        self.maxCabinet = product.num - product.final_num;
                        $.ajax({
                            'url':"{{url('up/get_cabinet_list/')}}"+product.idc_id+'/'+product.product_name,
                            'success':function(re){
                                self.cabinetList = re;
                            }
                        });
                    break;
                }
            },
            'addIp':function(index){
                if(this.maxIp > 0){
                    var ip = this.canUseIp[index];
                    this.maxIp = this.maxIp - 1;
                    this.usedIp.push(ip);
                    this.$delete(this.canUseIp,index);
                    this.$set(this.newIp,ip.id,true);
                    this.$delete(this.deleteIp,ip.id);
                }
            },
            'doDeleteIp':function(index){
                var ip = this.usedIp[index];
                this.maxIp = this.maxIp + 1;
                this.canUseIp.push(ip);
                this.$delete(this.usedIp,index);
                this.$set(this.deleteIp,ip.id,true);
                this.$delete(this.newIp,ip.id);
            },
            'saveCabinet':function(){
                var self = this;
                var length = self.cabinetList.length;
                var cabinets = [];
                for(var i = 0;i<length;i++){
                    if(self.cabinetList[i].check){
                        cabinets.push({
                            id:self.cabinetList[i].id,
                            name:self.cabinetList[i].name
                        });
                    }
                }
                $.ajax({
                    'url':"{{url('up/save_cabinet/'~order['customer_id'])}}"+'/'+self.activeItemId,
                    'type':'POST',
                    'data':{
                        cabinets:cabinets
                    },
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage();
                        }
                    }
                });
            },
            'saveProduct':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('up/save_product/'~order['customer_id'])}}"+'/'+self.activeItemId,
                    'type':'POST',
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage();
                        }
                    }
                });
            },
            'saveIp':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('up/save_ip/'~order['customer_id'])}}"+'/'+self.activeItemId,
                    'type':'POST',
                    'data':{
                        delete_ip:self.deleteIp,
                        new_ip:self.newIp
                    },
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage();
                        }
                    }
                });
            },
            'doUp':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('up/do_up/')}}"+'/'+self.orderId,
                    'type':'POST',
                    'data':{
                        doing_time:self.doingTime,
                    },
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage();
                        }
                    }
                });
            }
        }
    });
})();
</script>
<!-- /.content -->
