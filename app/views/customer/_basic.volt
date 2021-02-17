{{ form('customer/save','method':'post','class':'form-horizontal') }}
<div class="card-body">
    <div class="form-group row">
        <input v-if="customer.id" type="hidden" :value="customer.id" name="id"/>
        <label class="col-sm-2 col-form-label">
            客户主体
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <input type="text" name="subject" v-model.trim="customer.subject" class="form-control" placeholder="请输入客户签约主体"/>
        </div>
    </div>
    <div class="form-group row" v-if="customer.id">
        <label class="col-sm-2 col-form-label">认证状态</label>
        <div class="col-sm-6">
            <p class="form-control-plaintext">
                <span class="badge badge-success" v-if="customer.certification == 'true'">已认证</span>
                <span class="badge badge-danger" v-else >未认证</span>
                {%if permission('customer-cert')%}
                <button class="btn btn-warning btn-xs" v-if="customer.certification != 'true'" @click.stop.prevent="cert">通过认证</button>
                {%endif%}
            </p>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            地址
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
        <address-object :has-address=true v-model="address" ></address-object>
        </div>
    </div>
    <template v-if="customer['id']">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            营业执照（不大于2M）
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-6">
            <upload-object 
                url="{{url('customer/upload/license/'~customer['id'])}}"
                image="{{attachment.license?url('customer/attachment?download='~attachment.license):'about:blank'}}"
            ></upload-object>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            法人身份证（不大于2M）
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-3">
            <upload-object 
                url="{{url('customer/upload/legal_person_front/'~customer['id'])}}" 
                image="{{attachment.legal_person_front?url('customer/attachment?download='~attachment.legal_person_front):'about:blank'}}"
                title="身份证正面"
            ></upload-object>
        </div>
        <div class="col-sm-3">
            <upload-object
                url="{{url('customer/upload/legal_person_back/'~customer['id'])}}"
                image="{{attachment.legal_person_back?url('customer/attachment?download='~attachment.legal_person_back):'about:blank'}}"
                title="身份证反面"
            ></upload-object>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">
            责任人身份证（不大于2M）
            <small class="text-red">*</small>
        </label>
        <div class="col-sm-3">
            <upload-object 
                url="{{url('customer/upload/contacts_front/'~customer['id'])}}" 
                image="{{attachment.contacts_front?url('customer/attachment?download='~attachment.contacts_front):'about:blank'}}"
                title="身份证正面"
            ></upload-object>
        </div>
        <div class="col-sm-3">
            <upload-object 
                url="{{url('customer/upload/contacts_back/'~customer['id'])}}" 
                image="{{attachment.contacts_back?url('customer/attachment?download='~attachment.contacts_back):'about:blank'}}"
                title="身份证反面"
            ></upload-object>
        </div>
    </div>
    </template>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">责任销售</label>
        <div class="col-sm-6">
            {%if permission('customer-assign')%}
            <input type="hidden" :value="customer.worker_id" name="worker_id"/>
            <worker-object v-model="customer.worker_id" :delete-btn="false"></worker-object>
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
        <div class="col-sm-6">
            <textarea type="text" name="remark" v-model.trim="customer.remark" class="form-control" placeholder="请输入备注200字以内"></textarea>
        </div>
    </div>
    <!-- /.content -->
</div>
<div class="card-footer">
    <button type="submit" class="btn btn-primary">
        保存
    </button>
</div>
{{ endform() }}
