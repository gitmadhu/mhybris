<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company"%>

<spring:url value="/my-company/organization-management/manage-budgets/view" var="cancelUrl">
	<spring:param name="budgetCode" value="${b2BBudgetForm.originalCode}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-budgets/update" var="saveUrl">
	<spring:param name="budgetCode" value="${b2BBudgetForm.originalCode}"/>
</spring:url>

<template:page pageTitle="${pageTitle}">
	<spring:theme code="text.store.dateformat.datepicker.selection" text="mm/dd/yy" var="dateForForDatePicker"/>
	<spring:theme code="text.store.dateformat.datepicker.selection.hint" text="mm/dd/yyyy" var="dateFormatHint"/>

	<script type="text/javascript"> // set vars
		/*<![CDATA[*/		
		var budgetStartEnd = '${dateForForDatePicker}';
		var budgetStartEndHint = '${dateFormatHint}';
		
		/*]]>*/
	</script>
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="budgets"/>
	<div class="column companyContentPane clearfix">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>
		<div class="headline"><spring:theme code="text.company.budget.edit.title.label" text="Edit Budget: {0}" arguments="${b2BBudgetForm.name}"/></div>
		<company:b2bBudgetForm cancelUrl="${cancelUrl}" saveUrl="${saveUrl}" b2BBudgetForm="${b2BBudgetForm}"/>
			<common:back cancelUrl="${cancelUrl}"/>
	</div>
</template:page>
