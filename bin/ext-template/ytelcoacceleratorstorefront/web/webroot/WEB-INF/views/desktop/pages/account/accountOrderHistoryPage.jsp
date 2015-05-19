<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="orders" />
	<div class="span-20 last cust_acc-page">
		<div class="span-20 wide-content-slot advert">
			<cms:slot var="feature" contentSlot="${slots['TopContent']}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
	
		<div class="item_container_holder orderHistory">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.orderHistory" text="Order History"/></h2>
			</div>
			<div class="item_container">
				<c:if test="${not empty searchPageData.results}">
					<p><spring:theme code="text.account.orderHistory.viewOrders" text="View your orders"/></p>
					
					<table class="account-table">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.account.orderHistory.orderNumber" text="Order Number"/></th>
								<th id="header2"><spring:theme code="text.account.orderHistory.orderStatus" text="Order Status"/></th>
								<th id="header3"><spring:theme code="text.account.orderHistory.datePlaced" text="Date Placed"/></th>
								<th id="header4"><spring:theme code="text.account.orderHistory.actions" text="Actions"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${searchPageData.results}" var="order">
							<c:url value="/my-account/order/${order.code}" var="myAccountOrderDetailsUrl"/>
							<tr>
								<td headers="header1">
									<ycommerce:testId code="orderHistory_orderNumber_link">
										<a href="${myAccountOrderDetailsUrl}">${order.code}</a>
									</ycommerce:testId>
								</td>
								<td headers="header2" class="background">
									<ycommerce:testId code="orderHistory_orderStatus_label">
										<p class="capitalize">${order.statusDisplay}</p>
									</ycommerce:testId>
								</td>
								<td headers="header3">
									<ycommerce:testId code="orderHistory_orderDate_label">
										<fmt:formatDate value="${order.placed}" dateStyle="long" timeStyle="short" type="both"/>
									</ycommerce:testId>
								</td>

								<td headers="header4" class="actions background">
									<ul>
										<ycommerce:testId code="orderHistory_Actions_links">
											<li>
												<a href="${myAccountOrderDetailsUrl}" class="function_btn btn_add"><spring:theme code="text.account.orderHistory.viewDetails" text="View Details"/></a>
											</li>
										</ycommerce:testId>
									</ul>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<c:if test="${empty searchPageData.results}">
					<p><spring:theme code="text.account.orderHistory.noOrders" text="You have no orders"/></p>
				</c:if>
			</div>
		</div>
	</div>
</template:page>
