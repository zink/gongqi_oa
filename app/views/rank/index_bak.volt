<!-- Content Header (Page header) -->
{{content_header(['title':'职级职等'])}}
{{content_body()}}
    <div class="row">
        <div class="col-12">
            <div class="card" id="J_rank_list">
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr class="text-center">
                            <th>职级</th>
                            <th>职等</th>
                            <th>
                                <div class="input-group input-group-sm">
                                    <input type="text" class="form-control" placeholder="添加职位类型" v-model="newtype">
                                    <span class="input-group-append">
                                        <button type="button" class="btn btn-primary btn-flat" @click="saveNewType">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </span>
                                </div>
                            </th>
                        </tr>
                        <template v-for="item,index in rank">
                            <tr>
                                <td :rowspan="item.length+1" >
                                <%index%>
                                </td>
                            </tr>
                            <tr v-for="level in item">
                                <td>
                                    <%level.level%>
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
            newType:''
        },
        methods:{
            deleteRank:function(id){
                $.ajax({
                    'url':"{{url('rank/delete/')}}"+id,
                    'success':function(re){
                    }
                });
            }
        }
    });
})();
</script>
