<div class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                订单编号:{{order['id']}}
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="pill" href="#J_order_basic" role="tab" aria-controls="J_order_basic" aria-selected="true">
                            基本信息
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="pill" href="#J_order_attachment" role="tab" aria-controls="J_order_attachment" aria-selected="false">
                            合同
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="pill" href="#J_order_items" role="tab" aria-controls="J_order_items" aria-selected="false">
                            购买清单
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="J_order_basic">
                        <table class="table">
                            <tr>
                                <th>
                                    开通时间
                                </th>
                                <td>
                                    {{date('Y-m-d',order['opening_time'])}}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    计费开始时间
                                </th>
                                <td>
                                    {{date('Y-m-d',order['billing_time'])}}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    计费开始时间
                                </th>
                                <td>
                                    {{date('Y-m-d',order['billing_time'])}}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                计费结束时间
                                </th>
                                <td>
                                    {{date('Y-m-d',order['end_time'])}}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                账单周期
                                </th>
                                <td>
                                    {%switch order['bill_type']%}
                                        {%case 'month'%}
                                            <span class="badge badge-info">月付</span>
                                        {%break%}
                                        {%case 'three_month'%}
                                            <span class="badge badge-info">季付</span>
                                        {%break%}
                                        {%case 'half_month'%}
                                            <span class="badge badge-info">半年付</span>
                                        {%break%}
                                        {%case 'year'%}
                                            <span class="badge badge-info">年付</span>
                                        {%break%}
                                    {%endswitch%}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                订单状态
                                </th>
                                <td>
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
                                </td>
                            </tr>
                            <tr>
                                <th>
                                提成比例
                                </th>
                                <td>
                                    {{order['commission_ratio'] * 100}}%
                                </td>
                            </tr>
                            <tr>
                                <th>
                                客户主体
                                </th>
                                <td>
                                    {{order['subject']}}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                责任销售
                                </th>
                                <td>
                                    {{order['worker_name']}}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                总价
                                </th>
                                <td>
                                    <h2 class="text-red">￥{{normalTotal}}</h2>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                折后总价
                                <span class="badge badge-primary">{{round(order['total'] / normalTotal,2) * 100}}折</span>
                                </th>
                                <td>
                                    <h2 class="text-red">
                                    ￥{{order['total']}}
                                    </h2>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                备注
                                </th>
                                <td>
                                {{order['remark']}}
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="J_order_attachment">
                        <div class="image-box">
                            <img src="{{order['contract']?url('order/attachment/'~order['id']~'?download=1'):''}}" alt="" class="img-thumbnail"/>
                        </div>
                    </div>
                    <div class="tab-pane" id="J_order_items">
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
            <script>
            (function(){
                new Vue({
                    el:'#J_order_items',
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
                });
            })();
            </script>
        </div>
    </div>
</div>
