<!-- Content Header (Page header) -->
{{content_header(['title':'职级职等'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card" id="J_rank_list">
                <div class="card-header">
                    {{link_to('rank/edit','新增职级职等','class':'btn btn-primary btn-sm')}}
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-sm">
                        
                        <thead>
                            <tr class="text-center">
                                <th rowspan="2">职级</th>
                                <th rowspan="2">职等</th>
                                <th :colspan="computedTypeLength">职位</th>
                                <th rowspan="2">
                                操作
                                </th>
                            </tr>
                            <tr class="text-center">
                                <th v-for="type,index in positionType">
                                    <div v-if="typeEditFlag == index + 1" class="input-group input-group-sm">
                                        <input type="text" class="form-control" v-model="type.name">
                                        <span class="input-group-append">
                                            <button type="button" @click.stop.prevent="typeEditFlag = 0" class="btn btn-default btn-flat">
                                                <i class="fas fa-times"></i>
                                            </button>
                                            <button type="button" @click.stop.prevent="saveType(index)" class="btn btn-primary btn-flat">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <span v-else @click.stop.prevent="typeEditFlag = index + 1">
                                        <%type.name%>
                                        <i class="fas fa-edit"></i>
                                    </span>
                                </th>
                                <th>
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control" placeholder="新建职位类型" v-model="newType">
                                        <span class="input-group-append">
                                            <button type="button" @click.stop.prevent="saveType(false)" class="btn btn-primary btn-flat">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </span>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <template v-for="item,index in rank" :key="index">
                            <tr>
                                <td class="text-center" :rowspan="item.length+1" style="vertical-align:middle">
                                <%index%>
                                </td>
                            </tr>
                            <tr v-for="level,l_index in item" :key="l_index">
                                <td class="text-center" style="vertical-align:middle">
                                <%level.level%>
                                </td>
                                <td v-for="type,t_index in positionType" :key="t_index">
                                    <draggable group="position" :list="positionList[level.id+':'+type.id]" class="list-group list-group-flush">
                                        <a href="javascript:;" v-for="position,p_index in positionList[level.id+':'+type.id]" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" :key="p_index">
                                            <i class="fas fa-bars"></i>
                                            <%level.rank%><%level.level%><%position.name%>
                                            <span class="badge badge-pill" @click="deletePosition(position.id)">
                                                <i class="fas fa-times"></i>
                                            </span>
                                        </a>
                                    </draggable>
                                    <div class="list-group list-group-flush">
                                        <div class="list-group-item">
                                            <div v-if="newPositionFlag == level.id + ':' + type.id" class="input-group input-group-sm">
                                                <input type="text" class="form-control" v-model="newPosition"/>
                                                <span class="input-group-append">
                                                    <button type="button" class="btn btn-default btn-flat" @click="newPositionFlag = '';newPosition=''">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-primary btn-flat" @click="saveNewPosition(level.id,type.id)">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </span>
                                            </div>
                                            <button type="button" v-else class="btn btn-sm btn-block btn-default" @click.stop.prevent="newPositionFlag = level.id + ':' + type.id">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </td>
                                <td></td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-xs" @click.stop.prevent="deleteRank(level.id)">
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </template>
                    </table>
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    var rankList = new Vue({
        el:'#J_rank_list',
        delimiters:['<%','%>'],
        data:{
            rank:{{rank}},
            positionType:{{position_type?position_type:'[]'}},
            newType:'',
            typeEditFlag:0,
            newPositionFlag:'',
            positionList:{{position}},
            newPosition:''
        },
        computed:{
            'computedTypeLength':function(){
                return this.positionType.length+1;
            }
        },
        methods:{
            'deletePosition':function(id){
                bootbox.confirm({
                    'message':'确定要删除该职位吗？',
                    'buttons':{
                        confirm: {
                            label: '确定',
                        },
                        cancel: {
                            label: '取消',
                        }
                    },
                    'size':'small',
                    'callback':function(result){
                        if(result){
                            $.ajax({
                                url:"{{url('rank/delete_position/')}}"+id,
                                success:function(re){
                                    if(re.status == 'error'){
                                        toastr.error(re.msg, '异常');
                                    }else{
                                        toastr.success(re.msg, '成功');
                                        loadPage();
                                    }
                                }
                            })
                        }
                    }
                });
            },
            'saveNewPosition':function(rankId,typeId){
                if(this.newPosition != ''){
                    var self = this;
                    $.ajax({
                        url:"{{url('rank/save_position')}}",
                        type:'POST',
                        data:{
                            name:self.newPosition,
                            rank_id:rankId,
                            type_id:typeId
                        },
                        success:function(re){
                            if(re.status == 'error'){
                                toastr.error(re.msg, '异常');
                            }else{
                                toastr.success(re.msg, '成功');
                                if(!self.positionList[rankId+':'+typeId]){
                                    self.$set(self.positionList,rankId+':'+typeId,[]);
                                }
                                self.positionList[rankId+':'+typeId].push({
                                    'id':re.data,
                                    'name':self.newPosition,
                                    'position_rank_id':rankId,
                                    'position_type_id':typeId
                                });
                                self.newPosition = 0;
                            }
                        }
                    });
                }
            },
            'saveType':function(index){
                if(index != false){
                    var self = this;
                    $.ajax({
                        'url':"{{url('rank/save_type')}}",
                        'type':'POST',
                        'data':self.positionType[index],
                        'success':function(re){
                            if(re.status == 'error'){
                                toastr.error(re.msg, '异常');
                            }else{
                                toastr.success(re.msg, '成功');
                                self.typeEditFlag = 0;
                            }
                        }
                    });
                }else if(this.newType != ''){
                    var self = this;
                    $.ajax({
                        'url':"{{url('rank/save_type')}}",
                        'type':'POST',
                        'data':{
                            'name':self.newType
                        },
                        'success':function(re){
                            if(re.status == 'error'){
                                toastr.error(re.msg, '异常');
                            }else{
                                toastr.success(re.msg, '成功');
                                self.positionType.push({
                                    'id':re.data,
                                    'name':self.newType
                                });
                                self.newType = '';
                            }
                        }
                    });
                }
            },
            'deleteRank':function(id){
                bootbox.confirm({
                    'message':'确定要删除该职级职等吗？',
                    'buttons':{
                        confirm: {
                            label: '确定',
                        },
                        cancel: {
                            label: '取消',
                        }
                    },
                    'size':'small',
                    'callback':function(result){
                        if(result){
                            $.ajax({
                                url:"{{url('rank/delete/')}}"+id,
                                success:function(re){
                                    if(re.status == 'error'){
                                        toastr.error(re.msg, '异常');
                                    }else{
                                        toastr.success(re.msg, '成功');
                                        loadPage();
                                    }
                                }
                            })
                        }
                    }
                });
            }
        }
    });
})();
</script>
