<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="display:none">
	<div id="edit_parent_business_warning" style="padding:5px">
		<div class="title">
			<div class="title-top">
				<h2>
					<spring:theme code="text.company.editOrDisableUsergroups.confirm"/>
				</h2>
			</div>
		</div>
		<div style="padding:5px">
			<spring:theme code="text.company.editOrDisableUsergroups.confirm.message"/>
		</div>
		<div>
			<button id="confirm_usergroup_update">
				<spring:theme code="text.company.editOrDisableUsergroups.confirm.action.label.confirm"/>
			</button>
			<button id="cancel_usergroup_update">
				<spring:theme code="text.company.editOrDisableUsergroups.confirm.action.label.cancel"/>
			</button>
		</div>
	</div>
</div>
