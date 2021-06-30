{{content_header(['title':title])}}
{{content_body()}}
    <div class="card">
        <div class="card-body">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    整柜
                </label>
                <div class="col-sm-10">
                    <table class="table table-striped table-sm">
                        <tr>
                            <th>编号</th>
                            <th>IDC</th>
                            <th>类型</th>
                            <th>上架时间</th>
                        </tr>
                        {%for item in cabinet%}
                        <tr>
                            <td>
                            {{item.name}}
                            </td>
                            <td>
                            {{item.idc.name}}
                            </td>
                            <td>
                            {{product_type(item.ampere)}}
                            </td>
                            <td>
                            {{date('Y-m-d H:i:s',item.update_time)}}
                            </td>
                        </tr>
                        {%endfor%}
                    </table>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    IP
                </label>
                <div class="col-sm-10">
                    <table class="table table-striped table-sm">
                        <tr>
                            <th>IP</th>
                            <th>类型</th>
                            <th>上架时间</th>
                        </tr>
                        {%for item in ip%}
                        <tr>
                            <td>
                            {{item.ip}}
                            </td>
                            <td>
                            {{product_type(item.type)}}
                            </td>
                            <td>
                            {{date('Y-m-d H:i:s',item.update_time)}}
                            </td>
                        </tr>
                        {%endfor%}
                    </table>
                </div>
            </div>
        </div>
    </div>
{{end_content_body()}}
<!-- /.content -->
