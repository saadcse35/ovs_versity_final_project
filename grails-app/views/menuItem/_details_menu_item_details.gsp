<tr id="details_menu_item_details${i}" style="display: <g:if test="${hidden == true}">none</g:if>" class="detail-row">
    <td>
        <g:hiddenField id="menuItems[${i}].id" name="menuItems[${i}].id" value="${menuItem?.id}"/>
        <g:hiddenField id="menuItems[${i}].deleted" name="menuItems[${i}].deleted" value="false"/>
        <g:hiddenField id="menuItems[${i}].new" name="menuItems[${i}].new"  value="${menuItem?.id == null ? true : false}"/>
        <g:textField id="menuItems[${i}].code" style="" name="menuItems[${i}].code"
                    value="${menuItem?.code}"      class="form-control" />
    </td>
    <td>
        <g:select type="text" id="menuItems[${i}].menuType"
                  from="${["Sub Module", "Menu Item", "Task", "Report Sub-Group", 'Report', 'Child Report']}"
                name="menuItems[${i}].menuType" class="form-control"
                  value="${menuItem?.menuType}" noSelection="['':'Select']"/>
    </td>
    <td>
        <g:textField  id="menuItems[${i}].name" style="" name="menuItems[${i}].name" class="form-control" value="${menuItem?.name}"/>
    </td>

    <td>
        <g:textField  id="menuItems[${i}].controllerName" style="" name="menuItems[${i}].controllerName" class="form-control" value="${menuItem?.controllerName}"/>
    </td>

    <td>
        <g:textField  id="menuItems[${i}].actionName" style="" name="menuItems[${i}].actionName" class="form-control" value="${menuItem?.actionName}"/>
    </td>
    <td>
        <g:textField type="number" id="menuItems[${i}].sortOrder" style="" name="menuItems[${i}].sortOrder" class="form-control" value="${menuItem?.sortOrder}"/>
    </td>
    <td>
        <g:checkBox id="menuItems[${i}].isActive" name="menuItems[${i}].isActive" class="form-control" style="height: 40px;"   value="${menuItem?.isActive}" />
    </td>
    <td>
        <div class="icon fb">
            <i  class="fa fa-trash-o"></i>
        </div>
    </td>
</tr>