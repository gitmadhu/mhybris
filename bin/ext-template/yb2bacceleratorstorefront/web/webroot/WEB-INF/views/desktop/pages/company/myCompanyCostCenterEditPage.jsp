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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company"%>

<c:if test="${empty saveUrl}">
	<spring:url value="/my-company/organization-management/manage-costcenters/update" var="saveUrl"/>
</c:if>
<c:if test="${empty cancelUrl}">
	<spring:url value="/my-company/organization-management/manage-costcenters/view"
				var="cancelUrl">
		<spring:param name="costCenterCode" value="${b2BCostCenterForm.originalCode}"/>
	</spring:url>
</c:if>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="costCenters"/>
	<div class="column companyContentPane clearfix">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>
		<div class="headline"><spring:theme code="text.company.costCenter.edit.label" text="Edit Cost Center" arguments="${b2BCostCenterForm.name}"/></div>
		<company:b2bCostCenterForm cancelUrl="${cancelUrl}" saveUrl="${saveUrl}" b2BCostCenterForm="${b2BCostCenterForm}"/>
		<common:back cancelUrl="${cancelUrl}"/>
	</div>
</template:page>
