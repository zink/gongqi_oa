<div class="card" id="{{id}}">
    <div class="card-body">
        <div class="form-group row">
            <div class="col-md-4">
                <select :name="computedProvinceName" class="form-control input-sm" v-model=address.province>
                    <option v-for="item,index in computedProvince" :value="index+':'+item"><%item%></option>
                </select>
            </div>
            <div class="col-md-4">
                <select :name="computedCityName" class="form-control input-sm" v-model=address.city>
                    <option v-for="item,index in computedCity" :value="index+':'+item"><%item%></option>
                </select>
            </div>
            <div class="col-md-4">
                <select :name="computedDistrictName" class="form-control input-sm" v-model=address.district>
                    <option v-for="item,index in computedDistrict" :value="index+':'+item"><%item%></option>
                </select>
            </div>
        </div>
        <div class="form-group row" v-if="hasAddress">
            <div class="col-md-12">
                <input type="text" :name="computedAddressName" class="form-control" placeholder="详细地址" v-model="address.address"/>
            </div>
        </div>
    </div>
</div>
