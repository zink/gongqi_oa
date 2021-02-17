<!-- Content Header (Page header) -->
{{content_header(['title':'销售线索列表'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-7">
                            {{link_to('opportunity/edit','新增销售线索','class':'btn btn-primary btn-sm')}}
                            {%if permission('opportunity-all')%}
                            {{batch(['menu':['批量分配线索':"batch_worker_callback"]])}}
                            <a href="{{url('opportunity')}}" type="button" class="btn btn-warning btn-sm" >
                                全部
                            </a>
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    责任人筛选
                                </button>
                                <div class="dropdown-menu">
                                    <a href="javascript:search('worker','');" class="dropdown-item">
                                       所有人
                                    </a>
                                    {%for item in workers%}
                                    <a href="javascript:search('worker','{{item['id']}}');" class="dropdown-item">
                                        {{item['name']}}
                                    </a>
                                    {%endfor%}
                                </div>
                            </div>
                            {%endif%}
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    状态筛选
                                </button>
                                <div class="dropdown-menu">
                                    <a href="javascript:search('status','');" class="dropdown-item">
                                       所有状态
                                    </a>
                                    <a href="javascript:search('status','active');" class="dropdown-item">
                                       跟踪中 
                                    </a>
                                    <a href="javascript:search('status','success');" class="dropdown-item">
                                       成单
                                    </a>
                                    <a href="javascript:search('status','dead');" class="dropdown-item">
                                       作废
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="input-group input-group-sm">
                            {{search([
                                'url':'opportunity/index/',
                                'menu':[
                                    '公司名':"company"
                                ]
                            ])}}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <table class="table table-striped">
                        <tr>
                            <th>
                            {{select_all()}}
                            </th>
                            <th>#</th>
                            <th>公司名</th>
                            <th>状态</th>
                            <th>所属大区</th>
                            <th>责任销售</th>
                            <th>来源</th>
                            <th>创建时间</th>
                            <th>最后更新时间</th>
                            <th>操作</th>
                        </tr>
                        {%for item in opportunity['items']%}
                        <tr>
                            <td>
                                <div class="icheck-primary d-inline">
                                    <input id="check_{{item['id']}}" value="{{item['id']}}" type="checkbox"/>
                                    <label for="check_{{item['id']}}"></label>
                                </div>
                            </td>
                            <td>
                            {{item['id']}}
                            </td>
                            <td>
                            {{item['company']}}
                            </td>
                            <td>
                            {%switch(item['status'])%}
                                {%case 'active'%}
                                <span class="badge badge-warning">
                                    跟踪中
                                </span>
                                {%break%}
                                {%case 'dead'%}
                                <span class="badge badge-secondary">
                                    作废
                                </span>
                                {%break%}
                                {%case 'success'%}
                                <span class="badge badge-success">
                                    成单
                                </span>
                                {%break%}
                                {%default%}
                                <span class="badge badge-danger">
                                    无状态
                                </span>
                                {%break%}
                            {%endswitch%}
                            </td>
                            <td>
                            {%switch item['area']%}
                                {%case 'east_china'%}
                                华东
                                {%break%}
                                {%case 'south_china'%}
                                华南
                                {%break%}
                                {%case 'northwest_china'%}
                                西北
                                {%break%}
                                {%case 'southwest_china'%}
                                西南
                                {%break%}
                                {%case 'north _china'%}
                                华北
                                {%break%}
                                {%case 'northeast_china'%}
                                东北
                                {%break%}
                                {%case 'central_china'%}
                                华中
                                {%break%}
                                {%case 'foreign'%}
                                海外
                                {%break%}
                            {%endswitch%}
                            </td>
                            <td>
                            {{item['worker_name']}}
                            </td>
                            <td>
                            {{item['origin']}}
                            </td>
                            <td>
                            {{date('Y-m-d H:i:s',item['create_time'])}}
                            </td>
                            <td>
                            {%if item['update_time']%}
                            {{date('Y-m-d H:i:s',item['update_time'])}}
                            {%else%}
                            -
                            {%endif%}
                            </td>
                            <td>
                                {{link_to('opportunity/edit/'~ item['id'],'编辑','class':'btn btn-primary btn-xs')}}
                            </td>
                        </tr>
                        {% endfor %}
                    </table>
                </div>
                <div class="card-footer clearfix">
                    {{pagination(['last':opportunity['last']])}}
                </div>
            </div>
        </div>
    </div>
{%if permission('opportunity-all')%}
<script type="text/template" id="J_batch_worker_modal">
<div class="modal fade">
    <div class="modal-dialog modal-">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">请选择员工</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    {%for item in worker['items']%}
                    <tr>
                        <td>
                            <div class="icheck-primary d-inline">
                                <input type="radio" id="modal_worker_{{item['id']}}" name="status"value="{{item['id']}}">
                                <label for="modal_worker_{{item['id']}}">{{item['name']}}</label>
                            </div>
                        </td>
                    </tr>
                    {% endfor %}
                </table>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary submit">确定</button>
            </div>
        </div>
    </div>
</div>
</script>
<script>
var batch_worker_callback = function(values){
    var modal = $($('#J_batch_worker_modal').text()).appendTo($('body'));
    modal.on('hidden.bs.modal',function(){
        modal.remove();
    }).on('click','.submit',function(){
        var checked = modal.find('td input:checked');
        if(checked.length > 0){
            if(checked.length > 0){
                var worker = 0;
                worker = $(checked[0]).val();
                $.ajax({
                    url:"{{url('opportunity/batch_worker/')}}",
                    type:'post',
                    data:{
                        opportunity:values,
                        worker:worker
                    },
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
        modal.modal('hide');
    }).modal('show');
}
</script>
{%endif%}
{{end_content_body()}}
