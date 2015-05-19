<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="checkout" tagdir="/WEB-INF/tags/desktop/checkout" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/desktop/checkout/multi" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<c:url value="/checkout/multi/choose-delivery-method" var="chooseDeliveryMethodUrl"/>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	
<div class="telco-checkout checkout-delivery-address"> <!-- telco change -->

	<multi-checkout:checkoutProgressBar steps="${checkoutSteps}" currentStep="1" stepName="deliveryAddress"/>
	
	<div class="span-24 multicheckout">
	
		<div class="span-24">
			<div class="item_container_holder">
				<div class="title_holder">
					<div class="title">
						<div class="title-top">
							<span></span>
						</div>
					</div>
					<h2><span></span><spring:theme code="checkout.multi.deliveryAddress.stepHeader"/></h2>
				</div>
				<div class="item_container">
					<div class="left item_container">
						<p><spring:theme code="checkout.multi.deliveryAddress.selectAddressMessage"/></p>
					</div>
					<div class="right item_container">
						<ycommerce:testId code="chooseDeliveryAddress_addNewAddress_button">
							<a href="add-delivery-address">
								<button class="neutral right" type="submit">
									<spring:theme code="checkout.multi.deliveryAddress.addAddress" text="Add new address"/>
								</button>
							</a>
						</ycommerce:testId>
					</div>
					<multi-checkout:deliveryAddressSelector deliveryAddresses="${deliveryAddresses}" selectedAddressId="${selectedDeliveryAddressId}" />
				</div>
			</div>
		</div>	
			
		<c:if test="${not empty selectedDeliveryAddressId}">
			<div class="span-24 checkout-continue">
				<ycommerce:testId code="chooseDeliveryAddress_continue_link">
					<a href="${chooseDeliveryMethodUrl}" class="positive right btn_add">
						<spring:theme code="checkout.multi.deliveryAddress.continue"/>
					</a>
				</ycommerce:testId>
			</div>
		</c:if>
			
		<div class="checkout-cart-details">
			<multi-checkout:checkoutOrderDetails cartData="${cartData}"/>
		</div>
		
	</div>
	
	<!-- telco changes -->
	<!-- <cms:slot var="feature" contentSlot="${slots.SideContent}"><cms:component component="${feature}"/></cms:slot> -->
	
</div>
</template:page>