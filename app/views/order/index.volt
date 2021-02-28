<!-- Content Header (Page header) -->
{{content_header(['title':'订单列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            <a href="{{url('order')}}" type="button" class="btn btn-default btn-sm" >
                                全部订单
                            </a>
                        </div>
                        <div class="col-sm-5">
                            <div class="input-group input-group-sm">
                            {{search([
                                'url':'order/index/',
                                'menu':[
                                    '订单号':"id"
                                ]
                            ])}}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-striped">
                        <tr>
                            <th>#</th>
                            <th>客户主体</th>
                            <th>责任销售</th>
                            <th>状态</th>
                            <th>总价</th>
                            <th>建单时间</th>
                            <th>开通时间</th>
                            <th>计费开始时间</th>
                            <th>计费结束时间</th>
                            <th>操作</th>
                        </tr>
                        {%for item in orders['items']%}
                        <tr>
                            <td>
                            {{item['id']}}
                            </td>
                            <td>
                                {{item['subject']}}
                            </td>
                            <td>
                                {{item['worker_name']}}
                            </td>
                            <td>
                                {%switch item['status']%}
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
                            <td>
                                <span class="text-red">
                                ￥{{item['total']}}
                                </span>
                            </td>
                            <td>
                            {{date('Y-m-d H:i:s',item['create_time'])}}
                            </td>
                            <td>
                            {%if item['opening_time']%}
                            {{date('Y-m-d',item['opening_time'])}}
                            {%else%}
                            -
                            {%endif%}
                            </td>
                            <td>
                            {%if item['billing_time']%}
                            {{date('Y-m-d',item['billing_time'])}}
                            {%else%}
                            -
                            {%endif%}
                            </td>
                            <td>
                            {%if item['end_time']%}
                            {{date('Y-m-d',item['end_time'])}}
                            {%else%}
                            -
                            {%endif%}
                            </td>
                            <td>
                                {%if permission('order-edit')%}
                                {{link_to('order/edit/'~ item['id'],'查看','class':'btn btn-primary btn-xs')}}
                                {%endif%}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':orders['last']])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
