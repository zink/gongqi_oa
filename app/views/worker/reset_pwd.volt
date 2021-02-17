{{content_header(['title':'重置密码'])}}
{{content_body()}}
    <div class="card">
        {{ form('worker/save_pwd','method':'post','class':'form-horizontal') }}
        <div class="card-body" id="J_worker_edit">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    旧密码
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="password" name="password" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">新密码</label>
                <div class="col-sm-6">
                    <input type="password" name="new_password" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">再输一遍新密码</label>
                <div class="col-sm-6">
                    <input type="password" name="confirm_password" class="form-control"/>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary">
                保存
            </button>
        </div>
        {{ endform() }}
    </div>
{{end_content_body()}}
<!-- /.content -->
