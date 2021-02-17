<!-- Content Header (Page header) -->
{{content_header(['title':'客户列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('customer/edit','新增客户','class':'btn btn-primary btn-sm')}}
                        </div>
                        <div class="col-sm-5">
                            <div class="input-group input-group-sm">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-striped">
                        <tr>
                            <th>#</th>
                            <th>实体名称</th>
                            <th>认证状态</th>
                            <th>责任销售</th>
                            <th>地址</th>
                            <th>操作</th>
                        </tr>
                        {%for item in customer['items']%}
                        <tr>
                            <td>
                            {{item['id']}}
                            </td>
                            <td>
                            {{item['subject']?item['subject']:'-'}}
                            </td>
                            <td>
                            {%if item['certification'] == 'true'%}
                            <span class="badge badge-success">已认证</span>
                            {%else%}
                            <span class="badge badge-danger">未认证</span>
                            {%endif%}
                            </td>
                            <td>
                            {%if item['worker_name']%}
                                {{item['worker_name']}}
                            {%else%}
                                <span class="badge badge-warning">
                                    暂无
                                </span>
                            {%endif%}
                            </td>
                            <td>
                            {%if item['province']%}
                                {{item['province']}}
                                {{item['city']}}
                                {{item['district']}}
                                <hr />
                                {{item['address']}}
                            {%else%}
                                <span class="badge badge-warning">
                                    暂无
                                </span>
                            {%endif%}
                            </td>
                            <td>
                                {%if permission('order-new_order')%}
                                {{link_to('order/new_order/'~ item['id'],'建单','class':'btn btn-warning btn-xs')}}
                                {%endif%}
                                {{link_to('customer/edit/'~ item['id'],'编辑','class':'btn btn-primary btn-xs')}}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':customer['last']])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
