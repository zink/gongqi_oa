{{content_header(['title':title])}}
{{content_body()}}
    <div class="card form-horizontal" id="J_order_edit">
        <div class="card-body">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    订单编号
                </label>
                <div class="col-sm-6">
                    <h2>
                        {{order['id']}}
                    </h2>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    开通时间
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{date('Y-m-d',order['opening_time'])}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    计费开始时间
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{date('Y-m-d',order['billing_time'])}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    计费结束时间
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{date('Y-m-d',order['end_time'])}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    订单状态
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {%switch order['status']%}
                        {%case 'doing'%}
                        <span class="badge badge-warning">上架中</span>
                        {%break%}
                        {%case 'pending'%}
                        <span class="badge badge-warning">待审核</span>
                        {%break%}
                        {%case 'refuse'%}
                        <span class="badge badge-danger">驳回</span>
                        {%break%}
                        {%case 'loading'%}
                        <span class="badge badge-danger">待上架</span>
                        {%break%}
                        {%case 'active'%}
                        <span class="badge badge-success">活动订单</span>
                        {%break%}
                        {%case 'dead'%}
                        <span class="badge badge-secondary">作废订单</span>
                        {%break%}
                        {%case 'finish'%}
                        <span class="badge badge-info">完成订单</span>
                        {%break%}
                        {%endswitch%}
                    </p>
                </div>
            </div>
            {%if order['status'] == 'refuse'%}
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    驳回理由
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{order['refuse_remark']}}
                    </p>
                </div>
            </div>
            {%endif%}
            {%if permission('order-review')%}
            {%if order['status'] == 'pending'%}
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    审核
                </label>
                <div class="col-sm-4">
                    <div class="input-group input-group-sm">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                提成比例
                            </span>
                        </div>
                        <input type="number" class="form-control" v-model="commissionRatio" />
                        <div class="input-group-append">
                            <span class="input-group-text">%</span>
                            <button class="btn btn-primary" @click.stop.prevent="review(true)">
                                审核通过
                            </button>
                        </div>
                    </div>
                    <hr />
                    <div class="input-group input-group-sm">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                理由
                            </span>
                        </div>
                        <input type="text" class="form-control" v-model="refuseRemark" />
                        <div class="input-group-append">
                            <button class="btn btn-danger" @click.stop.prevent="review(false)">
                                驳回
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            {%endif%}
            {%endif%}
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    提成比例
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{order['commission_ratio'] * 100}}%
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    客户主体
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{order['subject']}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    责任销售
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        {{order['worker_name']}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    总价
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        <h2 class="text-red">￥{{normalTotal}}</h2>
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    折后总价
                    <span class="badge badge-primary">{{round(order['total'] / normalTotal,2) * 100}}折</span>
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                        <h2 class="text-red">
                        ￥{{order['total']}}
                        </h2>
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    备注
                </label>
                <div class="col-sm-6">
                    <p class="form-control-plaintext">
                    {{order['remark']}}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    销售清单
                </label>
                <div class="col-sm-10">
                    <table class="table table-striped">
                        <tr>
                            <th>IDC</th>
                            <th>产品</th>
                            <th>上架</th>
                            <th>建议销售价/月</th>
                            <th>实际售价/月</th>
                            <th>数量</th>
                            <th>购买月</th>
                            <th>总价</th>
                            <th>实际总价</th>
                        </tr>
                        <tr v-for="item in orderItems">
                            <td>
                            <%item.idc_name%>
                            </td>
                            <td>
                            <%item.product_name|productType%>
                            </td>
                            <td>
                                <span v-if="item.status == 'finish'" class="badge badge-success">是</span>
                                <span v-else class="badge badge-danger">否</span>
                            </td>
                            <td>
                            <%item.price%>
                            </td>
                            <td>
                            <%item.final_price%>
                            </td>
                            <td>
                            <%item.num%>
                            </td>
                            <td>
                            <%item.month%>
                            </td>
                            <td>
                            ￥<%item.num * item.price * item.month%>
                            </td>
                            <td>
                                <span class="text-red">
                                    ￥<%item.num * item.final_price * item.month%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    var ipEdit = new Vue({
        el:'#J_order_edit',
        delimiters:['<%','%>'],
        data:{
            'commissionRatio':0,
            'refuseRemark':'',
            'orderItems':{{json_encode(order['items'])}},
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
            'review':function(pass){
                var self = this;
                if(pass){
                    var url = "{{url('order/review/'~order['id'])}}/1";
                    var data = {
                        'commission_ratio':self.commissionRatio / 100
                    };
                }else{
                    var url = "{{url('order/review/'~order['id'])}}/0";
                    var data = {
                        'refuse_remark':self.refuseRemark
                    };
                }
                $.ajax({
                    'url':url,
                    'type':'POST',
                    'data':data,
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage(re.redirect);
                        }
                    }
                });
            }
        }
    });
})();
</script>
<!-- /.content -->
