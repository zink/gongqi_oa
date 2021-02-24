<div class="card-body p-0">
    <table class="table table-striped">
        <tr>
            <th>#</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>支付状态</th>
            <th>金额</th>
        </tr>
        {%for index,item in order['bills']%}
        <tr>
            <td>
            {{index+1}}
            </td>
            <td>
                {{date('Y-m-d',item['billing_time'])}}
            </td>
            <td>
                {{date('Y-m-d',item['end_time'])}}
            </td>
            <td>
                {%switch item['pay_status']%}
                {%case 'unpayed'%}
                <span class="badge badge-danger">未支付</span>
                {%break%}
                {%case 'payed'%}
                <span class="badge badge-success">已支付</span>
                {%break%}
                {%endswitch%}
            </td>
            <td>
                ￥{{item['total']}}
            </td>
        </tr>
        {% endfor %}
    </table>
</div>
