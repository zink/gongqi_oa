<div class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">请选择{{idc.name}}产品</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tr>
                        <th></th>
                        <th>产品名称</th>
                    </tr>
                    {%for item in idc.bandwidthIdc%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="product[]" id="bandwidth_{{item.bandwidth.type}}" value="bandwidth_{{item.bandwidth.type}}" data-price="{{item.bandwidth.price}}" data-type="bandwidth_{{item.bandwidth.type}}">
                            <label for="bandwidth_{{item.bandwidth.type}}"></label>
                        </div>
                        </td>
                        <td>带宽({{item.bandwidth.type}})</td>
                    </tr>
                    {%endfor%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="product[]" id="idc_ampere" value="ampere" data-price="{{idc.ampere_price}}" data-type="ampere">
                            <label for="idc_ampere"></label>
                        </div>
                        </td>
                        <td>加电</td>
                    </tr>
                    {%for ip_type in ip%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="product[]" id="{{ip_type['type']}}" value="{{ip_type['type']}}" data-price="{{idc.ip_price}}" data-type="ip">
                            <label for="{{ip_type['type']}}"></label>
                        </div>
                        </td>
                        <td>{{ip_type['type']}}</td>
                    </tr>
                    {%endfor%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="product[]" id="bridge" value="bridge" data-price="{{idc.bridge_price}}" data-type="bridge">
                            <label for="bridge"></label>
                        </div>
                        </td>
                        <td>桥架</td>
                    </tr>
                    {%for item in idc.IdcCabinet%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="product[]" id="cabinet_{{item.id}}" value="{{item.ampere}}" data-price="{{item.price}}" data-id="{{item.id}}" data-type="cabinet">
                            <label for="cabinet_{{item.id}}"></label>
                        </div>
                        </td>
                        <td>
                        {{item.ampere}}机柜
                        </td>
                    </tr>
                    {% endfor %}
                    {%for item in idc.IdcCabinet%}
                    <tr>
                        <td>
                        <div class="icheck-primary">
                            <input type="checkbox" name="product[]" id="cabinet_seat_{{item.id}}" value="{{item.ampere}}_seat" data-price="{{item.seat_price}}" data-id="{{item.id}}" data-type="seat">
                            <label for="cabinet_seat_{{item.id}}"></label>
                        </div>
                        </td>
                        <td>
                        {{item.ampere}}柜散位
                        </td>
                    </tr>
                    {% endfor %}
                </table>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary submit">确定</button>
            </div>
        </div>
    </div>
</div>
