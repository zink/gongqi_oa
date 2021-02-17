<!-- Content Header (Page header) -->
{{content_header(['title':'组织架构'])}}
{{content_body()}}
    <div class="row" id="J_department_list">
        <div class="col-4">
            <div class="card">
                <div class="card-header">
                    <button class="btn btn-primary btn-sm" @click.stop.prevent="doEdit(0)">
                        新增部门
                    </button>
                </div>
                <div class="card-body p-0">
                    <department-tree :department=computedDepartment @delete-item="deleteItem" @edit="doEdit" :top="true"></department-tree>
                </div>
            </div>
        </div>
        <div class="col-8">
            <div class="card card-outline" v-show="edit" :class="id == 0?'card-primary':'card-warning'">
                <div class="card-header" v-if="id == 0">
                新增部门
                </div>
                <div class="card-header" v-else>
                编辑部门
                </div>
                <div class="card-body" id="J_department_edit">
                    <div class="form-group row">
                        <input v-if="id" type="hidden" :value="id" name="id"/>
                        <label class="col-sm-2 col-form-label">部门名称</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" v-model="name" class="form-control" placeholder="请输入部门名称"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">父级部门</label>
                        <div class="col-sm-10">
                            <department-object v-model="parentId"></department-object>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">员工列表</label>

                        <div class="col-sm-10">
                            <worker-object :multiple="1" v-model="workers" @delete-worker="deleteWorker"></worker-object>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary" @click="saveDepartment">
                        保存
                    </button>
                    <button type="submit" class="btn btn-default" @click="cancelNew">
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script type="text/x-template" id="J_department_tree">
<nav class="nav flex-column" :class="top?'tree':'ml-4'">
    <div class="nav-item" v-for="item,index in department" :key="index">
        <div v-if="item['id']" class="nav-link" @click.stop.prevent="doEdit(item['id'])">
            <i class="fas" v-if="item['children']" :class="open?'fa-minus-circle':'fa-plus-circle'" @click.stop.prevent="open = !open"></i>
            <%item['name']%>
            <div class="float-right">
                <span class="badge badge-danger" @click.stop.prevent="deleteItem(item)">
                    <i class="fas fa-trash-alt"></i>
                </span>
            </div>
        </div>
        <department-tree :department="item['children']"  v-show="open" @edit="doEdit" @delete-item="deleteItem"></department-tree>
    </div>
</nav>
</script>
<script>
(function(){
    Vue.component('department-tree',{
        props:['department','top'],
        data(){
            return {
                open:false
            }
        },
        delimiters:['<%','%>'],
        template:'#J_department_tree',
        methods:{
            deleteItem:function(item){
                this.$emit('delete-item',item);
            },
            doEdit:function(id){
                this.$emit('edit',id);
            }
        }
    });
    var departmentList = new Vue({
        el:'#J_department_list',
        delimiters:['<%','%>'],
        data:{
            department:[],
            id:0,
            name:'',
            parentId:0,
            workers:[],
            deleteWorkers:[],
            edit:false
        },
        computed:{
            computedDepartment:function(){
                let data = this.department
                let result = []
                if(!Array.isArray(data)) {
                    return result
                }
                data.forEach(item => {
                    delete item.children;
                });
                let map = {};
                data.forEach(item => {
                    map[item.id] = item;
                });
                data.forEach(item => {
                    let parent = map[item.parent_id];
                    if(parent) {
                        (parent.children || (parent.children = [])).push(item);
                    } else {
                        result.push(item);
                    }
                });
                return result;
            }
        },
        mounted:function(){
            this.getList();
        },
        watch:{
            workers:function(newValue){
                var self = this;
                newValue.forEach(function(v){
                    if(self.deleteWorkers.indexOf(v) === -1){
                        self.$delete(self.deleteWorkers,self.deleteWorkers.indexOf(v));
                    }
                });
            }
        },
        methods:{
            'deleteWorker':function(id){
                if(this.deleteWorkers.indexOf(id) === -1){
                    this.deleteWorkers.push(id);
                }
            },
            'getList':function(){
                var self = this;
                $.ajax({
                    url:"{{url('department/get_list')}}",
                    success:function(re){
                        self.department = re;
                    }
                });
            },
            'doEdit':function(id){
                if(id == 0){
                    this.id = 0;
                    this.name = '';
                    this.parentId = 0;
                    this.workers = [];
                    this.deleteWorkers = [];
                    this.edit = true;
                }else{
                    var self = this;
                    $.ajax({
                        'url':"{{url('department/get_detail/')}}"+id,
                        'success':function(re){
                            if(re.status == 'success'){
                                self.id = re.data.id;
                                self.name = re.data.name;
                                self.parentId = re.data.parent_id;
                                var workerId = [];
                                if(re.data.items.length > 0){
                                    for(var i = 0;i<re.data.items.length;i++){
                                        workerId.push(re.data.items[i].id);
                                    }
                                }
                                self.workers = workerId;
                                self.deleteWorkers = [];
                                self.edit = true;
                            }else{
                                self.edit = false;
                            }
                        }
                    });
                }
            },
            'cancelNew':function(){
                this.edit = false;
            },
            'saveDepartment':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('department/save')}}",
                    'type':'POST',
                    'data':{
                        id:self.id,
                        name:self.name,
                        parent_id:self.parentId,
                        workers:self.workers,
                        delete_workers:self.deleteWorkers,
                    },
                    'success':function(re){
                        if(re.status == 'success'){
                            toastr.success(re.msg, '成功');
                            self.getList();
                        }else{
                            toastr.error(re.msg, '错误');
                        }
                    }
                });
            },
            'deleteItem':function(item){
                var self = this;
                $.ajax({
                    'url':"{{url('department/delete/')}}"+item['id'],
                    'success':function(re){
                        if(re.status){
                            toastr.success(re.msg, '成功');
                            self.getList();
                        }else{
                            toastr.error(re.msg, '错误');
                        }
                    }
                });
            }
        }
    });
})();
</script>
