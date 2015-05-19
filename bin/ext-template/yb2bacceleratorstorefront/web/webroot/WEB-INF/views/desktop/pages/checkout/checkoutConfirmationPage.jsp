<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/desktop/user" %>
<%@ taglib prefix="checkout" tagdir="/WEB-INF/tags/desktop/checkout" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>

	<cms:pageSlot position="TopContent" var="feature" element="div" class="span-24 top-content-slot cms_disp-img_slot">
		<cms:component component="${feature}"/>
	</cms:pageSlot>
	
	
	
	
	<div class="span-24">
		<div class="orderHead">
				<div><spring:theme code="checkout.orderConfirmation.thankYou" arguments="${orderData.code}"/></div>
				<div><spring:theme code="checkout.orderConfirmation.copySentTo" arguments="${email}"/></div>
		</div>
					
		<div class="orderBoxes clearfix">
			<order:paymentMethodItem order="${orderData}"/>
			<order:deliveryMethodItem order="${orderData}"/>
			<order:deliveryAddressItem order="${orderData}"/>
		</div>
		<order:orderDetailsItem order="${orderData}" />
		<div class="span-16">&nbsp;
			<order:receivedPromotions order="${orderData}"/>
		</div>
		<div class="span-8  last">
			<order:orderTotalsItem order="${orderData}" containerCSS="positive"/>
		</div>
	</div>
</template:page>
