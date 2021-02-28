<div class="card" id="J_{{id}}">
    <div class="card-header" v-if="title">
        <%title%>
    </div>
    <div class="card-body">
        <div class="image-box" style="width:200px;">
            <img v-if="imageSrc != ''" :src="imageSrc" class="img-thumbnail">
        </div>
    </div>
    <div class="card-footer">
        <input type="file" ref="upload_btn" :data-url="url"/>
    </div>
</div>
