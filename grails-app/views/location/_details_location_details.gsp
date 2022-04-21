<tr id="details_location_details${i}" style="display: <g:if test="${hidden == true}">none</g:if>" class="detail-row">
    <td>
        <g:hiddenField id="locations[${i}].id" name="locations[${i}].id" value="${locationDetail?.id}"/>
        <g:hiddenField id="locations[${i}].deleted" name="locations[${i}].deleted" value="false"/>
        <g:hiddenField id="locations[${i}].new" name="locations[${i}].new"  value="${locationDetail?.id == null ? true : false}"/>
        <g:textField id="locations[${i}].code" style="" name="locations[${i}].code"
                   value="${locationDetail?.code}"   class="form-control" />
    </td>

    <td>
        <g:textField  id="locations[${i}].name" style="" name="locations[${i}].name" class="form-control" value="${locationDetail?.name}"/>
    </td>
    <td>
        <g:select type="text" id="locations[${i}].locationType" from="${locationInstance.constraints.locationType.inList}"
                  name="locations[${i}].locationType" class="form-control" value="${locationDetail?.locationType}" noSelection="['':'Select']"/>
    </td>
    <td>
        <g:checkBox id="locations[${i}].isActive" name="locations[${i}].isActive" class="form-control" style="height: 40px;"   value="${locationDetail?.isActive}" />
    </td>
    <td>
        <g:textArea id="locations[${i}].remarks" name="locations[${i}].remarks" class="form-control"   value="${locationDetail?.remarks}" />
    </td>
    <td>
        <div class="icon fb">
            <i  class="fa fa-trash-o"></i>
        </div>
    </td>
</tr>