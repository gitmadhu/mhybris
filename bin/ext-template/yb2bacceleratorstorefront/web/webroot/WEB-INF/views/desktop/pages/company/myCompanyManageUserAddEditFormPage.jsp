<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:if test="${empty saveUrl}">
	<c:choose>
		<c:when test="${not empty b2BCustomerForm.uid}">
			<spring:url value="/my-company/organization-management/manage-users/edit" var="saveUrl">
				<spring:param name="user" value="${b2BCustomerForm.uid}"/>
			</spring:url>
		</c:when>
		<c:otherwise>
			<spring:url value="/my-company/organization-management/manage-users/create" var="saveUrl"/>
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${empty cancelUrl}">
	<c:choose>
		<c:when test="${not empty b2BCustomerForm.uid}">
			<spring:url value="/my-company/organization-management/manage-users/details"
						var="cancelUrl">
				<spring:param name="user" value="${b2BCustomerForm.uid}"/>
			</spring:url>
		</c:when>
		<c:otherwise>
			<c:url value="/my-company/organization-management/manage-users" var="cancelUrl"/>
		</c:otherwise>
	</c:choose>
</c:if>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="users"/>
	<div class="column companyContentPane clearfix">
		<div class="headline">
					<c:choose>
						<c:when test="${not empty b2BCustomerForm.uid}">
							<spring:theme code="text.company.${action}.edituser.title" text="${action}" arguments="${b2BCustomerForm.parentB2BUnit}"/>
						</c:when>
						<c:otherwise>
							<spring:theme code="text.company.${action}.adduser.title" text="${action}" arguments="${param.unit}"/>
						</c:otherwise>
					</c:choose>
			
			</div>
			<div class="required right"><spring:theme code="form.required" text="Fields marked * are required"/></div>
			<div class="description">
				
					<c:choose>
						<c:when test="${not empty b2BCustomerForm.uid}">
							<spring:theme code="text.mycompany.user.updateForm"
										  text="Please use this form to update customer details"
										  arguments="${b2BCustomerForm.uid}"/>
						</c:when>
						<c:otherwise>
							<spring:theme code="text.mycompany.user.createForm"
										  text="Please use this form to create a new customer details"/>
						</c:otherwise>
					</c:choose>
			</div>
				
				<form:form action="${saveUrl}" method="post" commandName="b2BCustomerForm">
					<div class="b2BCustomerFormList">
						<formElement:formSelectBox idKey="user.title" labelKey="user.title" path="titleCode"
												mandatory="true"
												skipBlank="false" skipBlankMessageKey="form.select.empty"
												items="${titleData}"/>
						<form:input type="hidden" name="uid" path="uid" id="uid"/>
						<formElement:formInputBox idKey="user.firstName" labelKey="user.firstName" path="firstName"
											   inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="user.lastName" labelKey="user.lastName" path="lastName"
											   inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="user.email" labelKey="user.email" path="email"
													   inputCSS="text"
													   mandatory="true"/>
						<formElement:formSelectBox idKey="text.company.user.unit.title" skipBlank="false"
												labelKey="text.company.user.unit.title" path="parentB2BUnit"
												mandatory="true" items="${b2bUnits}" disabled="${not empty param.unit and not empty param.role}"
												skipBlankMessageKey="form.select.empty"/>
						<formElement:formCheckboxes idKey="text.company.user.roles" labelKey="text.company.user.roles"
												 path="roles"
												 mandatory="false" items="${roles}" disabled="${not empty param.unit and not empty param.role}" typeIdentifier="String"/>
					</div>

					<ycommerce:testId code="User_Cancel_button">
						<a href="${cancelUrl}" class="button cancel"><spring:theme code="b2bcustomer.cancel" text="Cancel"/></a>
					</ycommerce:testId>
					<ycommerce:testId code="User_Save_button">
						<button type="submit" class="save"><spring:theme code="text.account.user.saveUpdates" text="Save Updates"/></button>
					</ycommerce:testId>

				</form:form>
				<common:back cancelUrl="${cancelUrl}"/>
	</div>
</template:page>
