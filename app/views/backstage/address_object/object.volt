{%if mode != 'component'%}
{{partial('backstage/address_object/template')}}
<script>
var config{{id}} = 
{%endif%}
{
    {%if mode != 'component'%}
    el:'#{{id}}',
    {%endif%}
    delimiters:['<%','%>'],
    {%if mode == 'component'%}
    props:{
        'address':{
            default:{
                province:'',
                city:'',
                district:'',
                address:''
            }
        },
        'hasAddress':{
            default:true
        },
        'provinceName':String,
        'cityName':String,
        'districtName':String,
        'addressName':String
    },
    template:`{{partial('backstage/address_object/template')}}`,
    {%endif%}
    data:function(){
        return {
            'districtsLib':districts,
        }
    },
    model:{
        'prop':'address',
        'event':'change'
    },
    computed:{
        'computedProvince':function(){
            return this.districtsLib[100000];
        },
        'computedCity':function(){
            return this.districtsLib[this.address.province.split(':')[0]];
        },
        'computedDistrict':function(){
            return this.districtsLib[this.address.city.split(':')[0]];
        },
        'computedProvinceName':function(){
            return this.provinceName?this.provinceName:'province';
        },
        'computedCityName':function(){
            return this.cityName?this.cityName:'city';
        },
        'computedDistrictName':function(){
            return this.districtName?this.districtName:'district';
        },
        'computedAddressName':function(){
            return this.addressName?this.addressName:'address';
        }
    },
    methods:{
        'formatArea':function(area){
            if(area != ''){
                return area.split(':')[1];
            }else{
                return '';
            }
        },
    }
}
{%if mode != 'component'%}
var addressEdit = new Vue(config{{id}});
</script>
{%endif%}
