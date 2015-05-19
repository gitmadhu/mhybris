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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>

<spring:url value="/my-company/organization-management/manage-permissions" var="cancelUrl" />

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
		<div class="headline"><spring:theme code="text.company.managePermissions.create.permission.title" text="Create Permission" /></div>
		<div class="required right"><spring:theme code="form.required" text="Fields marked * are required"/></div>
		
		<spring:theme code="text.company.managePermissions.create.step1" text="Step 1 of 2"/>
				
		<form:form id="b2BPermissionTypeSelectionForm" commandName="b2BPermissionTypeSelectionForm" method="POST">
			<formElement:formSelectBox idKey="text.company.managePermissions.type.label" labelKey="text.company.managePermissions.type.label" skipBlankMessageKey="text.company.managePermissions.selectBox.permissionType" mandatory="true" path="b2BPermissionType" items="${ b2bPermissionTypes}" />
			<a href="${cancelUrl}" class="button cancel"><spring:theme code="text.company.managePermissions.edit.cancelButton" text="Cancel" /></a>
			<button type="submit" class="continue"><spring:theme code="text.company.managePermissions.create.continueButton" text="Continue" /></button> 
		</form:form>
	</div>
</template:page>
