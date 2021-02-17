<div class="card" id="{{id}}">
    <div class="card-header">
        <button class="btn btn-default btn-sm" @click.stop.prevent="getList">
            选择员工
        </button>
    </div>
    <div class="card-body p-0">
        <table class="table table-striped">
            <tr>
                <th>#</th>
                <th>姓名</th>
                <th>职务</th>
                <th>手机</th>
                <th>邮箱</th>
                <th v-if="deleteBtn"></th>
            </tr>
            <tr v-for="worker,index in workers" :key="index">
                <td>
                <%worker.id%>
                </td>
                <td>
                <%worker.name%>
                </td>
                <td>
                <%worker.position%>
                </td>
                <td>
                <%worker.mobile%>
                </td>
                <td>
                <%worker.email?worker.email:'-'%>
                </td>
                <td v-if="deleteBtn">
                    <button class="btn btn-danger btn-xs" @click.stop.prevent="deleteWorker(worker.id)">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>
            </tr>
        </table>
    </div>
</div>
