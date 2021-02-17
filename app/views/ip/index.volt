<!-- Content Header (Page header) -->
{{content_header(['title':'IP列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('ip/edit','新增ip','class':'btn btn-primary btn-sm')}}
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    批量导入
                                </button>
                                <div class="dropdown-menu">
                                    <a href="{{url('ip/template?download=true')}}" target="_blank" class="dropdown-item">
                                       下载CSV模板
                                    </a>
                                    <a href="javascript:;" id="J_upload_csv" class="dropdown-item">
                                       上传CSV文件
                                    </a>
                                </div>
                            </div>
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
                                {%switch(item.type)%}
                                    {%case 'bgp_ipv4'%}
                                        BGP IPv4
                                    {%break%}
                                    {%case 'bgp_ipv6'%}
                                        BGP IPv6
                                    {%break%}
                                    {%case 'unicom_ipv4'%}
                                        联通 IPv4
                                    {%break%}
                                    {%case 'unicom_ipv6'%}
                                        联通 IPv6
                                    {%break%}
                                    {%case 'telecom_ipv4'%}
                                        电信 IPv4
                                    {%break%}
                                    {%case 'telecom_ipv6'%}
                                        电信 IPv6
                                    {%break%}
                                    {%case 'mobile_ipv4'%}
                                        移动 IPv4
                                    {%break%}
                                    {%case 'mobile_ipv6'%}
                                        移动 IPv6
                                    {%break%}
                                {%endswitch%}
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
                            {{item.customer_id}}
                            </td>
                            <td>
                                {{link_to('ip/edit/'~ item.id,'编辑','class':'btn btn-primary btn-xs')}}
                                {{link_to('ip/delete/'~ item.id,'删除','class':'btn btn-danger btn-xs','data-event':'delete-ip')}}
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
<script type="text/template" id="J_upload_ip_modal">
<div class="modal fade">
    <div class="modal-dialog modal-">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">请选择csv文件</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <div class="col-sm-12">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="upload_csv" data-url="{{url('ip/upload_csv')}}">
                        <label class="custom-file-label" for="upload_csv">选择csv文件</label>
                      </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
</script>
<script>
(function(){
    $('#J_upload_csv').on('click',function(e){
        var modal = $($('#J_upload_ip_modal').text()).appendTo($('body'));
        modal.find('input').fileupload({
            add:function(e,data){
                var fileObj = data.files[0];
                if(fileObj['type'] == 'text/csv'){
                    return data.submit();
                }else{
                    return toastr.warning('请上传CSV文件');
                }
            },
            done:function(e,data){
                var re = data.result;
                if(re.status == 'success'){
                    toastr.success(re.msg, '成功');
                    modal.modal('hide');
                    loadPage();
                }else{
                    toastr.error(re.msg, '异常');
                }
            }
        });
        modal.on('hidden.bs.modal',function(){
            modal.remove();
        }).modal('show');
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
