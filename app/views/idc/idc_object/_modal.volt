<div class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">请选择IDC</h4>
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
                        <th>名称</th>
                        <th>地址</th>
                    </tr>
                    {%for item in idc%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                        {%if multiple%}
                            <input type="checkbox" name="id" id="idc_{{item['id']}}" value="{{item['id']}}">
                        {%else%}
                            <input type="radio" name="id" id="idc_{{item['id']}}" value="{{item['id']}}">
                        {%endif%}
                            <label for="idc_{{item['id']}}"></label>
                        </div>
                        </td>
                        <td>
                        {{item['id']}}
                        </td>
                        <td>
                        {{item['name']}}
                        </td>
                        <td>
                            {{item['province']}}
                            {{item['city']}}
                            {{item['district']}}
                            <hr />
                            {{item['address']}}
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
