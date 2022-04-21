<%@ page import="common.data.Location" %>

<script type="text/javascript">
	var locationsCount = ${locationInstance?.locations?.size()} + 0;
	function addLocations(){
		var clonedRow = $('#details_location_details_sample').clone();
		console.log(clonedRow);
		var idCmn = 'locations[' + locationsCount + '].';
		clonedRow.find('[id$=id]').attr('id', idCmn + 'id' ).attr('name', idCmn + 'id' );
		clonedRow.find('[id$=deleted]').attr('id', idCmn +'deleted' ).attr('name', idCmn +'deleted' );
		clonedRow.find('[id$=new]').attr('id', idCmn +'new' ).attr('name', idCmn +'new' );
		clonedRow.find('[id$=code]').attr('id', idCmn +'code' ).attr('name', idCmn +'code' ).attr('required', 'required');
		clonedRow.find('[id$=name]').attr('id', idCmn +'name' ).attr('name', idCmn +'name' ).attr('required', 'required');
		clonedRow.find('[id$=locationType]').attr('id', idCmn +'locationType' ).attr('name', idCmn +'locationType' ).attr('required', 'required');
		clonedRow.find('[id$=isActive]').attr('id', idCmn +'isActive' ).attr('name', idCmn +'isActive' );
		clonedRow.find('[id$=remarks]').attr('id', idCmn +'remarks' ).attr('name', idCmn +'remarks' );
		clonedRow.attr('id', 'details_location_details'+locationsCount);
		$('#detailRows').append(clonedRow);
		clonedRow.show();
		locationsCount++;
	}

	$(document).ready(function () {
		$('#detailRows').on('click', '.icon', function(){
			var tr = $(this).parent().parent();
			tr.find('[id$=deleted]').attr('value', 'true');
			tr.find('select').removeAttr('required');
			tr.find('input').removeAttr('required');
			tr.hide();
		});
	});
</script>

<div class="row">
	%{--<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: locationInstance, field: 'code', 'error')} required">
		<div class="form-group">
			<label for="code" class="control-label">
				<g:message code="location.code.label" default="Code" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="code" maxlength="30" required="" value="${locationInstance?.code}" disabled="disabled"/>
		</div>
	</div>--}%

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: locationInstance, field: 'name', 'error')} required">
		<div class="form-group">
			<label for="name" class="control-label">
				<g:message code="location.name.label" default="Name" />
				<span class="required-indicator">*</span>
			</label>
			<g:textField class="form-control" name="name" maxlength="100" required="" value="${locationInstance?.name}"/>
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: locationInstance, field: 'locationType', 'error')} required">
		<div class="form-group">
			<label for="locationType" class="control-label">
				<g:message code="location.locationType.label" default="Location Type" />
				<span class="required-indicator">*</span>
			</label>
			<g:select class="form-control" name="locationType" from="${locationInstance.constraints.locationType.inList}" required="" value="${locationInstance?.locationType}" noSelection="['':'']" valueMessagePrefix="location.locationType"/>
		</div>
	</div>
</div>

%{--<div class="row">


	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: locationInstance, field: 'parentId', 'error')} ">
		<div class="form-group">
			<label for="parentId" class="control-label">
				<g:message code="location.parentId.label" default="Parent" />
			</label>
			<g:select class="form-control" id="parentId" name="parentId.id" from="${Location.list()}" optionKey="id" value="${locationInstance?.parentId?.id}"  noSelection="['null': '']"/>
		</div>
	</div>
</div>--}%


<div class="row">
	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: locationInstance, field: 'isActive', 'error')} ">
		<div class="form-group">
			<label for="isActive" class="control-label">
				<g:message code="location.isActive.label" default="Is Active" />
			</label>
			<g:checkBox class="form-control" style="height: 40px;" name="isActive" value="${locationInstance?.isActive}" />
		</div>
	</div>

	<div class="col-lg-6 col-md-6 col-sm-12 fieldcontain ${hasErrors(bean: locationInstance, field: 'remarks', 'error')} ">
		<div class="form-group">
			<label for="remarks" class="control-label">
				<g:message code="location.remarks.label" default="Remarks" />
			</label>
			<g:textArea class="form-control" name="remarks" cols="40" rows="2" maxlength="1000" value="${locationInstance?.remarks}"/>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-12 col-md-12">
		<h3><strong>Included Locations</strong></h3><hr class="hrtag"/>
		<g:render template="details"/>
		<div class="addDetailsButton" id="addDetailsButton" style="margin-bottom: 15px">
			<input type="button"  class="btn btn-success" onClick="addLocations();" value="Add Details"/>
		</div>
	</div>
</div>
