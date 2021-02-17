{{content_header(['title':title])}}
{{content_body()}}
    <div class="card">
        {{ form('rank/save','method':'post','class':'form-horizontal') }}
        <div class="card-body" id="J_position_edit">
            <div class="form-group row">
                <input v-if="id" type="hidden" :value="id" name="id"/>
                <label class="col-sm-2 col-form-label">
                    职级
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="rank" v-model="rank" class="form-control" placeholder="请输入职级名称"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    职等
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="level" v-model="level" class="form-control" placeholder="请输入职级等级"/>
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
        el:'#J_position_edit',
        delimiters:['<%','%>'],
        data:{
            id:{{rank['id']?rank['id']:0}},
            rank:"{{rank['rank']?rank['rank']:''}}",
            level:"{{rank['level']?rank['level']:''}}",
        }
    });
})();
</script>
<!-- /.content -->
