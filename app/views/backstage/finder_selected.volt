<table class="table table-striped table-bordered">
    <tr>
        {%for column in columns%}
        <th>
            {{column['name']}}
        </th>
        {%endfor%}
    </tr>
    {%for item in list%}
    <tr>
        {%for index,column in columns%}
        <td>
            {{item[index]}}
        </td>
        {%endfor%}
    </tr>
    {%endfor%}
</table>
