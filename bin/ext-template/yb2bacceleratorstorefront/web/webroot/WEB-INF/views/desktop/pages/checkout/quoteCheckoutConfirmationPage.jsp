<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!--  		<div>
			<a href="${request.contextPath}" class="button positive right">Continue Shopping</a>
		</div>
-->		<div class="orderHead">
			<c:choose>
				<c:when test="${orderData.status == 'CANCELLED'}">
					<div class="headline"><spring:theme code="order.quoteRequest.cancelled.confirmation"  arguments="${orderData.code}"/></div>
				</c:when>
				<c:otherwise>
					<div class="headline"><spring:theme code="order.quoteRequest.confirmation"/></div>
					<div><spring:theme code="order.quoteRequest.thankYou"/></div>
				</c:otherwise>
			</c:choose>
		</div>&nbsp;
		
		<div class="span-23 orderBox_top">
			<div class="headline">Order Details</div>
			<div class="span-23">
				<spring:theme code="text.account.order.orderNumber" arguments="${orderData.code}"/><br />
				<spring:theme code="text.account.order.orderPlaced" arguments="${orderData.created}"/><br />
				<c:if test="${not empty orderData.statusDisplay}">
					<spring:theme code="text.account.order.status.display.${orderData.statusDisplay}" var="orderStatus"/>
					<spring:theme code="text.account.order.orderStatus" arguments="${orderStatus}"/><br />
				</c:if>	
			</div>	
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
		<div class="span-16 quote_pos">&nbsp;
			<c:if test="${not empty orderData.b2BComment && orderData.status=='REJECTED_QUOTE' || orderData.status=='PENDING_QUOTE'}">
				<div class="headline"><spring:theme code="order.quoteReason"/></div>
				<ul>
					<li>${orderData.b2BComment.comment}</li>
				</ul>
			</c:if>		
		</div>		
	</div>
	
	
	

</template:page>
