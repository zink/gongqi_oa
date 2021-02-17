<div class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">请选择角色</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tr>
                        <th>
                        {{select_all()}}
                        </th>
                        <th>#</th>
                        <th>名称</th>
                    </tr>
                    {%for item in roles%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="id" id="acl_role_{{item.id}}" value="{{item.id}}">
                            <label for="acl_role_{{item.id}}"></label>
                        </div>
                        </td>
                        <td>
                        {{item.id}}
                        </td>
                        <td>
                        {{item.name}}
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
