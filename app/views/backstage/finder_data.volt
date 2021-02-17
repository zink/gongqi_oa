<table class="table table-striped">
    <tr>
        <th>
            {%if multiple%}
            {{select_all()}}
            {%endif%}
        </th>
        {%for column in columns%}
        <th>
            {{column['name']}}
        </th>
        {%endfor%}
    </tr>
    {%for item in list%}
    <tr>
        <td>
            <div class="icheck-primary d-inline">
                {%if multiple%}
                <input id="model_{{item['id']}}" name="id[]" value="{{item['id']}}" type="checkbox"/>
                {%else%}
                <input id="model_{{item['id']}}" name="id" value="{{item['id']}}" type="radio"/>
                {%endif%}
                <label for="model_{{item['id']}}"></label>
            </div>
        </td>
        {%for index,column in columns%}
        <td>
            {{item[index]}}
        </td>
        {%endfor%}
    </tr>
    {%endfor%}
</table>
<div class="card-footer clearfix">
    {{pagination(['last':last,'custom':'#J_data_'~finder_id])}}
</div>
