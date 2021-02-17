<div class="department-modal">
    <div class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">请选择部门</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="J_department_{{id}}">
                    <nav class="nav flex-column tree">
                        <div class="nav-item">
                            <div class="nav-link">
                                <div class="icheck-primary d-inline">
                                    <input type="radio" id="dpo_0" name="dpo_{{id}}" value="0">
                                    <label for="dpo_0">顶级</label>
                                </div>
                            </div>
                        </div>
                    </nav>
                    <tree-{{id}} :department=computedDepartment :top="true"></tree-{{id}}>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary submit">确定</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <script>
    (function(){
        Vue.component('tree-{{id}}',{
            props:['department','top'],
            data(){
                return {
                    open:false
                }
            },
            delimiters:['<%','%>'],
            template:`
            <nav class="nav flex-column" :class="top?'tree':'ml-4'">
                <div class="nav-item" v-for="item,index in department" :key="index">
                    <div v-if="item['id']" class="nav-link">
                        <i class="fas" v-if="item['children']" :class="open?'fa-minus-circle':'fa-plus-circle'" @click.stop.prevent="open = !open"></i>
                        <div class="icheck-primary d-inline">
                            <input type="radio" :id="'dpo_'+item['id']" name="dpo_{{id}}" :value="item['id']">
                            <label :for="'dpo_'+item['id']"><%item['name']%></label>
                        </div>
                    </div>
                    <tree-{{id}} :department="item['children']"  v-show="open"></tree-{{id}}>
                </div>
            </nav>
            `
        });
        var departmentList = new Vue({
            el:'#J_department_{{id}}',
            delimiters:['<%','%>'],
            data:{
                department:[],
            },
            components:{
                'department-object':{{department_object(['mode':'component'])}}
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
                var self = this;
                $.ajax({
                    url:"{{url('department/get_list')}}",
                    success:function(re){
                        self.department = re;
                    }
                });
            }
        });
    })();
    </script>
</div>
