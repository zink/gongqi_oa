{%if mode != 'component'%}
<script>
var config{{id}} = 
{%endif%}
    {
        delimiters:['<%','%>'],
        template:`{{partial('worker/worker_object/template')}}`,
        {%if mode == 'component'%}
        props:{
           'id':{
               'default':0
           },
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
                workers:[]
            }
        },
        mounted:function(){
            if(this.id){
                this.getWorkerList();
            }
        },
        watch:{
            'id':function(){
                this.getWorkerList();
            }
        },
        methods:{
            'getWorkerList':function(){
                if(this.multiple){
                    if(this.id.length > 0){
                        var self = this;
                        $.ajax({
                            'url':"{{url('worker/get_list')}}",
                            'data':{
                                id:self.id
                            },
                            'success':function(re){
                                self.workers = re;
                            }
                        });
                    }else{
                        this.workers = [];
                    }
                }else{
                    var self = this;
                    $.ajax({
                        'url':"{{url('worker/get_list')}}",
                        'data':{
                            id:[self.id]
                        },
                        'success':function(re){
                            self.workers = re;
                        }
                    });
                }
            },
            'deleteWorker':function(id){
                var newId = [];
                this.id.forEach(function(item){
                    if(item != id){
                        newId.push(item);
                    }
                });
                this.id = newId;
                this.$emit('change',this.id);
                this.$emit('delete-worker',id);
            },
            'getList':function(){
                var self = this;
                var url = self.multiple?"{{url('worker/worker_modal/1')}}":"{{url('worker/worker_modal')}}";
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
var worker_{{id}} = new Vue(config{{id}});
</script>
{%endif%}
