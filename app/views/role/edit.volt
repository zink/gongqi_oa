{{content_header(['title':title])}}
{{content_body()}}
    <div class="card" id="J_account_role">
        {{ form('role/save','method':'post','class':'form-horizontal') }}
        <div class="card-body">
            <div class="form-group row">
                <input type="hidden" :value="id" name="id"/>
                <label class="col-sm-2 col-form-label">
                    角色名称
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="name" class="form-control" v-model="name"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    超级管理员
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6 clearfix">
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="true_super" name="is_super" v-model="is_super" value="true">
                        <label for="true_super">是</label>
                    </div>
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="false_super" name="is_super" v-model="is_super" value="false">
                        <label for="false_super">否</label>
                    </div>
                </div>
            </div>
            <div v-if="acl" class="form-group row">
                <label class="col-sm-2 col-form-label">权限资源</label>
                <div class="col-sm-10">
                    <table class="table table-bordered">
                        <tr>
                            <th>
                                模块
                            </th>
                            <th>
                                权限列表
                            </th>
                        </tr>
                        <tr v-for="item in acl">
                            <td>
                            <% item.title %>
                            </td>
                            <td>
                                <div class="row">
                                    <template v-for="action,key in item.actions ">
                                        <div v-for="v,k in action" class="col-md-3 col-xs-6">
                                            <div class="icheck-primary">
                                                <input type="checkbox" :id="key+'-'+v.action" v-model="resource" :value="key+'-'+v.action" name="resource[]">
                                                <label :for="key+'-'+v.action">
                                                    <%v.title%>
                                                </label>
                                            </div>
                                        </div>
                                    </template>
                                </div>
                            </td>
                        </tr>
                    </table>
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
<script>
(function(){
    var accountRole = new Vue({
        el:'#J_account_role',
        delimiters:['<%','%>'],
        data:{
            id:{{role.id?role.id:0}},
            name:"{{role.name?role.name:''}}",
            resource:{{role.resource?role.resource:'[]'}},
            is_super:"{{role.is_super}}",
            acl:{{acl}}
        }
    });
})();
</script>

