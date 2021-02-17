<div class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">请选择员工</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tr>
                        <th>
                        {%if multiple%}
                            {{select_all()}}
                        {%endif%}
                        </th>
                        <th>#</th>
                        <th>姓名</th>
                        <th>头像</th>
                        <th>部门</th>
                        <th>职务</th>
                        <th>邮箱</th>
                    </tr>
                    {%for item in worker['items']%}
                    <tr data-name="{{item['name']}}" data-position="{{item['position']}}" data-mobile="{{item['mobile']}}" data-email="{{item['email']}}">
                        <td>
                        <div class="icheck-primary">
                        {%if multiple%}
                            <input type="checkbox" name="id" id="worker_{{item['id']}}" value="{{item['id']}}">
                        {%else%}
                            <input type="radio" name="id" id="worker_{{item['id']}}" value="{{item['id']}}">
                        {%endif%}
                            <label for="worker_{{item['id']}}"></label>
                        </div>
                        </td>
                        <td>
                        {{item['id']}}
                        </td>
                        <td>
                        {{item['name']}}
                        </td>
                        <td>
                        {{item['avatar']?item['department']:'-'}}
                        </td>
                        <td>
                        {{item['department']?item['department']:'-'}}
                        </td>
                        <td>
                        {{item['position']?item['position']:'-'}}
                        </td>
                        <td>
                        {{item['email']}}
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
