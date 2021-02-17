{{content_header(['title':title])}}
{{content_body()}}
    <div class="card">
        {{ form('idc/save','method':'post','class':'form-horizontal') }}
        <div class="card-body" id="J_idc_edit">
            <div class="form-group row">
                <input v-if="id" type="hidden" :value="id" name="id"/>
                <label class="col-sm-2 col-form-label">
                    机房名称
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <input type="text" name="name" v-model.trim="name" class="form-control" placeholder="请输入机房名称"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    地址
                    <small class="text-red">*</small>
                </label>
                <div class="col-sm-6">
                    <address-object :has-address=true v-model=address></address-object>
                </div>
            </div>
            <div class="form-group row" v-if="id">
                <label class="col-sm-2 col-form-label">
                    桥架
                </label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">一芯月采购价</span>
                        </div>
                        <input type="number" name="bridge_purchase_price" v-model.trim="bridge_purchase_price" class="form-control"/>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">一芯月销售价</span>
                        </div>
                        <input type="number" name="bridge_price" v-model.trim="bridge_price" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="form-group row" v-if="id">
                <label class="col-sm-2 col-form-label">
                    电力
                </label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">一安培月采购价</span>
                        </div>
                        <input type="number" name="ampere_purchase_price" v-model.trim="ampere_purchase_price" class="form-control"/>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">一安培月销售价</span>
                        </div>
                        <input type="number" name="ampere_price" v-model.trim="ampere_price" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="form-group row" v-if="id">
                <label class="col-sm-2 col-form-label">
                    IP
                </label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">IP月采购价</span>
                        </div>
                        <input type="number" name="ip_purchase_price" v-model.trim="ip_purchase_price" class="form-control"/>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">IP月销售价</span>
                        </div>
                        <input type="number" name="ip_price" v-model.trim="ip_price" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="form-group row" v-if="id">
                <label class="col-sm-2 col-form-label">
                    IPv6
                </label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">IPv6月采购价</span>
                        </div>
                        <input type="number" name="ipv6_purchase_price" v-model.trim="ipv6_purchase_price" class="form-control"/>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">IPv6月销售价</span>
                        </div>
                        <input type="number" name="ipv6_price" v-model.trim="ipv6_price" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="form-group row" v-if="id">
                <label class="col-sm-2 col-form-label">
                    机柜
                </label>
                <div class="col-sm-10">
                    <div class="card">
                        <div class="card-body p-0">
                            <table class="table table-striped">
                                <tr>
                                    <th>#</th>
                                    <th>机柜类型</th>
                                    <th>机位电量</th>
                                    <th>库存</th>
                                    <th>整柜进价/月</th>
                                    <th>整柜售价/月</th>
                                    <th>1U位售价/月</th>
                                    <th>操作</th>
                                </tr>
                                <template v-for="cabinet,index in cabinets" :key="index">
                                <tr v-if="editCabinetId == cabinet.id">
                                    <td><%cabinet.id%></td>
                                    <td>
                                        <select class="form-control form-control-sm" v-model="cabinet.seat_num">
                                            <option value="42">42U</option>
                                            <option value="45">45U</option>
                                            <option value="48">48U</option>
                                        </select>
                                    </td>
                                    <td>
                                        <select class="form-control form-control-sm" v-model="cabinet.ampere">
                                            <option value="10A">10A</option>
                                            <option value="16A">16A</option>
                                            <option value="20A">20A</option>
                                            <option value="25A">25A</option>
                                            <option value="32A">32A</option>
                                            <option value="45A">45A</option>
                                            <option value="64A">64A</option>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="cabinet.stock" class="form-control form-control-sm" placeholder="库存"/>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="cabinet.purchase_price" class="form-control form-control-sm" placeholder="采购价/月"/>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="cabinet.price" class="form-control form-control-sm" placeholder="整柜销售价/月"/>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="cabinet.seat_price" class="form-control form-control-sm" placeholder="机位销售价/月"/>
                                    </td>
                                    <td>
                                        <button class="btn btn-xs btn-primary" @click.stop.prevent="saveCabinet(index)">
                                            更新
                                        </button>
                                        <button class="btn btn-xs btn-default" @click.stop.prevent="cancelEditCabinet()">
                                            取消编辑
                                        </button>
                                    </td>
                                </tr>
                                <tr v-else >
                                    <td><%cabinet.id%></td>
                                    <td><%cabinet.seat_num%>U</td>
                                    <td><%cabinet.ampere%></td>
                                    <td><%cabinet.stock%></td>
                                    <td>￥<%cabinet.purchase_price%></td>
                                    <td>￥<%cabinet.price%></td>
                                    <td>￥<%cabinet.seat_price%></td>
                                    <td>
                                        <button class="btn btn-xs btn-primary" @click.stop.prevent="editCabinet(index)">
                                            编辑
                                        </button>
                                        <button class="btn btn-xs btn-danger" @click.stop.prevent="deleteItem(index)">
                                            删除
                                        </button>
                                    </td>
                                </tr>
                                </template>
                                <tr v-if="newCabinetBox">
                                    <td></td>
                                    <td>
                                        <select class="form-control" v-model="newCabinet.seat_num">
                                            <option value="42">42U</option>
                                            <option value="45">45U</option>
                                            <option value="48">48U</option>
                                        </select>
                                    </td>
                                    <td>
                                        <select class="form-control" v-model="newCabinet.ampere">
                                            <option value="10A">10A</option>
                                            <option value="16A">16A</option>
                                            <option value="20A">20A</option>
                                            <option value="25A">25A</option>
                                            <option value="32A">32A</option>
                                            <option value="45A">45A</option>
                                            <option value="64A">64A</option>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="newCabinet.stock" class="form-control" placeholder="库存"/>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="newCabinet.purchase_price" class="form-control" placeholder="采购价/月"/>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="newCabinet.price" class="form-control" placeholder="整柜销售价/月"/>
                                    </td>
                                    <td>
                                        <input type="number" v-model.trim="newCabinet.seat_price" class="form-control" placeholder="机位销售价/月"/>
                                    </td>
                                    <td>
                                        <button class="btn btn-xs btn-primary" @click.stop.prevent="saveCabinet()">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="card-footer">
                            <button v-if="!newCabinetBox" class="btn btn-secondary btn-sm" @click.stop.prevent="newCabinetBox = true">
                                添加IDC产品
                            </button>
                            <button v-else class="btn btn-default btn-sm" @click.stop.prevent="newCabinetBox = false">
                                取消
                            </button>
                        </div>
                    </div>
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
        el:'#J_idc_edit',
        delimiters:['<%','%>'],
        data:{
            id:{{idc['id']?idc['id']:0}},
            name:"{{idc['name']?idc['name']:''}}",
            address      :{
                province  :"{{idc['province']}}",
                city      :"{{idc['city']}}",
                district  :"{{idc['district']}}",
                address   :"{{idc['address']}}"
            },
            bridge_price:{{idc['bridge_price']?idc['bridge_price']:0}},
            bridge_purchase_price:{{idc['bridge_purchase_price']?idc['bridge_purchase_price']:0}},
            ampere_price:{{idc['ampere_price']?idc['ampere_price']:0}},
            ampere_purchase_price:{{idc['ampere_purchase_price']?idc['ampere_purchase_price']:0}},
            ip_price:{{idc['ip_price']?idc['ip_price']:0}},
            ip_purchase_price:{{idc['ip_purchase_price']?idc['ip_purchase_price']:0}},
            ipv6_price:{{idc['ipv6_price']?idc['ipv6_price']:0}},
            ipv6_purchase_price:{{idc['ipv6_purchase_price']?idc['ipv6_purchase_price']:0}},
            editCabinetId:0,
            newCabinet:{
                ampere:'',
                seat_num:42,
                purchase_price:0,
                price:0,
                seat_price:0,
                stock:1,
            },
            cabinets:{{json_encode(idc['cabinet'])}},
            newCabinetBox:false,
        },
        methods:{
            'saveCabinet':function(index){
                var self = this;
                if(index != null){
                    var data = self.cabinets[index];
                }else{
                    var data = self.newCabinet;
                }
                $.ajax({
                    'url':"{{url('idc/save_cabinet/')}}"+self.id,
                    'type':'post',
                    'data':data,
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage();
                        }
                    }
                });
            },
            'editCabinet':function(index){
                this.editCabinetId = this.cabinets[index].id;
            },
            'cancelEditCabinet':function(index){
                this.editCabinetId = 0;
            },
            'deleteItem':function(index){
                var self = this;
                bootbox.confirm({
                    'message':'确认要删除该机柜吗?',
                    'buttons':{
                        confirm: {
                            label: '确定',
                        },
                        cancel: {
                            label: '取消',
                        }
                    },
                    'size':'small',
                    'callback':function(result){
                        if(result){
                            $.ajax({
                                url:"{{url('idc/delete_cabinet/')}}"+self.cabinets[index].id,
                                success:function(re){
                                    if(re.status == 'success'){
                                        toastr.success(re.msg, '成功');
                                        loadPage();
                                    }else{
                                        toastr.error(re.msg, '异常');
                                    }
                                }
                            });
                        }
                    }
                });
            },
        }
    });
})();
</script>
<!-- /.content -->
