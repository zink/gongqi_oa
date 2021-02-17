<!-- Content Header (Page header) -->
{{content_header(['title':'带宽列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('bandwidth/edit','新增带宽','class':'btn btn-primary btn-sm')}}
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
                            <th>类型</th>
                            <th>可用IDC</th>
                            <th>总量</th>
                            <th>用量</th>
                            <th>操作</th>
                        </tr>
                        {%for item in bandwidth.items%}
                        <tr>
                            <td>
                            {{item.id}}
                            </td>
                            <td>
                            {%switch(item.type)%}
                            {%case 'bgp'%}
                                BGP
                            {%break%}
                            {%case 'unicom'%}
                                联通
                            {%break%}
                            {%case 'telecom'%}
                                电信
                            {%break%}
                            {%case 'mobile'%}
                                移动
                            {%break%}
                            {%endswitch%}
                            </td>
                            <td>
                                {%for idc in item.bandwidthIdc%}
                                    {{idc.idc.name}}
                                    <hr />
                                {%endfor%}
                            </td>
                            <td>
                            {{item.total}}MB
                            </td>
                            <td>
                            {{item.used}}MB
                            </td>
                            <td>
                                {{link_to('bandwidth/edit/'~ item.id,'编辑','class':'btn btn-primary btn-xs')}}
                                {{link_to('bandwidth/delete/'~ item.id,'删除','class':'btn btn-danger btn-xs','data-event':'delete-ip')}}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':bandwidth.last])}}
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
