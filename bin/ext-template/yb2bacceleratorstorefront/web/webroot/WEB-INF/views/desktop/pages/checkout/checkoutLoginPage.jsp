<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/desktop/user" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>




	
	<div class="span-24">
	
		
		<cms:pageSlot position="SideContent" var="feature" element="div" class="span-4 side-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>
		


	

		<div class="span-20 last">
			<c:url value="/checkout/j_spring_security_check" var="loginAndCheckoutAction" />
			<user:login actionNameKey="checkout.login.loginAndCheckout" action="${loginAndCheckoutAction}"/>
		</div>
		
		<cms:pageSlot position="MerchantContactContent" var="feature" >
			<cms:component component="${feature}" element="div" class="span-20 last prepend-4 login-info"/>
		</cms:pageSlot>	

	</div>






</template:page>