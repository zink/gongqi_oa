{%if mode != 'component'%}
<script>
var config{{id}} = 
{%endif%}
    {
        delimiters:['<%','%>'],
        template:`{{partial('idc/idc_object/template')}}`,
        {%if mode == 'component'%}
        props:{
           'id':null,
           'multiple':{
               'default':false
           },
           'deleteBtn':{
               'default':true
           }
        },
        {%endif%}
        model:{
            'prop':'id',
            'event':'change'
        },
        data(){
            return {
                idc:[]
            }
        },
        mounted:function(){
            if(this.id){
                this.getIdcList();
            }
        },
        watch:{
            'id':function(){
                this.getIdcList();
            }
        },
        methods:{
            'getIdcList':function(){
                if(this.multiple){
                    if(this.id.length > 0){
                        var self = this;
                        $.ajax({
                            'url':"{{url('idc/get_list')}}",
                            'data':{
                                id:self.id
                            },
                            'success':function(re){
                                self.idc = re;
                            }
                        });
                    }else{
                        this.idc = [];
                    }
                }else{
                    var self = this;
                    $.ajax({
                        'url':"{{url('idc/get_list')}}",
                        'data':{
                            id:[self.id]
                        },
                        'success':function(re){
                            self.idc = re;
                        }
                    });
                }
            },
            'deleteIdc':function(id){
                var newId = [];
                this.id.forEach(function(item){
                    if(item != id){
                        newId.push(item);
                    }
                });
                this.id = newId;
                this.$emit('change',this.id);
                this.$emit('delete-idc',id);
            },
            'getList':function(){
                var self = this;
                var url = self.multiple?"{{url('idc/idc_modal/1')}}":"{{url('idc/idc_modal')}}";
                $.ajax({
                    'url':url,
                    'success':function(re){
                        var modal = $(re).appendTo($('body'));
                        modal.on('hidden.bs.modal',function(){
                            modal.remove();
                        }).on('click','.submit',function(){
                            var checked = modal.find('td input:checked');
                            if(self.multiple){
                                var value = [];
                                if(checked.length > 0){
                                    $.each(checked,function(index,item){
                                        value.push($(item).val())
                                    });
                                }
                                self.id = Array.from(new Set($.merge($.merge([],self.id),value)));
                            }else{
                                self.id = checked.val();
                            }
                            self.$emit('change',self.id);
                            modal.modal('hide');
                        });
                        modal.modal('show');
                    }
                });
            }
        }
    }
{%if mode != 'component'%}
var idc_{{id}} = new Vue(config{{id}});
</script>
{%endif%}
