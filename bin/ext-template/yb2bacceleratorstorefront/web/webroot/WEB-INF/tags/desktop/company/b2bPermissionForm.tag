<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ attribute name="saveUrl" required="true" type="java.lang.String"%>
<%@ attribute name="cancelUrl" required="true" type="java.lang.String"%>
<%@ attribute name="b2BPermissionForm" required="true"
	type="de.hybris.platform.yb2bacceleratorstorefront.forms.B2BPermissionForm"%>

<form:form action="${saveUrl}" id="b2BPermissionForm"
	commandName="b2BPermissionForm" method="POST">
	<div class="required right"><spring:theme code="form.required" text="Fields marked * are required" /></div>
		<form:input type="hidden" name="originalCode" path="originalCode"
			id="originalCode" />
		<form:input type="hidden" name="permissionType" path="permissionType"
			id="permissionType" />
		<form:input type="hidden" name="b2BPermissionTypeData.code"
			path="b2BPermissionTypeData.code" id="b2BPermissionTypeData.code" />
		<form:input type="hidden" name="b2BPermissionTypeData.name"
			path="b2BPermissionTypeData.name" id="b2BPermissionTypeData.name" />
		<p>
			<spring:theme code="text.company.managePermissions.type.label"
				text="Permission type" />
			: ${b2BPermissionForm.permissionType}
		</p>

		<formElement:formInputBox
			idKey="text.company.managePermissions.name.label"
			labelKey="text.company.managePermissions.name.label" path="code"
			inputCSS="text"/>
		<formElement:formSelectBox
			idKey="text.company.managePermissions.unit.label"
			skipBlankMessageKey="text.company.costCenter.selectBox.unit"
			labelKey="text.company.managePermissions.unit.label"
			path="parentUnitName" mandatory="true" items="${b2bUnits}" />

		<c:if
			test="${b2BPermissionForm.b2BPermissionTypeData.code ne 'B2BBudgetExceededPermission' }">

			<c:if
				test="${b2BPermissionForm.b2BPermissionTypeData.code eq
				'B2BOrderThresholdTimespanPermission'}">

				<formElement:formSelectBox
					idKey="text.company.managePermissions.timespan.label"
					skipBlankMessageKey="text.company.managePermissions.selectBox.timespan"
					labelKey="text.company.managePermissions.timespan.label"
					path="timeSpan" mandatory="true" items="${b2bPeriodRanges}" />
			</c:if>

			<formElement:formSelectBox
				idKey="text.company.managePermissions.currency.label"
				skipBlankMessageKey="text.company.costCenter.selectBox.currency"
				labelKey="text.company.managePermissions.currency.label"
				path="currency" mandatory="true" items="${b2bCostCenterCurrencies}" />

			<formElement:formInputBox
				idKey="text.company.managePermissions.value.label"
				labelKey="text.company.managePermissions.value.label" path="value"
				inputCSS="text" mandatory="true" />
		</c:if>

	<ycommerce:testId code="Permission_Cancel_button">
		<a href="${cancelUrl}" class="button no-confirm"><spring:theme code="text.company.managePermissions.edit.cancelButton" text="Cancel" /></a>
	</ycommerce:testId>
	<ycommerce:testId code="Permission_Save_button">
		<button type="submit" class="confirm"><spring:theme code="text.company.managePermissions.edit.saveButton" text="Save" /></button>
	</ycommerce:testId>
</form:form>
