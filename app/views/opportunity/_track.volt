<div id="J_opportunity_track_form">
    <div class="card-body">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">往期跟踪情况</label>
            <div class="col-sm-7">
                <div class="card">
                    <div class="card-header">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                  <i class="far fa-calendar-alt"></i>
                                </span>
                            </div>
                            <date-range-input @apply="getTrack"></date-range-input>
                        </div>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>
                                    状态
                                </th>
                                <th>
                                    填报人
                                </th>
                                <th>
                                    日期
                                </th>
                                <th>
                                </th>
                            </tr>
                            <tr v-if="tracks.length == 0">
                                <td colspan="3">
                                    <div class="alert alert-warning">
                                    暂无
                                    </div>
                                </td>
                            </tr>
                            <tr v-else v-for="track,index in tracks" :key="track.id">
                                <td>
                                    <span  v-if="track.status == 'success'"class="badge badge-success">
                                        成功
                                    </span>
                                    <span v-else-if="track.status == 'dead'" class="badge badge-danger">
                                        作废
                                    </span>
                                    <span v-else class="badge badge-warning">
                                        跟单中
                                    </span>
                                </td>
                                <td>
                                    <%track.worker_name%>
                                </td>
                                <td>
                                    <%track.create_time|formatTime('yyyy-MM-dd')%>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-primary" @click="showTrackDetail(index)">
                                        查看详情
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        {%if opportunity['worker_id'] == _account['id']%}
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">今日跟踪情况</label>
            <div class="col-sm-7">
                <div class="icheck-primary d-inline">
                    <input type="radio" id="status_active" name="status" v-model="status" value="active">
                    <label for="status_active">跟单中</label>
                </div>
                <div class="icheck-primary d-inline">
                    <input type="radio" id="status_dead" name="status" v-model="status" value="dead" checked="">
                    <label for="status_dead">作废</label>
                </div>
                <div class="icheck-primary d-inline">
                    <input type="radio" id="status_success" name="status" v-model="status" value="success" checked="">
                    <label for="status_success">成单</label>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"></label>
            <div class="col-sm-7">
                <textarea name="track_info" placeholder="跟踪详情" class="form-control" v-model.trim="track_info"></textarea>
            </div>
        </div>
        {%endif%}
    </div>
    {%if opportunity['worker_id'] == _account['id']%}
    <div class="card-footer">
        <button type="button" class="btn btn-primary" @click.stop.prevent="saveTodayTrack">
            保存
        </button>
    </div>
    {%endif%}
    <div class="modal fade" ref="modal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%track_detail%>
                <div>
            </div>
        </div>
    </div>
</div>
<script>
(function(){
    var opportunityTrack = new Vue({
        el:'#J_opportunity_track_form',
        delimiters:['<%','%>'],
        data:{
            tracks:[],
            status:"{{opportunity['track']?opportunity['track']['status']:'active'}}",
            track_info:"{{trim(opportunity['track']?opportunity['track']['track_info']:'')}}",
            track_detail:'',
            track_id:{{opportunity['track']?opportunity['track']['id']:0}}
        },
        mounted:function(){
            this.getTrack({
                start:Relax.DateUtil.getStartDayOfWeek(),
                end:Relax.DateUtil.getEndDayOfWeek()
            });
        },
        filters:{
            formatTime:Relax.formatTime,
        },
        methods:{
            getTrack:function(range){
                var self = this;
                $.ajax({
                    url:"{{url('opportunity/get_track/' ~ opportunity['id'])}}",
                    type:'POST',
                    data:range,
                    success:function(re){
                        self.tracks = re;
                    }
                });
            },
            {%if opportunity['worker_id'] == _account['id']%}
            saveTodayTrack:function(){
                var self = this;
                $.ajax({
                    url:"{{url('opportunity/save_today_track/' ~ opportunity['id'])}}",
                    type:'POST',
                    data:{
                        status:self.status,
                        track_info:self.track_info,
                        track_id:self.track_id
                    },
                    success:function(re){
                        if(re.status){
                            toastr.success(re.msg, '成功');
                            self.track_id = re.data;
                            self.getTrack({
                                start:Relax.DateUtil.getStartDayOfWeek(),
                                end:Relax.DateUtil.getEndDayOfWeek()
                            });
                        }else{
                            toastr.error(re.msg, '错误');
                        }
                    }
                });
            },
            {%endif%}
            showTrackDetail:function(index){
                this.track_detail = this.tracks[index].track_info;
                var modal = $(this.$refs.modal).modal('show');
            }
        }
    });
})();
</script>
