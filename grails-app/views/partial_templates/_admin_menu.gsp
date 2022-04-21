<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
<!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->

    <g:set var="moduleList" value="${common.accessControl.MenuItem.executeQuery('from MenuItem c where c.menuType = ?', ['Module'])}"/>
    <g:each in="${moduleList.sort { it.sortOrder }}" var="module">
        <li class="nav-header">${module.name}</li>
        <g:each in="${module.menuItems.sort { it.sortOrder }}" var="subModule">
            <li class="nav-item has-treeview">
                <a href="#" class="nav-link">
                    <i class="nav-icon fas fa-circle"></i>
                    <p>
                        ${subModule.name}
                        <i class="right fas fa-angle-left"></i>
                    </p>
                </a>

                <ul class="nav nav-treeview">
                    <g:each in="${subModule.menuItems.sort { it.sortOrder }}" var="task">
                        <li class="nav-item">
                            <g:link controller="${task.controllerName}" action="${task.actionName}" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>${task.name}</p>
                            </g:link>
                        </li>
                    </g:each>
                </ul>
            </li>
        </g:each>
    </g:each>
</ul>