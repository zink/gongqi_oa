<div class="card-body">
    <div class="card">
        {{ form('customer/add_contact/'~customer['id'],'method':'post','class':'form-horizontal') }}
        <div class="card-body">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    姓名
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-4">
                    <input type="text" name="name" class="form-control" placeholder="请输入联系人姓名"/>
                </div>
                <label class="col-sm-2 col-form-label">
                    职务
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-4">
                    <input type="text" name="position" class="form-control" placeholder="请输入联系人职务"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    类型
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-4">
                    <select class="form-control" name="type">
                        <option value="key">关键人</option>
                        <option value="decision">决策人</option>
                        <option value="contact">联系人</option>
                        <option value="other">其他</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label">
                    电话
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-4">
                    <input type="text" name="mobile" class="form-control" placeholder="请输入联系人电话号码"/>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary">
                新增
            </button>
        </div>
        {{endform}}
    </div>
</div>
<div class="card-body p-0">
    <table class="table table-striped">
        <tr>
            <th>#</th>
            <th>姓名</th>
            <th>职务</th>
            <th>类型</th>
            <th>电话</th>
        </tr>
        {%for item in contact%}
        <tr>
            <td>
            {{item.id}}
            </td>
            <td>
            {{item.name}}
            </td>
            <td>
            {{item.position}}
            </td>
            <td>
            {%switch(item.type)%}
                {%case 'key'%}
                    关键人
                {%break%}
                {%case 'decision'%}
                    决策人
                {%break%}
                {%case 'contact'%}
                    联系人
                {%break%}
                {%case 'other'%}
                {%default%}
                    其他
                {%break%}
            {%endswitch%}
            </td>
            <td>
            {{item.mobile}}
            </td>
        </tr>
        {% endfor %}
    </table>
</div>
