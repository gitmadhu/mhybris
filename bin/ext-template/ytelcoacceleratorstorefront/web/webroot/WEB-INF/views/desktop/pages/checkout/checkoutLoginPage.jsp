<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/desktop/user" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	
<div class="telco-checkout checkout-login"> <!-- telco change -->
	
	<div class="span-20">
		<div class="span-10 last">
			<c:url value="/login/checkout/register" var="registerAndCheckoutActionUrl" />
			<user:register actionNameKey="checkout.login.registerAndCheckout" action="${registerAndCheckoutActionUrl}"/>
		</div>
		<div class="span-10">
			<c:url value="/checkout/j_spring_security_check" var="loginAndCheckoutActionUrl" />
			<user:login actionNameKey="checkout.login.loginAndCheckout" action="${loginAndCheckoutActionUrl}"/>
		</div>
	</div>
	
	<div class="span-4 side-content-slot last">
		<cms:slot var="feature" contentSlot="${slots.SideContent}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
	
</div>
</template:page>