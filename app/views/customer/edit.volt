{{content_header(['title':title])}}
{{content_body()}}
    <div class="card card-primary card-outline card-outline-tabs">
        <div class="card-header p-0 border-bottom-0">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="pill" href="#J_customer_basic" role="tab" aria-controls="J_customer_basic" aria-selected="true">
                        基本信息
                    </a>
                </li>
                {%if customer['id']%}
                <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#J_customer_invoice" role="tab" aria-controls="J_customer_invoice" aria-selected="false">
                        开票信息
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#J_customer_contact" role="tab" aria-controls="J_customer_contact" aria-selected="false">
                        联系人信息
                    </a>
                </li>
                {%endif%}
            </ul>
        </div>
        <div class="tab-content" id="J_worker_edit">
            <div class="tab-pane active" id="J_customer_basic">
                {{partial('customer/_basic')}}
            </div>
            {%if customer['id']%}
            <div class="tab-pane" id="J_customer_invoice">
                {{partial('customer/_invoice')}}
            </div>
            <div class="tab-pane" id="J_customer_contact">
                {{partial('customer/_contact')}}
            </div>
            {%endif%}
        </div>
    </div>
{{end_content_body()}}
<script>
(function(){
    var customerEdit = new Vue({
        el:'#J_worker_edit',
        delimiters:['<%','%>'],
        data:{
            address :{
                province  :"{{customer['province']}}",
                city      :"{{customer['city']}}",
                district  :"{{customer['district']}}",
                address   :"{{customer['address']}}"
            },
            invoice_address :{
                province  :"{{invoice['province']}}",
                city      :"{{invoice['city']}}",
                district  :"{{invoice['district']}}",
                address   :"{{invoice['address']}}"
            },
            customer:{{customer?json_encode(customer):'{}'}},
            invoice:{{invoice?json_encode(invoice):'{}'}}
        },
        methods:{
            copyTitle:function(){
                this.$set(this.invoice,'title',this.customer.subject);
            },
            copyAddress:function(){
                this.invoice_address = this.address;
            },
            'cert':function(){
                var self = this;
                $.ajax({
                    'url':"{{url('customer/cert/')}}/"+self.customer.id,
                    'type':'POST',
                    'success':function(re){
                        if(re.status == 'error'){
                            toastr.error(re.msg, '异常');
                        }else{
                            toastr.success(re.msg, '成功');
                            loadPage(re.redirect);
                        }
                    }
                });
            }
        }
    });
})();
</script>
<!-- /.content -->
