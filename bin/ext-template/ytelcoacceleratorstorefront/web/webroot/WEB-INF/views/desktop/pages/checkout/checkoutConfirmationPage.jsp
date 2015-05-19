<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>

<div class="telco-checkout checkout-confirmation"> <!-- telco change -->

	<div class="span-24 multicheckout">
	
		<ycommerce:testId code="orderConfirmation_yourOrderResults_text">
			<div class="span-24 your_order">
				<h1>
					<spring:theme code="checkout.orderConfirmation.thankYou" arguments="${orderData.code}"/>
				</h1>
				<p>
					<spring:theme code="checkout.orderConfirmation.copySentTo" arguments="${email}"/>
				</p>
			</div>
		</ycommerce:testId>

		<div class="span-24 top-content-slot">
			<cms:slot var="feature" contentSlot="${slots.TopContent}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>

		<div class="checkout_summary_flow">
			<div class="checkout_summary_flow_a complete">
				<order:deliveryAddressItem order="${orderData}"/>
			</div>
			<div class="checkout_summary_flow_b complete">
				<order:deliveryMethodItem order="${orderData}"/>
			</div>
			<div class="checkout_summary_flow_c complete">
				<order:paymentMethodItem order="${orderData}"/>
			</div>
		</div>

		<div id="checkout-cart-details">
			<div class="cart-entries-data">
				<order:orderDetailsItem order="${orderData}"/>
			</div>
			<div class="cart-entries-totals">
				<order:orderTotalsItem order="${orderData}" containerCSS="positive"/>
			</div>
			<div class="cart-entries-promo">
				<order:receivedPromotions order="${orderData}"/>
			</div>
		</div>
		
	</div>
	
	<div class="span-24 side-content-slot disp-img">
		<cms:slot var="feature" contentSlot="${slots.SideContent}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
	
</div>
</template:page>
