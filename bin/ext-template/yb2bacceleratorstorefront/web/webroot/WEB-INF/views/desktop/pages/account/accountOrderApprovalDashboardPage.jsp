<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="approval-dashboard" />
	
	<div class="column accountContentPane clearfix orderList approval-dashboard">
		<div class="headline">
			<spring:theme code="text.account.orderApprovalDashboard" text="Order Approval Dashboard"/>
		</div>
		<div class="span-19">
		<c:choose>
				<c:when test="${not empty searchPageData.results}">
				<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-account/approval-dashboard?sort=${searchPageData.pagination.sort}" msgKey="text.account.orderHistory.page" numberPagesShown="${numberPagesShown}"/>

				<form>
					<table id="order_history" class="orderListTable">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.account.orderApprovalDashBoard.orderNumber" text="Order Number"/></th>
								<th id="header2"><spring:theme code="text.account.order.purchase" text="Purchaser"/></th>
								<th id="header3"><spring:theme code="text.account.orderApprovalDashBoard.purchaseOrderNumber" text="P.O.No"/></th>
								<th id="header4"><spring:theme code="text.account.orderApprovalDashBoard.orderCreated" text="Order Created"/></th>
								<th id="header5"><spring:theme code="text.account.orderApprovalDashBoard.orderStatus" text="Order Status"/></th>
								<th id="header6"><spring:theme code="text.account.orderApprovalDashBoard.actions" text="Actions"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${searchPageData.results}" var="order">
								<tr>
									<td headers="header1">
										<ycommerce:testId code="orderApprovalDashboard_orderNumber_link">
											<a href="orderApprovalDetails/${order.workflowActionModelCode}">${order.b2bOrderData.code}</a>
										</ycommerce:testId>
									</td>
									<td headers="header2">
										<ycommerce:testId code="orderApprovalDashboard_orderpurchaser_link">
											<p>${order.b2bOrderData.b2bCustomerData.name}</p>
										</ycommerce:testId>
									</td>
									<td headers="header3">
										<ycommerce:testId code="orderApprovalDashboard_purchaseOrderNumber_label">
											<p>${order.b2bOrderData.purchaseOrderNumber}</p>
										</ycommerce:testId>
									</td>
									<td headers="header4">
										<ycommerce:testId code="orderApprovalDashboard_orderStatus_label">
											<p>${order.b2bOrderData.created}</p>
										</ycommerce:testId>
									</td>
									<td headers="header5">
										<ycommerce:testId code="orderApprovalDashboard_orderStatus_label">
											<p><spring:theme code="text.account.order.status.display.${order.b2bOrderData.statusDisplay}"/></p>
										</ycommerce:testId>
									</td>
									<td headers="header6">
										<ycommerce:testId code="orderApprovalDashboard_Actions_links">
											<ul class="updates">
												<li><a href="orderApprovalDetails/${order.workflowActionModelCode}"><spring:theme code="text.view" text="View"/></a></li>
											</ul>
										</ycommerce:testId>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-account/approval-dashboard?sort=${searchPageData.pagination.sort}" msgKey="text.account.orderHistory.page" numberPagesShown="${numberPagesShown}"/>
			</c:when>
			<c:when test="${empty searchPageData.results}">
				<p><spring:theme code="text.account.orderHistory.noOrders" text="You have no orders"/></p>
			</c:when>
			</c:choose>
		</div>

	</div>
</template:page>
