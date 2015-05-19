<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ attribute name="saveUrl" required="true" type="java.lang.String"%>
<%@ attribute name="cancelUrl" required="true" type="java.lang.String"%>
<%@ attribute name="b2BCostCenterForm" required="true"
	type="de.hybris.platform.yb2bacceleratorstorefront.forms.B2BCostCenterForm"%>

<form:form action="${saveUrl}" id="b2BCostCenterform"
	commandName="b2BCostCenterForm" method="POST">
	<div class="required right"><spring:theme code="form.required" text="Fields marked * are required" /></div>
		<form:input type="hidden" name="originalCode" path="originalCode"
			id="originalCode" />
		<formElement:formInputBox idKey="text.company.costCenter.id.title"
			labelKey="text.company.costCenter.id.title" path="code"
			inputCSS="text" mandatory="true" />
		<formElement:formInputBox idKey="text.company.costCenter.name.title"
			labelKey="text.company.costCenter.name.title" path="name"
			inputCSS="text" mandatory="true" />
		<formElement:formSelectBox idKey="text.company.costCenter.unit.title"
			skipBlank="true" labelKey="text.company.costCenter.unit.title"
			path="parentB2BUnit" mandatory="true" items="${b2bUnits}" />
		<formElement:formSelectBox idKey="text.company.costCenter.currency.title"
			skipBlank="true" labelKey="text.company.costCenter.currency.title"
			path="currency" mandatory="true" items="${b2bCostCenterCurrencies}" />
	<ycommerce:testId code="CC_cancel">
		<a href="${cancelUrl}" class="button no-confirm"><spring:theme code="text.company.costCenter.cancelButton.displayName" /></a>
	</ycommerce:testId>
	<ycommerce:testId code="CC_save">
		<button type="submit" class="button confirm"><spring:theme code="text.company.costCenter.saveButton.displayName" /></button>
	</ycommerce:testId>
</form:form>