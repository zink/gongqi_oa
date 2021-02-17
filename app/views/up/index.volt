<!-- Content Header (Page header) -->
{{content_header(['title':'上架单'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
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
                            <th>客户主体</th>
                            <th>责任销售</th>
                            <th>状态</th>
                            <th>下单时间</th>
                            <th>更新时间</th>
                            <th>操作</th>
                        </tr>
                        {%for item in orders.items%}
                        <tr>
                            <td>
                            {{item.id}}
                            </td>
                            <td>
                                {{item.subject}}
                            </td>
                            <td>
                                {{item.worker_name}}
                            </td>
                            <td>
                                {%switch item.status%}
                                {%case 'doing'%}
                                <span class="badge badge-danger">上架中</span>
                                {%break%}
                                {%case 'loading'%}
                                <span class="badge badge-danger">待上架</span>
                                {%break%}
                                {%case 'part_loading'%}
                                <span class="badge badge-warning">部分上架</span>
                                {%break%}
                                {%endswitch%}
                            </td>
                            <td>
                            {{date('Y-m-d H:i:s',item.create_time)}}
                            </td>
                            <td>
                            {%if item.update_time%}
                            {{date('Y-m-d H:i:s',item.update_time)}}
                            {%else%}
                            -
                            {%endif%}
                            </td>
                            <td>
                                {%if permission('up-index')%}
                                {{link_to('up/edit/'~ item.id,'查看','class':'btn btn-primary btn-xs')}}
                                {%endif%}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':orders.last])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
