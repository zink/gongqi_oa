<div id="J_opportunity_basic_form">
    {{ form('opportunity/save','method':'post','class':'form-horizontal',':ref':"'form'") }}
    <div class="card-body">
        <div class="form-group row">
            <input v-if="id" type="hidden" :value="id" name="id"/>
            <label class="col-sm-2 col-form-label">
                公司名称
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <input type="text" name="company" v-model.trim="company" class="form-control" placeholder="请输入公司名称" :class="validationForm.company"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                地址
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
            <address-object :has-address=true v-model=address></address-object>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                联系人
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <table class="table table-bordered">
                    <input type="hidden" v-for="item,index in deleteContactList" name="delete_contact[]" :value="index" :key="index"/>
                    <tr>
                        <th>姓名</th>
                        <th>职务</th>
                        <th>类型</th>
                        <th>电话</th>
                        <th></th>
                    </tr>
                    <tr v-for="item,index in contact" :key="index">
                        <template v-if="!item.id">
                            <input type="hidden" :name="'contact['+index+'][name]'" :value="item.name"/>
                            <input type="hidden" :name="'contact['+index+'][position]'" :value="item.position"/>
                            <input type="hidden" :name="'contact['+index+'][type]'" :value="item.type"/>
                            <input type="hidden" :name="'contact['+index+'][mobile]'" :value="item.mobile"/>
                            <input type="hidden" :name="'contact['+index+'][remark]'" :value="item.remark"/>
                        </template>
                        <td>
                            <%item.name%>
                        </td>
                        <td>
                            <%item.position%>
                        </td>
                        <td>
                            <%item.type|formatType%>
                        </td>
                        <td>
                            <%item.mobile%>
                        </td>
                        <td>
                            <button class="btn btn-danger btn-xs" @click.stop.prevent="deleteContcat(index,item.id)">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" placeholder="必填" v-model.trim="contactForm.name" class="form-control form-control-sm" :class="validationContact.name"/>
                        </td>
                        <td>
                            <input type="text" placeholder="必填" v-model.trim="contactForm.position" class="form-control form-control-sm" :class="validationContact.position"/>
                        </td>
                        <td>
                            <select class="form-control form-control-sm" v-model="contactForm.type">
                                <option value="key">关键人</option>
                                <option value="decision">决策人</option>
                                <option value="contact">联系人</option>
                                <option value="other">其他</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" placeholder="必填" v-model.trim="contactForm.mobile" class="form-control form-control-sm" :class="validationContact.mobile"/>
                        </td>
                        <td>
                            <button class="btn btn-primary btn-xs" @click.stop.prevent="addNewContcat">
                                <i class="fas fa-plus"></i>
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                线索来源
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <select class="form-control" name="origin" v-model="origin" :class="validationForm.origin">
                    <option v-for="item,index in originList" :key="index" :value="item"><%item%></option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                所属区域
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <select class="form-control" name="area" v-model="area" :class="validationForm.area">
                    <option v-for="item,index in areaList" :key="index" :value="index"><%item%></option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                需求意向
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="needs" v-model.trim="needs" :class="validationForm.needs"/>
                <select v-if="false" class="form-control" name="wish" v-model="wish">
                    <option v-for="item,index in wishlist" :key="index" :value="index"><%item%></option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                预计签约时间
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                        <i class="far fa-calendar-alt"></i>
                        </span>
                    </div>
                    <time-input name="signing_time" v-model.trim="signing_time" :class="validationForm.signing_time"></time-input>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                预计合同金额
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fas fa-yen-sign"></i>
                        </span>
                    </div>
                    <input type="text" class="form-control" name="contract_amount" v-model.trim="contract_amount" :class="validationForm.contract_amount">
                    <div class="input-group-append">
                        <span class="input-group-text">
                            元
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                当年预计收款
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fas fa-yen-sign"></i>
                        </span>
                    </div>
                    <input type="text" class="form-control" name="payment_for_year" v-model.trim="payment_for_year" :class="validationForm.payment_for_year">
                    <div class="input-group-append">
                        <span class="input-group-text">
                            元
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                成功率
                <small class="text-red">*</small>
            </label>
            <div class="col-sm-7">
                <select class="form-control" name="success_rate" v-model="success_rate" :class="validationForm.success_rate">
                    <option value="0.0">0%</option>
                    <option value="0.1">10%</option>
                    <option value="0.2">20%</option>
                    <option value="0.3">30%</option>
                    <option value="0.4">40%</option>
                    <option value="0.5">50%</option>
                    <option value="0.6">60%</option>
                    <option value="0.7">70%</option>
                    <option value="0.8">80%</option>
                    <option value="0.9">90%</option>
                    <option value="1">100%</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">责任销售</label>
            <div class="col-sm-7">
                {%if permission('opportunity-assign')%}
                <input type="hidden" :value="worker_id" name="worker_id"/>
                <worker-object v-model="worker_id" :delete-btn="false"></worker-object>
                {%else%}
                <p class="form-control-plaintext">
                    {{_account['name']}}
                </p>
                {%endif%}
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                备注
            </label>
            <div class="col-sm-7">
                <textarea type="text" name="remark" v-model.trim="remark" class="form-control" placeholder="请输入备注200字以内"></textarea>
            </div>
        </div>
        <div class="form-group row" v-if="workerHistory">
            <label class="col-sm-2 col-form-label">
                指派历史
            </label>
            <div class="col-sm-7">
                <table class="table table-bordered">
                    <tr>
                        <th>#</th>
                        <th>员工姓名</th>
                        <th>指派时间</th>
                        <th>状态</th>
                    </tr>
                    <tr v-for="item,index in workerHistory">
                        <td><%item.worker_id%></td>
                        <td><%item.worker_name%></td>
                        <td><%item.create_time|formatTime('yyyy-MM-dd hh:mm:ss')%></td>
                        <td>
                        <span v-if="item.active == 'true'" class="badge badge-success">
                        <span v-if="status == 'active'">
                            跟踪中
                        </span>
                        <span v-if="status == 'dead'">
                            作废
                        </span>
                        <span v-if="status == 'success'">
                            成单
                        </span>
                        </span>
                        <span v-else class="badge badge-danger">
                        已转移
                        </span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <button type="submit" class="btn btn-primary" @click="saveOpportunity">
            保存
        </button>
    </div>
    {{ endform() }}
</div>
<script>
(function(){
    var opportunityEdit = new Vue({
        el:'#J_opportunity_basic_form',
        delimiters:['<%','%>'],
        data:{
            id:{{opportunity['id']?opportunity['id']:0}},
            status:"{{opportunity['track']?opportunity['track']['status']:'active'}}",
            company:"{{opportunity['company']?opportunity['company']:''}}",
            origin:"{{opportunity['origin']?opportunity['origin']:''}}",
            area:"{{opportunity['area']?opportunity['area']:''}}",
            worker_id    :{{opportunity['worker_id']?opportunity['worker_id']:_account['id']}},
            workerHistory:{{opportunity['worker_history']?json_encode(opportunity['worker_history']):'[]'}},
            signing_time       :{{opportunity['signing_time']?opportunity['signing_time']:0}},
            contract_amount       :"{{opportunity['contract_amount']?opportunity['contract_amount']:0}}",
            payment_for_year       :"{{opportunity['payment_for_year']?opportunity['payment_for_year']:0}}",
            success_rate       :{{opportunity['success_rate']?opportunity['success_rate']:'null'}},
            remark       :`{{opportunity['remark']?opportunity['remark']:''}}`,

            /*联系人相关begin*/
            contact      :{{opportunity['contact']?json_encode(opportunity['contact']):'[]'}},
            contactForm:{
                'name':'',
                'position':'',
                'type':'contact',
                'mobile':'',
            },
            openValidation:false,
            contactValidation:false,
            deleteContactList:{},
            /*联系人相关end*/
            address      :{
                province  :"{{opportunity['province']}}",
                city      :"{{opportunity['city']}}",
                district  :"{{opportunity['district']}}",
                address   :"{{opportunity['address']}}"
            },
            needs : "{{opportunity['needs']}}",
            areaList:{
                'east_china':'华东',
                'south_china':'华南',
                'northwest_china':'西北',
                'southwest_china':'西南',
                'north _china':'华北',
                'northeast_china':'东北',
                'central_china':'华中',
                'foreign':'海外'
            },
            originList:[
                '官网',
                '熟人介绍',
                '自主收集',
                '友商推荐'
            ],
            wish:null,
            wishlist:{
                'idc':'idc'
            }
        },
        computed:{
            validationContact:function(){
                var validation = {
                    type:true,
                    name:'',
                    position:'',
                    mobile:''
                }
                if(this.contactValidation){
                    if(!this.contactForm.name){
                        validation.name = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.contactForm.position){
                        validation.position = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.contactForm.mobile){
                        validation.mobile = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                }
                if(this.contactForm.mobile && !/^1[3456789]{1}[0-9]{9}$/.test(this.contactForm.mobile)){
                    validation.mobile = 'is-invalid';
                    if(validation.type){
                        validation.type = false;
                    }
                }
                return validation;
            },
            validationForm:function(){
                var validation = {
                    type:true,
                    company:'',
                    origin:'',
                    area:'',
                    needs:'',
                    signing_time:'',
                    contract_amount:'',
                    payment_for_year:'',
                    success_rate:''
                }
                if(this.openValidation){
                    if(!this.company){
                        validation.company = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.origin){
                        validation.origin = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.area){
                        validation.area = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.needs){
                        validation.needs = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.signing_time){
                        validation.signing_time = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(this.contract_amount == 0){
                        validation.contract_amount = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(this.payment_for_year == 0){
                        validation.payment_for_year = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                    if(!this.success_rate){
                        validation.success_rate = 'is-invalid';
                        if(validation.type){
                            validation.type = false;
                        }
                    }
                }
                return validation;
            }
        },
        filters:{
            formatTime:Relax.formatTime,
            formatType:function(type){
                switch(type){
                    case 'key':
                        return '关键人';
                    break;
                    case 'decision':
                        return '决策人';
                    break;
                    case 'contact':
                        return '联系人';
                    break;
                    case 'other':
                    default :
                        return '其他';
                    break;
                }
            }
        },
        methods:{
            'deleteContcat':function(index,id){
                this.$delete(this.contact,index);
                if(id){
                    this.$set(this.deleteContactList,id,true);
                }
            },
            'addNewContcat':function(){
                this.contactValidation = true;
                if(!this.validationContact.type){
                    return false;
                }
                this.contact.push(this.contactForm);
                this.contactForm = {
                    'name':'',
                    'position':'',
                    'type':'contact',
                    'mobile':''
                };
                this.contactValidation = false;
            },
            'saveOpportunity':function(){
                this.openValidation = true;
                if(!this.validationForm.type){
                    return false;
                }
            }
        }
    });
})();
</script>
