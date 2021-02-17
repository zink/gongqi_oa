{{content_header(['title':title])}}
{{content_body()}}
    <div class="card">
        {{ form('worker/save','method':'post','class':'form-horizontal') }}
        <div class="card-body" id="J_worker_edit">
            <div class="form-group row">
                <input v-if="id" type="hidden" :value="id" name="id"/>
                <label class="col-sm-2 col-form-label">
                    姓名
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="name" v-model="name" class="form-control" placeholder="请输入员工姓名"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">密码</label>
                <div class="col-sm-6">
                临时
                    <input type="text" name="password" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">头像</label>
                <div class="col-sm-6">
                    <input type="text" name="avatar" v-model="avatar" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    性别
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6 clearfix">
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="sex_male" name="sex" v-model="sex" value="male">
                        <label for="sex_male">男</label>
                    </div>
                    <div class="icheck-primary d-inline">
                        <input type="radio" id="sex_female" name="sex" v-model="sex" value="female" checked="">
                        <label for="sex_female">女</label>
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    邮箱
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="email" v-model="email" class="form-control" placeholder="请输入员工邮箱"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    手机
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="mobile" v-model="mobile" class="form-control" placeholder="请输入员工手机"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">座机</label>
                <div class="col-sm-6">
                    <input type="text" name="tel" v-model="tel" class="form-control" placeholder="请输入员工座机"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    部门
                </label>
                <div class="col-sm-6">
                    <input type="text" name="department_id" v-model="department_id" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                职务
                </label>
                <div class="col-sm-6">
                    <select name="position_id" v-model="position_id" class="form-control">
                        <option v-for="position,pindex in position_list" :value="position.id" :key="pindex">
                        <%position.rank+position.level+position.name%>
                        </option>
                    </select>
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
    var workerEdit = new Vue({
        el:'#J_worker_edit',
        delimiters:['<%','%>'],
        data:{
            id:{{worker['id']?worker['id']:0}},
            name:"{{worker['name']?worker['name']:''}}",
            avatar:"{{worker['avatar']?worker['avatar']:''}}",
            mobile:"{{worker['mobile']?worker['mobile']:''}}",
            tel:"{{worker['tel']?worker['tel']:''}}",
            email:"{{worker['email']?worker['email']:''}}",
            sex:"{{worker['sex']?worker['sex']:'male'}}",
            department_id:{{worker['department_id']?worker['department_id']:0}},
            position_id:{{worker['position_id']?worker['position_id']:0}},
            position_list:{{json_encode(position)}}
        },
    });
})();
</script>
<!-- /.content -->
