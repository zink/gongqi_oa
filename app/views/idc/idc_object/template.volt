<div class="card" id="{{id}}">
    <div class="card-header">
        <button class="btn btn-default btn-sm" @click.stop.prevent="getList">
            选择IDC
        </button>
    </div>
    <div class="card-body p-0">
        <table class="table table-striped">
            <tr>
                <th>#</th>
                <th>名称</th>
                <th>地址</th>
                <th v-if="deleteBtn"></th>
            </tr>
            <tr v-for="item,index in idc" :key="index">
                <td>
                <%item.id%>
                </td>
                <td>
                <%item.name%>
                </td>
                <td>
                <%item['province']%>
                <%item['city']%>
                <%item['district']%>
                <hr />
                <%item['address']%>
                </td>
                <td v-if="deleteBtn">
                    <button class="btn btn-danger btn-xs" @click.stop.prevent="deleteIdc(idc.id)">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>
            </tr>
        </table>
    </div>
</div>
