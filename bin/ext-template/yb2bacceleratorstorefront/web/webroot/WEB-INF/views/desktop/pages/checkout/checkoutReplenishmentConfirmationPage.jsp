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
		<div class="repl_top_cont_btn">
			<a href="${request.contextPath}" class="button positive right">Continue Shopping</a>
		</div>
		<div class="orderHead">
				<div class="headline"><spring:theme code="order.replenishment.confirmation"/></div>
				<div><spring:theme code="order.replenishment.thankYou"/></div>
				<div><spring:theme code="order.replenishment.confirmation.number" arguments="${orderData.jobCode}"/></div>
		</div>
					
		<div class="orderBoxes clearfix">
			<order:replenishmentOrderDetailsItem order="${orderData}"/>
			
			<div class="replenishment-confiramtion-details">
				<div class="span-6 re_schedule">
					<div class="orderBox">
						<div class="headline">
							<spring:theme code="order.replenishment.schedule.title" text="Your replenishment schedule"/>
						</div>
						<div class="left">
							${orderData.triggerData.displayTimeTable}
						</div>
					</div>
				</div>
				<order:deliveryAddressItem order="${orderData}"/>
				<order:paymentMethodItem order="${orderData}"/>
			</div>
			
		</div>
		<order:replenishmentOrderTotalsItem order="${orderData}" containerCSS="positive"/>
		
		<div class="span-24">
			<spring:url value="${continueUrl}" var="continueShoppingUrl"/>
			<spring:url value="${scheduleUrl}" var="scheduleDetailsUrl"/>

			<form action="#" method="get">
				<button type="submit" class="form left"
						onclick="window.location = '${scheduleDetailsUrl}'; return false">
					<spring:theme text="Schedule Order Details" code="cart.page.continue.scheduleurl"/>
				</button>
			</form>
		</div>
		<div>
			<a href="${request.contextPath}" class="button positive right">Continue Shopping</a>
		</div>
	</div>
	
	
</template:page>
