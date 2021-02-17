{{content_header(['title':'角色列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('role/edit','新增操作角色','class':'btn btn-primary btn-sm')}}
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
                            <th>角色名称</th>
                            <th>是否超级管理员</th>
                            <th>操作</th>
                        </tr>
                        {%for item in role%}
                        <tr>
                            <td>
                            {{item.id}}
                            </td>
                            <td>
                            {{item.name}}
                            </td>
                            <td>
                            {%if item.is_super == 'true'%}
                            <div class="badge badge-danger">
                                是
                            </div>
                            {%else%}
                            <div class="badge badge-primary">
                                否
                            </div>
                            {%endif%}
                            </td>
                            <td>
                                {{link_to('role/edit/'~ item.id,'编辑','class':'btn btn-primary btn-xs')}}
                                {{link_to('role/delete/'~ item.id,'删除','class':'btn btn-danger btn-xs','data-event':'delete-role')}}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    $('[data-event="delete-role"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要删除改该角色吗？",
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
