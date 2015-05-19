<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="${cmsPage.label}"/>
	
	<div class="column accountContentPane clearfix orderList">
		
		<order:quoteOrderStatusDecisionItem quoteOrderForm="${quoteOrderDecisionForm}" orderData ="${orderData}" orderHistoryEntries="${orderHistoryEntryData}"/>
		
		<div class="span-19 delivery_stages">
			<div class="span-6">
				<order:paymentMethodItem order="${orderData}"/>	
			</div>
			<div class="span-6">
				<order:deliveryAddressItem order="${orderData}"/>	
			</div>
			<div class="span-6 last">
				<order:deliveryMethodItem order="${orderData}"/>
			</div>
		</div>
			
		<div class="span-19">
			<order:orderDetailsItem order="${orderData}" isOrderDetailsPage="true"/>
			<div class="span-9 left">
				<order:receivedPromotions order="${orderData}"/>
			</div>
			<c:if test="${orderData.triggerData ne null}">
				<order:replenishmentScheduleInformation order="${orderData}"/>
			</c:if>
			<div class="span-8 last right">
				<order:orderTotalsItem order="${orderData}"/>
			</div>
			<div class="span-19 last">
				<order:reorderButton order="${orderData}"/>
			</div>
		</div>
	</div>
	
</template:page>
