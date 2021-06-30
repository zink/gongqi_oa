<div class="card-body" id="J_order_basic">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            订单编号
        </label>
        <div class="col-sm-6">
            <h2>
                {{order.id}}
            </h2>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            合同
        </label>
        <div class="col-sm-6">
            <upload-object 
                url="{{url('order/contract/'~order.id)}}"
                image="{{order.contract?url('order/attachment/'~order.id~'?download=1'):''}}"
            ></upload-object>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            开通时间
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {{date('Y-m-d',order.opening_time)}}
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            计费开始时间
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {{date('Y-m-d',order.billing_time)}}
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            计费结束时间
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {{date('Y-m-d',order.end_time)}}
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            账单周期
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {%switch order.bill_type%}
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
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            订单状态
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {%switch order.status%}
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
    {%if order.status == 'refuse'%}
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            驳回理由
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {{order.refuse_remark}}
            </p>
        </div>
    </div>
    {%endif%}
    {%if permission('order-review')%}
    {%if order.status == 'pending'%}
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
                {{order.commission_ratio * 100}}%
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            客户主体
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {{order.subject}}
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            责任销售
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                {{order.worker_name}}
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
            <span class="badge badge-primary">{{round(order.total / normalTotal,2) * 100}}折</span>
        </label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                <h2 class="text-red">
                ￥{{order.total}}
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
            {{order.remark}}
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
                {%for item in order.orderItem%}
                <tr>
                    <td>
                    {{item.idc_name}}
                    </td>
                    <td>
                    {{product_type(item.product_name)}}
                    </td>
                    <td>
                        {%if item.status == 'finish'%}
                        <span class="badge badge-success">是</span>
                        {%else%}
                        <span class="badge badge-danger">否</span>
                        {%endif%}
                    </td>
                    <td>
                    {{item.price}}
                    </td>
                    <td>
                    {{item.final_price}}
                    </td>
                    <td>
                    {{item.num}}
                    </td>
                    <td>
                    {{item.month}}
                    </td>
                    <td>
                    ￥{{item.num * item.price * item.month}}
                    </td>
                    <td>
                        <span class="text-red">
                            ￥{{item.num * item.final_price * item.month}}
                        </span>
                    </td>
                </tr>
                {%endfor%}
            </table>
        </div>
    </div>
</div>
<script>
(function(){
    new Vue({
        el:'#J_order_basic',
        delimiters:['<%','%>'],
        data:{
            'commissionRatio':0,
            'refuseRemark':'',
        },
        methods:{
            'review':function(pass){
                var self = this;
                if(pass){
                    var url = "{{url('order/review/'~order.id)}}/1";
                    var data = {
                        'commission_ratio':self.commissionRatio / 100
                    };
                }else{
                    var url = "{{url('order/review/'~order.id)}}/0";
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
