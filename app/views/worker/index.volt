<!-- Content Header (Page header) -->
{{content_header(['title':'员工列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('worker/edit','新增员工','class':'btn btn-primary btn-sm')}}
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
                            <th>姓名</th>
                            <th>头像</th>
                            <th>部门</th>
                            <th>职务</th>
                            <th>电话</th>
                            <th>邮箱</th>
                            {%if permission('role-index')%}
                            <th>角色</th>
                            {%endif%}
                            <th>操作</th>
                        </tr>
                        {%for item in worker['items']%}
                        <tr>
                            <td>
                            {{item['id']}}
                            </td>
                            <td>
                            {{item['name']}}
                            </td>
                            <td>
                            {{item['avatar']}}
                            </td>
                            <td>
                            {{item['department']}}
                            </td>
                            <td>
                            {{item['position']}}
                            </td>
                            <td>
                            {{item['mobile']}}
                            </td>
                            <td>
                            {{item['email']}}
                            </td>
                            {%if permission('role-index')%}
                            <td>
                            {%if item['is_super']%}
                                <span class="badge badge-danger">
                                    超级管理员
                                </span>
                            {%elseif item['roles']%}
                                {%for role in item['roles']%}
                                <span class="badge badge-success">
                                {{role}}
                                </span>
                                {%endfor%}
                            {%endif%}
                                <button type="button" class="btn btn-warning btn-xs" data-event="role" data-id="{{item['id']}}">
                                    点击分配权限
                                </button>
                            </td>
                            {%endif%}
                            <td>
                                {{link_to('worker/edit/'~ item['id'],'编辑','class':'btn btn-primary btn-xs')}}
                                {%if item['disabled'] == 'false'%}
                                {{link_to('worker/disabled/'~ item['id'],'禁用','class':'btn btn-danger btn-xs','data-event':'disabled-worker')}}
                                {%else%}
                                {{link_to('worker/enable/'~ item['id'],'启用','class':'btn btn-warning btn-xs','data-event':'enable-worker')}}
                                {%endif%}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':worker['last']])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    {%if permission('role-index')%}
    $('[data-event="role"]').on('click',function(e){
        e.preventDefault();
        e.stopPropagation();
        var id = $(this).data('id');
        $.ajax({
            'url':"{{url('role/get_roles')}}",
            'success':function(re){
                var modal = $(re).appendTo($('body'));
                modal.on('hidden.bs.modal',function(){
                    modal.remove();
                }).on('click','.submit',function(){
                    var checked = modal.find('td input:checked');
                    if(checked.length > 0){
                        var value = [];
                        for(var i = 0;i < checked.length;i++){
                            value.push($(checked[i]).val());
                        }
                        $.ajax({
                            url:"{{url('role/save_account_role/')}}"+id,
                            type:'post',
                            data:{
                                role:value
                            },
                            success:function(roleRe){
                                if(roleRe.status == 'error'){
                                    toastr.error(roleRe.msg, '异常');
                                }else{
                                    toastr.success(roleRe.msg, '成功');
                                    loadPage();
                                }
                            }
                        });
                    }
                    modal.modal('hide');
                }).modal('show');
            }
        });
    });
    {%endif%}
    $('[data-event="disabled-worker"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要禁用该员工吗？",
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
    $('[data-event="enable-worker"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要启用该员工吗？",
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
