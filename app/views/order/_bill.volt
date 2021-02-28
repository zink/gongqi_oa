<div class="card-body p-0">
    <table class="table table-striped" id="J_order_bill_list">
        <tr>
            <th>#</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>支付状态</th>
            <th>金额</th>
            <th></th>
        </tr>
        <tr v-for="item,key in bills">
            <td>
            <%key+1%>
            </td>
            <td>
                <%item.billing_time|formatTime('yyyy-MM-dd')%>
            </td>
            <td>
                <%item.end_time|formatTime('yyyy-MM-dd')%>
            </td>
            <td>
                <span v-if="item.pay_status == 'unpayed'" class="badge badge-danger">未支付</span>
                <span  v-if="item.pay_status == 'payed'" class="badge badge-success">已支付</span>
            </td>
            <td>
                ￥<%item.total%>
            </td>
            <td>
                <button v-if="item.contract != ''" class="btn btn-default btn-xs" @click.stop.prevent="showContract(item.id)">查看付款凭证</button>
                <button v-else class="btn btn-primary btn-xs" @click.stop.prevent="submitBill(item.id)">确认付款</button>
            </td>
        </tr>
    </table>
</div>
<script type="text/template" id="J_upload_pay">
<div class="modal fade">
    <div class="modal-dialog modal-">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">上传付款凭证</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <div class="col-sm-12">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="upload_pay">
                        <label class="custom-file-label" for="upload_pay">选择文件</label>
                      </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
</script>
<script type="text/template" id="J_show_bill_contract">
<div class="modal fade">
    <div class="modal-dialog modal-">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="image-box" style="width:200px;">
                    <img src="" class="img-thumbnail">
                </div>
            </div>
        </div>
    </div>
</div>
</script>
<script>
(function(){
    new Vue({
        el:'#J_order_bill_list',
        delimiters:['<%','%>'],
        data:{
            bills:{{json_encode(order['bills'])}},
            types:[
                'png',
                'gif',
                'jpg',
                'jpeg'
            ]
        },
        filters:{
            formatTime:Relax.formatTime,
        },
        methods:{
            'showContract':function(id){
                var modal = $($('#J_show_bill_contract').text()).appendTo($('body'));
                modal.modal('show').find('img').prop('src',"{{url('order/bill_attachment/')}}"+id+'?download=1');
            },
            'submitBill':function(id){
                var modal = $($('#J_upload_pay').text()).appendTo($('body'));
                var self = this;
                modal.find('input').fileupload({
                    url:"{{url('order/upload_bill_pay/')}}"+id,
                    add:function(e,data){
                        var fileObj = data.files[0];
                        if(fileObj.size / 1024 / 1024 > 2){
                            return toastr.warning('图片不要大于2M','超过大小');
                        }
                        for(var i = 0;i<self.types.length;i++){
                            var match = new RegExp(self.types[i]);
                            if(fileObj['type'].match(match)){
                                return data.submit();
                            }
                        }
                        return toastr.warning('不是图片');
                    },
                    done:function(e,data){
                        var re = data.result;
                        if(re.status == 'success'){
                            toastr.success(re.msg, '成功');
                            modal.modal('hide');
                            loadPage();
                        }else{
                            toastr.error(re.msg, '异常');
                        }
                    }
                });
                modal.on('hidden.bs.modal',function(){
                    modal.remove();
                }).modal('show');
            }
        }
    });
})();
</script>
