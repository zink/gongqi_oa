<!-- Content Header (Page header) -->
{{content_header(['title':'机柜列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
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
                            <th>类型</th>
                            <th>所属机房</th>
                            <th>使用情况</th>
                            <th>客户</th>
                            <th>操作</th>
                        </tr>
                        {%for item in cabinet.items%}
                        <tr>
                            <td>
                                {{item.id}}
                            </td>
                            <td>
                                {{item.ampere}}
                            </td>
                            <td>
                                {{item.idc.name}}
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
                            {{item.customer_id}}
                            </td>
                            <td>
                            {%if item.customer_id != 0%}
                                {{link_to('ip/unbind/'~ item.id,'释放','class':'btn btn-primary btn-xs','data-event':'unbind-ip')}}
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
