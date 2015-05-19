<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
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
	<nav:accountNav selected="orders" />
	<div class="span-20 last">
		<div class="span-20 last delivery_stages">
			<div class="span-5">
				<order:deliveryAddressItem order="${orderData}"/>
			</div>
			<div class="span-5">
				<order:deliveryMethodItem order="${orderData}"/>
			</div>
			<div class="span-10 last">
				<c:if test="${not empty orderData.paymentInfo}">
					<order:paymentMethodItem order="${orderData}"/>
				</c:if>
			</div>
		</div>
		<div class="span-20 last">
			<order:orderDetailsItem order="${orderData}"/>
			<div class="span-12">
				<order:receivedPromotions order="${orderData}"/>
			</div>
			<div class="span-8 last right">
				<order:orderTotalsItem order="${orderData}"/>
			</div>
		</div>
	</div>
</template:page>