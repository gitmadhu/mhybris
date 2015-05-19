<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="checkout" tagdir="/WEB-INF/tags/desktop/checkout" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>

<c:url value="/checkout/single" var="continueToSingleStepCheckoutUrl"/>

<template:page pageTitle="${pageTitle}">

	<div id="globalMessages">
		<common:globalMessages/>
	</div>

	<cms:pageSlot position="SideContent" var="feature" element="div" class="span-4 side-content-slot cms_disp-img_slot">
		<cms:component component="${feature}"/>
	</cms:pageSlot>

	<div class="span-20 right last">
		<div class="information_message neutral">
			<span class="single"></span>
			<p><spring:theme code="checkout.multi.sampleLandingPage.text"/></p>
		</div>
		<div class="span-20 last">
			<checkout:summaryCartItems cartData="${cartData}"/>
		</div>
		<div class="span-12">
			<cart:cartPromotions cartData="${cartData}"/>
		</div>
		<div class="span-8 right last place-order-cart-total">
			<cart:ajaxCartTotals/>
		</div>
	</div>

	<div class="span-20 right last">
		<ycommerce:testId code="continueToSingleStepCheckout_link">
			<a href="${continueToSingleStepCheckoutUrl}" class="positive right">
				<spring:theme code="checkout.multi.continueToSingleStep"/>
			</a>
		</ycommerce:testId>
	</div>
</template:page>
