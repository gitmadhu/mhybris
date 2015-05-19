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

<spring:url
	value="/my-company/organization-management/manage-permissions/disable"
	var="confirmDisableUrl">
	<spring:param name="permissionCode" value="${permissionCode}"/>
</spring:url>

<spring:url
	value="/my-company/organization-management/manage-permissions/view"
	var="cancelDisableUrl">
	<spring:param name="permissionCode" value="${permissionCode}"/>
</spring:url>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<nav:myCompanyNav selected="managePermissions"/>
	<div class="column companyContentPane clearfix">
		<div class="headline"><spring:theme code="text.company.managePermissions.disable.confirm" text="Confirm Disable"/></div>
		<div class="description"><spring:theme code="text.company.managePermissions.disable.confirm.message"></spring:theme></div>
			
		<a href="${cancelDisableUrl}" class="button no-confirm"><spring:theme code="text.company.managePermissions.disable.confirm.no"/></a>
		<form:form action="${confirmDisableUrl}">
			<button class="confirm"><spring:theme code="text.company.managePermissions.disable.confirm.yes"/></button>
		</form:form>
	</div>
</template:page>
