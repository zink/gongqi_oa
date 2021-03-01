<!-- Content Header (Page header) -->
{{content_header(['title':'待确收账单'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7"></div>
                        <div class="col-sm-5">
                            <div class="input-group input-group-sm">
                            {{search([
                                'url':'bill/index/',
                                'menu':[
                                    '订单号':"id",
                                    '客户名':"company_name"
                                ]
                            ])}}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-striped">
                        <tr>
                            <th>客户主体/订单号</th>
                            <th>责任销售</th>
                            <th>账单开始时间</th>
                            <th>账单结束时间</th>
                            <th>状态</th>
                            <th>应收金额</th>
                            <th>付款凭证</th>
                            <th>确收时间</th>
                            <th>确收人</th>
                            <th>操作</th>
                        </tr>
                        {%for item in bills.items%}
                        <tr>
                            <td>
                                {{item.orders.subject}}
                                <br />
                                {{item.orders.id}}
                            </td>
                            <td>
                                {{item.orders.worker_name}}
                            </td>
                            <td>
                                {{date('Y-m-d',item.billing_time)}}
                            </td>
                            <td>
                                {{date('Y-m-d',item.end_time)}}
                            </td>
                            <td>
                                {%if item.pay_status == 'unpayed'%}
                                    <span class="badge badge-danger">未付款</span>
                                {%else%}
                                    <span class="badge badge-success">已付款</span>
                                {%switch item.status%}
                                {%case 'pending'%}
                                    <span class="badge badge-warning">未确认</span>
                                {%break%}
                                {%case 'finish'%}
                                    <span class="badge badge-success">已确收</span>
                                {%break%}
                                {%endswitch%}
                                {%endif%}
                            </td>
                            <td>
                                <span class="text-red">
                                ￥{{item.total}}
                                </span>
                            </td>
                            <td>
                                {%if item.pay_status == 'payed'%}
                                <a href="{{url('order/bill_attachment/'~item.id~'?download=1')}}" data-event="show-contract">查看</a>
                                {%else%}
                                    -
                                {%endif%}
                            </td>
                            <td>
                                {%if item.finish_time%}
                                {{date('Y-m-d',item.finish_time)}}
                                {%else%}
                                -
                                {%endif%}
                            </td>
                            <td>
                                {%if item.finish_worker_name%}
                                {{item.finish_worker_name}}
                                {%else%}
                                -
                                {%endif%}
                            </td>
                            <td>
                                {%if item.pay_status == 'payed' and item.status == 'pending'%}
                                <a href="{{url('bill/finish/'~item.id)}}" class="btn btn-xs btn-primary" data-event="finish-bill">确收</a>
                                {%endif%}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':bill.last])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script type="text/template" id="J_show_bill_contract">
<div class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="image-box" style="width:200px;">
                    <img src="" class="img-thumbnail">
                </div>
            </div>
        </div>
    </div>
</div>
</script>
<script>
(function(){
    $('[data-event="show-contract"]').on('click',function(e){
        e.preventDefault();
        var modal = $($('#J_show_bill_contract').text()).appendTo($('body'));
        var $el = $(this);
        modal.modal('show').on('hidden.bs.modal',function(){
            modal.remove();
        }).find('img').prop('src',$el.prop('href'));
    });
    $('[data-event="finish-bill"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要确收该账单吗?",
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
                    $.ajax({
                        url:$el.prop('href'),
                        success:function(re){
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
    });
})();
</script>
