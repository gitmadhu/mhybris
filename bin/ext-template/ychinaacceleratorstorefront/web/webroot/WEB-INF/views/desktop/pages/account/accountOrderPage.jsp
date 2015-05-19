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
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	
	<div class="myAccount">
		<div class="myAccount2 clearfix">
	<nav:accountNav selected="orders" />

	
	<div class="myOrderDetail">
		<h3><spring:theme code="text.account.order.orderDetails" /></h3>
		<div class="myOrderDetail2 clearfix">
			<div class="myOrderDetail2_l"><spring:theme code="text.account.order.orderNumber" arguments="${orderData.code}"/></div>
			<div class="myOrderDetail2_r">
				<div class="myOrderDetail2_r_l"><spring:theme code="text.account.order.orderStatus" /><order:OrderStatusItem status="${orderData.status}"/></div>
				<c:choose>
					<c:when test="${empty orderData.status or orderData.status eq 'AWAITING_PAYMENT'}">
				<a target="_blank" href="${contextPath}/alipay/requestController/${orderData.code}" class="myOrderDetail2_r_pay"><spring:theme code="text.account.order.payNow" /></a>
				<a href="${contextPath}/my-account/cancelOrder/${orderData.code}" class="myOrderDetail2_r_cancel"><spring:theme code="text.account.order.cancelNow" /></a>
					</c:when>
				</c:choose>
			</div>
		</div>
		<c:choose>
			<c:when test="${orderData.status eq 'PAYMENT_CAPTURED'}">
				<c:set var="statusClass" value="detail_status1" />
			</c:when>
			<c:when test="${orderData.status eq 'IN_DELIVERY'}">
				<c:set var="statusClass" value="detail_status2" />
			</c:when>
			<c:when test="${orderData.status eq 'COMPLETED'}">
				<c:set var="statusClass" value="detail_status3" />
			</c:when>
			<c:otherwise>
				<c:set var="statusClass" value="detail_status0" />
			</c:otherwise>
		</c:choose>
		<div class="myOrderDetail2_status ${statusClass}">
			<div class="status1">
				<p class="status_txt"><spring:theme code="text.account.order.statusAction.display.created" /></p>
				<p class="status_data">
					<order:statusUpdateTime orderStatus="CREATED" order="${orderData}" />
				</p>
			</div>
			<div class="status2">
				<p class="status_txt"><spring:theme code="text.account.order.statusAction.display.checked" /></p>
				<p class="status_data">
					<order:statusUpdateTime orderStatus="PAYMENT_CAPTURED" order="${orderData}" />
				</p>
			</div>
			<div class="status3">
				<p class="status_txt"><spring:theme code="text.account.order.statusAction.display.delivered" /></p>
				<p class="status_data">
					<order:statusUpdateTime orderStatus="DELIEVERED" order="${orderData}" />
				</p>
			</div>
			<div class="status4">
				<p class="status_txt"><spring:theme code="text.account.order.statusAction.display.completed" /></p>
				<p class="status_data">
					<order:statusUpdateTime orderStatus="COMPLETED" order="${orderData}" />
				</p>
			</div>
		</div>
		<div class="myOrderDetail2_msg">
			<h4><spring:theme code="text.account.order.orderInfo" /></h4>
			<dl>
				<dt><p><spring:theme code="text.account.order.recieverInfo" /></p></dt>
				<dd>${fn:escapeXml(orderData.deliveryAddress.lastName)}${fn:escapeXml(orderData.deliveryAddress.firstName)}, ${fn:escapeXml(orderData.deliveryAddress.country.name)}, ${fn:escapeXml(orderData.deliveryAddress.region.name)}, ${fn:escapeXml(orderData.deliveryAddress.city)}, ${fn:escapeXml(orderData.deliveryAddress.cityDistrict)},${fn:escapeXml(orderData.deliveryAddress.line1)}${fn:escapeXml(orderData.deliveryAddress.line2)}, ${fn:escapeXml(orderData.deliveryAddress.postalCode)}, ${fn:escapeXml(orderData.deliveryAddress.cellphone)}</dd>
				<dt><spring:theme code="text.account.order.delieverMethod" /></dt>
				<dd><p><spring:theme code="text.checkout.deliveryTimeSlot.${orderData.deliveryTimeslot}" text=""/></p></dd>
				<dt><spring:theme code="text.account.order.paymentMode" /></dt>
				<dd><p><spring:theme code="text.alipay" />(${orderData.paymentMode.name})</p></dd>
				<dt><spring:theme code="text.account.order.invoiceInfo" /></dt>
				<dd>
					<c:choose>
						<c:when test="${ empty orderData.invoice }">
					<p><spring:theme code="checkout.order.settle.not.require.facture" /></p>
						</c:when>
						<c:otherwise>
					<p><spring:theme code="text.account.order.invoiceInfo.title" /><spring:theme code="text.account.order.invoiceInfo.title.${orderData.invoice.invoicedTitle}" /><c:if test="${not empty orderData.invoice.invoicedName}">(${orderData.invoice.invoicedName})</c:if></p>
					<p><spring:theme code="text.account.order.invoiceInfo.category" /><spring:theme code="text.account.order.invoiceInfo.category.${orderData.invoice.invoicedCategory}" /></p>
						</c:otherwise>
					</c:choose>
				</dd>
			</dl>
		</div>
		<div class="myOrderDetail2_order">
			<p class="myOrderDetail2_order_title"><spring:theme code="text.account.order.itemList" /></p>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th width="102"></th>
						<th></th>
						<th><spring:theme code="basket.page.quantity"/></th>
						<th><spring:theme code="basket.page.itemPrice"/></th>
						<th><spring:theme code="basket.page.total"/></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${orderData.entries}" var="entry">
					<c:url value="${entry.product.url}" var="productUrl"/>
				<tr>
					<td>
						<div class="myOrderDetail2_productPic"><a href="${productUrl}"><product:productPrimaryImage product="${entry.product}" format="thumbnail"/></a></div>
					</td>
					<td><p><a href="${productUrl}">${entry.product.name}</a></p></td>
					<td>${entry.quantity}</td>
					<td><format:price priceData="${entry.basePrice}" displayFreeForZero="true"/></td>
					<td><strong><format:price priceData="${entry.totalPrice}" displayFreeForZero="true"/></strong></td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="myOrderDetail2_order_price clearfix">
				<dl class="clearfix">
					<dt><spring:theme code="text.account.order.subtotal" text="Subtotal:"/></dt>
					<dd><format:price priceData="${orderData.subTotal}"/></dd>
					<dt><spring:theme code="text.account.order.savings" text="Savings:"/></dt>
					<dd><format:price priceData="${orderData.totalDiscounts}"/></dd>
					<dt><spring:theme code="text.account.order.delivery" text="Delivery:"/></dt>
					<dd><format:price priceData="${orderData.deliveryCost}" displayFreeForZero="true"/></dd>
					<dt><spring:theme code="text.account.order.total" text="Total:"/></dt>
					<dd><strong>
						<c:choose>
							<c:when test="${order.net}">
								<format:price priceData="${orderData.totalPriceWithTax}"/>
							</c:when>
							<c:otherwise>
								<format:price priceData="${orderData.totalPrice}"/>
							</c:otherwise>
						</c:choose>
					</strong></dd>
				</dl>
			</div>
		</div>
		
	</div>
		</div>
	</div>	
	
</template:page>

