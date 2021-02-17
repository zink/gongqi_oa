<div class="modal fade" id="J_modal_{{finder_id}}" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{title}}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body p-0">
                <div id="J_data_{{finder_id}}">
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
                                    <input id="model_{{finder_id}}_{{item['id']}}" name="id[]" value="{{item['id']}}" type="checkbox"/>
                                    {%else%}
                                    <input id="model_{{finder_id}}_{{item['id']}}" name="id" value="{{item['id']}}" type="radio"/>
                                    {%endif%}
                                    <label for="model_{{finder_id}}_{{item['id']}}"></label>
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
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="J_confirm_{{finder_id}}">确定</button>
            </div>
        </div>
    </div>
</div>
