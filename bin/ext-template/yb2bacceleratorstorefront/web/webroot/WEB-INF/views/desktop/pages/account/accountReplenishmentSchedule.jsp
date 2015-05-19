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
	<nav:accountNav selected="${cmsPage.label}" />
	<div class="span-20 last">
		<div class="item_container_holder">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
			</div>
			<div class="item_container my-replenishments orderList accountContentPane">
				<div class="headline">
					<spring:theme code="text.account.myReplenishment" text="My Replenishment Orders"/>
				</div>
				<c:if test="${not empty searchPageData.results}">
					<div class="description">
						<spring:theme code="text.account.replenishment.manageReplenishmentSchedule" text="Manage Your Replenishment Schedule"/>
					</div>
					<nav:pagination top="true"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-account/my-replenishment?sort=${searchPageData.pagination.sort}" msgKey="text.account.replenishment.page" numberPagesShown="${numberPagesShown}"/>
					<form>
						<table id="order_history" class="orderListTable">
							<thead>
								<tr>
									<th id="header1"><spring:theme code="text.account.replenishment.replenishmentNumber" text="Replenishment No"/></th>
									<th id="header2"><spring:theme code="text.account.replenishment.purchaseOrderNumber" text="P.O.No"/></th>
									<th id="header3"><spring:theme code="text.account.replenishment.total" text="Est. Total"/></th>
									<th id="header4"><spring:theme code="text.account.replenishment.startDate" text="Start"/></th>
									<th id="header5"><spring:theme code="text.account.replenishment.Schedule" text="Schedule"/></th>
									<th id="header6"><spring:theme code="text.account.replenishment.nextOrderDate" text="Next Order Date"/></th>
									<th id="header7"><spring:theme code="text.account.replenishment.actions" text="Actions"/></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${searchPageData.results}" var="replenishment">
									<c:url value="/my-account/my-replenishment/${replenishment.jobCode}" var="replenishmentJobLink"/>
									<tr>
										<td headers="header1">
											<ycommerce:testId code="replenishment_jobcode_link">
												<a href="${replenishmentJobLink}">${replenishment.jobCode} </a>
											</ycommerce:testId>
										</td>
										<td headers="header2">
											<ycommerce:testId code="replenishment_purchaseOrderNumber_label">
												<p>${replenishment.purchaseOrderNumber}</p>
											</ycommerce:testId>
										</td>
										<td headers="header3">
											<ycommerce:testId code="replenishment_estTotal_label">
												<p>${replenishment.totalPrice.formattedValue}</p>
											</ycommerce:testId>
										</td>
										<td headers="header4">
											<ycommerce:testId code="replenishment_activationTime_label">
											<p><fmt:formatDate value="${replenishment.firstOrderDate}" dateStyle="medium" /></p>
											</ycommerce:testId>
										</td>
										<td headers="header5">
											<ycommerce:testId code="orderHistory_schedule_label">
												<p>${replenishment.triggerData.displayTimeTable}</p>
											</ycommerce:testId>
										</td>
										<td headers="header6">
											<ycommerce:testId code="replenishment_nextActivationTime_label">
												<c:if test="${replenishment.active}">
													<p><fmt:formatDate value="${replenishment.triggerData.activationTime}" dateStyle="medium" /></p>
												</c:if>
												<c:if test="${not replenishment.active}">
													<spring:theme code="text.account.replenishment.canceled" text="Canceled"/>
												</c:if>
											</ycommerce:testId>
										</td>
										<td headers="header7">
											<ycommerce:testId code="replenishment_Actions_links">
												<c:if test="${replenishment.active}">
												<ul class="updates1">
													<spring:url value="/my-account/my-replenishment/confirmation/cancel/${replenishment.jobCode}/"
																			var="cancelReplenishmentUrl"/>
													<li><a href="${cancelReplenishmentUrl}">
														   <spring:theme code="text.endNow" text="End Now"/></a>
													</li>
												</ul>
												</c:if>
											</ycommerce:testId>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</form>
					<nav:pagination top="false"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-account/my-replenishment?sort=${searchPageData.pagination.sort}" msgKey="text.account.replenishment.page" numberPagesShown="${numberPagesShown}"/>
				</c:if>
				<c:if test="${empty searchPageData.results}">
					<p><spring:theme code="text.account.replenishment.noReplenishment" text="You have no replenishment orders scheduled"/></p>
				</c:if>
			</div>
		</div>
	</div>
</template:page>
