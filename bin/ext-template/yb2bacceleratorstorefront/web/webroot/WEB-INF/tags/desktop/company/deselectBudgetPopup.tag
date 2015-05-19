<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="display:none">
	<div id="deselect_budget_warning" style="padding:5px">
		<div class="title">
			<div class="title-top">
				<h2>
					<spring:theme code="text.company.budget.deselect.confirm"/>
				</h2>
			</div>
		</div>
		<div style="padding:5px">
			<spring:theme code="text.company.budget.disable.confirm.message"/>
		</div>
		<div>
			<button id="confirm_deselect">
				<spring:theme code="text.company.deselect.action.label.confirm"/>
			</button>
			<button id="cancel_deselect">
				<spring:theme code="text.company.budget.cancelButton.displayName"/>
			</button>
		</div>
	</div>
</div>