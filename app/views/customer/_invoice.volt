{{ form('customer/save_invoice','method':'post','class':'form-horizontal') }}
<div class="card-body">
    <input v-if="customer.id" type="hidden" :value="customer.id" name="customer_id"/>
    <input v-if="invoice.id" type="hidden" :value="invoice.id" name="id"/>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            抬头
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <div class="input-group">
                <input type="text" name="title" v-model.trim="invoice.title" class="form-control" placeholder="开票抬头"/>
                <span class="input-group-append">
                    <button class="btn btn-default" @click.stop.prevent="copyTitle">
                        复制客户主体
                    </button>
                </span>
            </div>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            税号
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <input type="text" name="tax_number" v-model.trim="invoice.tax_number" class="form-control" placeholder="税号"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            开户行
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <input type="text" name="bank" v-model.trim="invoice.bank" class="form-control" placeholder="开户行"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            开户行账号
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <input type="text" name="bank_account" v-model.trim="invoice.bank_account" class="form-control" placeholder="开户行账号"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            企业地址
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <button class="btn btn-default" @click.stop.prevent="copyAddress">
            复制基本信息地址
            </button>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
        </label>
        <div class="col-sm-6">
            <address-object :has-address=true v-model=invoice_address ></address-object>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            手机
        </label>
        <div class="col-sm-6">
        <input type="text" class="form-control" name="mobile" v-model="invoice.mobile"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            固定电话
        </label>
        <div class="col-sm-6">
        <tel-object name="tel" v-model="invoice.tel"></tel-object>
        </div>
    </div>
</div>
<div class="card-footer">
    <button type="submit" class="btn btn-primary">
        保存
    </button>
</div>
{{ endform() }}
