<!-- Content Header (Page header) -->
{{content_header(['title':'机房列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('idc/edit','新增机房','class':'btn btn-primary btn-sm')}}
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
                            <th>机房名称</th>
                            <th>地址</th>
                            <th>操作</th>
                        </tr>
                        {%for item in idc['items']%}
                        <tr>
                            <td>
                            {{item['id']}}
                            </td>
                            <td>
                            {{item['name']}}
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
                                {{link_to('idc/edit/'~ item['id'],'编辑','class':'btn btn-primary btn-xs')}}
                                {{link_to('idc/delete/'~ item['id'],'删除','class':'btn btn-danger btn-xs','data-event':'delete-idc')}}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':idc['last']])}}
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    $('[data-event="delete-idc"]').on('click',function(e){
        e.preventDefault();
        var $el = $(this);
        bootbox.confirm({
            'message':"确定要删除该机房吗？",
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
