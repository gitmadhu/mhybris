<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="${cmsPage.label}"/>

	<div class="column accountContentPane clearfix orderList replenishment-detail">

		<order:replenishmentOrderDetailsItem order="${scheduleData}"/>
		
		<div class="span-19 delivery_stages">
			
			<div class="span-6">
				<div class="orderBox">
					<div class="headline">
						<spring:theme code="order.replenishment.schedule.title" text="Your replenishment schedule"/>
					</div>
					<div class="item_container">
						${scheduleData.triggerData.displayTimeTable}
					</div>
				</div>
			</div>

			<div class="span-7">
				<order:paymentMethodItem order="${scheduleData}"/>
			</div>

			<div class="span-6 last">
				<order:deliveryAddressItem order="${scheduleData}"/>
			</div>
		</div>
		
		<c:if test="${scheduleData.active}">
			<spring:url value="/my-account/my-replenishment/detail/confirmation/cancel/${scheduleData.jobCode}/" var="cancelReplenishmentUrl"/>
			<div class="span-8">
				<a href="${cancelReplenishmentUrl}">
					<ycommerce:testId code="replenishmentHistory_cancel_link">
						<button class="positive">
							<spring:theme code="text.account.replenishment.cancel.button" text="Cancel Replenishment"/>
						</button>
					</ycommerce:testId>
				</a>
			</div>
		</c:if>
		
		<div class="span-8 right last">
			<order:replenishmentOrderTotalsItem order="${scheduleData}" containerCSS="positive"/>
		</div>
		

		<div class="span-19 delivery_stages">
			<div class="headline">
				<spring:theme code="text.account.replenishment.orders" text="Replenishment Orders"/>
			</div>
			<c:if test="${not empty searchPageData.results}">
				<div class="description">
					<spring:theme code="text.account.replenishment.viewReplenishmentOrders" text="View your replenishment orders"/>
				</div>
				<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-account/my-replenishment/${scheduleData.jobCode}?sort=${searchPageData.pagination.sort}&show=${param.show}" msgKey="text.account.replenishment.page" numberPagesShown="${numberPagesShown}"/>

				<form>
					<table id="order_history" class="orderListTable">
						<thead>
						<tr>
							<th id="header1">
								<spring:theme code="text.account.replenishment.orderNumber"
											  text="Order Number"/>
							</th>
							<th id="header2">
								<spring:theme code="text.account.replenishment.orderStatus"
											  text="Order Status"/>
							</th>
							<th id="header3">
								<spring:theme code="text.account.replenishment.purchaseOrderNumber"
											  text="P.O.No"/>
							</th>
							<th id="header4">
								<spring:theme code="text.account.replenishment.datePlaced" text="Date Placed
								"/>
							</th>
							<th id="header5">
								<spring:theme code="text.account.replenishment.actions" text="Actions"/>
							</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${searchPageData.results}" var="order">
							<c:url value="/my-account/my-replenishment/${scheduleData.jobCode}/${order.code}" var="replenishmentActionLink"/>
							<tr>
								<td headers="header1">
									<ycommerce:testId code="replenishmentHistory_orderNumber_link">
										<a href="${replenishmentActionLink}">${order.code}</a>
									</ycommerce:testId>
								</td>
								<td headers="header2">
									<ycommerce:testId code="replenishmentHistory_orderStatus_label">
										<p><spring:theme code="text.account.order.status.display.${order.statusDisplay}"/></p>
									</ycommerce:testId>
								</td>
								<td headers="header3">
									<ycommerce:testId code="replenishmentHistory_purchaseOrderNumber_label">
										<p>${order.purchaseOrderNumber}</p>
									</ycommerce:testId>
								</td>
								<td headers="header4">
									<ycommerce:testId code="replenishmentHistory_orderDate_label">
										<p>${order.placed}</p>
									</ycommerce:testId>
								</td>
								<td headers="header5">
									<ycommerce:testId code="replenishmentHistory_Actions_links">
										<ul class="updates">
											<li><a
												href="${replenishmentActionLink}">
												<spring:theme code="text.view" text="View"/>
											</a></li>
										</ul>
									</ycommerce:testId>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</form>
				<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-account/my-replenishment/${scheduleData.jobCode}?sort=${searchPageData.pagination.sort}&show=${param.show}" msgKey="text.account.replenishment.page" numberPagesShown="${numberPagesShown}"/>
			</c:if>
			
			<c:if test="${empty searchPageData.results}">
				<div class="description">
					<spring:theme code="text.account.replenishment.noOrders" text="You have no orders"/>
				</div>
			</c:if>
		</div>
		
	</div>
</template:page>

