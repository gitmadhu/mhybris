<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company"%>

<c:if test="${empty cancelUrl}">
	<spring:url
		value="/my-company/organization-management/manage-permissions/view"
		var="cancelUrl">
		<spring:param name="permissionCode"
			value="${b2BPermissionForm.originalCode}" />
	</spring:url>
</c:if>
<c:if test="${empty saveUrl}">
	<spring:url
		value="/my-company/organization-management/manage-permissions/edit"
		var="saveUrl">
		<spring:param name="permissionCode"
			value="${b2BPermissionForm.originalCode}" />
	</spring:url>
</c:if>
<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}" />
	</div>
	<div id="globalMessages">
		<common:globalMessages />
	</div>
	<nav:myCompanyNav selected="managePermissions" />
	<div class="column companyContentPane clearfix">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>				
		<div class="headline"><spring:theme code="text.company.managePermissions.edit.page.title" text="Edit Permission" /></div>
		<company:b2bPermissionForm cancelUrl="${cancelUrl}" saveUrl="${saveUrl}" b2BPermissionForm="${b2BPermissionForm}"/>
	</div>
</template:page>
