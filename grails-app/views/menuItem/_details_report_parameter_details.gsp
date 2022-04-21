<tr id="details_report_parameter_details${i}" style="display: <g:if test="${hidden == true}">none</g:if>" class="detail-row">
    <td>
        <g:hiddenField id="reportParameterDetails[${i}].id" name="reportParameterDetails[${i}].id" value="${reportParameterDetail?.id}"/>
        <g:hiddenField id="reportParameterDetails[${i}].deleted" name="reportParameterDetails[${i}].deleted" value="false"/>
        <g:hiddenField id="reportParameterDetails[${i}].new" name="reportParameterDetails[${i}].new"  value="${reportParameterDetail?.id == null ? true : false}"/>
        <g:select from="${common.reportCenter.ReportParameter.executeQuery('from ReportParameter  c where c.isActive = ? and status = ? order by c.sortOrder', [true, 'ACTIVE'])}"
                id="reportParameterDetails[${i}].reportParameterId" style="" name="reportParameterDetails[${i}].reportParameterId"
                    value="${reportParameterDetail?.reportParameterId?.id}"  optionKey="id"    class="form-control" />
    </td>
    <td>
        <g:checkBox id="reportParameterDetails[${i}].isActive" name="reportParameterDetails[${i}].isActive" class="form-control" style="height: 40px;"   value="${reportParameterDetail?.isActive}" />
    </td>
    <td>
        <g:textField type="number" id="reportParameterDetails[${i}].sortOrder" style="" name="reportParameterDetails[${i}].sortOrder" class="form-control" value="${reportParameterDetail?.sortOrder}"/>
    </td>
    <td>
        <div class="icon fb">
            <i  class="fa fa-trash-o"></i>
        </div>
    </td>
</tr>