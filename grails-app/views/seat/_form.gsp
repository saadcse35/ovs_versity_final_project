<%@ page import="onlinevotingsystem.Seat" %>
<asset:javascript src="seat.js"/>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="seat.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" disabled="disabled" name="code" required="" value="${seatInstance?.code}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="seat.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${seatInstance?.name}"/>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'parliamentSeatNo', 'error')} required">
		<div class="form-group">
			<label for="parliamentSeatNo" class="control-label">
				<g:message code="seat.parliamentSeatNo.label" default="Parliament Seat No" />
				<span class="required-indicator">*</span>
			</label>
			<g:field class="form-control" name="parliamentSeatNo" type="number" value="${seatInstance.parliamentSeatNo}" required=""/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'boundary', 'error')} required">
		<div class="form-group">
			<label for="boundary" class="control-label">
				<g:message code="seat.boundary.label" default="Boundary" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="boundary" required="" value="${seatInstance?.boundary}"/>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'divisionId', 'error')} required">
		<div class="form-group">
			<label for="divisionId" class="control-label">
				<g:message code="seat.divisionId.label" default="Division Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control location" id="divisionId" name="divisionId.id" from="${common.data.Location.findAllByLocationType('State/Division')}" optionKey="id" required="" noSelection="['':'']" value="${seatInstance?.divisionId?.id}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'districtId', 'error')} required">
		<div class="form-group">
			<label for="districtId" class="control-label">
				<g:message code="seat.districtId.label" default="District Id" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" id="districtId" name="districtId.id" from="${common.data.Location.findAllByLocationType('District')}" optionKey="id" required="" noSelection="['':'']" value="${seatInstance?.districtId?.id}" />
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="seat.isActive.label" default="Is Active" />
				
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${seatInstance?.isActive}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: seatInstance, field: 'sortOrder', 'error')} ">
		<div class="form-group">
			<label for="sortOrder" class="control-label">
				<g:message code="seat.sortOrder.label" default="Sort Order" />

			</label>
			<g:field class="form-control" name="sortOrder" type="number" value="${seatInstance.sortOrder}"/>
		</div>
	</div>
</div>



