<!-- Content Header (Page header) -->
{{content_header(['title':'IP列表'])}}
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
                            <th>IP</th>
                            <th>类型</th>
                            <th>区域</th>
                            <th>所属机房</th>
                            <th>使用情况</th>
                            <th>客户</th>
                            <th>操作</th>
                        </tr>
                        {%for item in ip.items%}
                        <tr>
                            <td>
                            {{item.id}}
                            </td>
                            <td>
                            {{item.ip}}
                            </td>
                            <td>
                                {{item.type}}
                            </td>
                            <td>
                                {{item.province}}
                                {{item.city}}
                                {{item.district}}
                            </td>
                            <td>
                                {%for idc in item.ipIdc%}
                                    {{idc.idc.name}}
                                    <hr />
                                {%endfor%}
                            </td>
                            <td>
                            {%if item.customer_id != 0%}
                                <span class="badge badge-success">
                                    已使用
                                </span>
                            {%else%}
                                <span class="badge badge-danger">
                                    未使用
                                </span>
                            {%endif%}
                            </td>
                            <td>
                            {{customer[item.id]}}
                            </td>
                            <td>
                            {%if item.customer_id != 0%}
                                {{link_to('ipcm/unbind/'~ item.id,'释放','class':'btn btn-primary btn-xs','data-event':'unbind-ip')}}
                            {%else%}
                                {{link_to('ipcm/customer/'~ item.id,'分配','class':'btn btn-primary btn-xs')}}
                            {%endif%}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':ip.last])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    $('[data-event="unbind-ip"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要释放该IP吗？",
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
    $('[data-event="delete-ip"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要删除该IP吗？",
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
