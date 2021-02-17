<div class="input-group" id="{{id}}" @click.stop.prevent="getList">
    <div class="form-control">
        <%name%>
        {%if mode != 'component'%}
        <input type="hidden" name="id" class="form-control" :v-model="id">
        {%endif%}
    </div>
    <div class="input-group-append">
        <button class="btn btn-default">
            选择部门...
        </button>
    </div>
</div>
