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
<spring:url value="/my-company/organization-management/manage-budgets/add" var="addBudgetUrl"/>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="budgets"/>
		<div class="column companyContentPane clearfix orderList">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>
			
				<div class="headline"><spring:theme code="text.company.manage.budget.title" text="All Budgets"/></div>
			
			<div class="right last">			
					<a href="${addBudgetUrl}" class="button add" ><spring:theme code="text.company.budget.createButton.displayName" /></a>	
			</div>
			
		
				<spring:theme code="text.company.manage.budget.subtitle"  arguments="${b2bStore}"/>
				<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-company/organization-management/manage-budgets?sort=${searchPageData.pagination.sort}" msgKey="text.company.budget.page" numberPagesShown="${numberPagesShown}"/>
					<table id="order_history" class="orderListTable">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.company.column.id.name" text="ID"/></th>
								<th id="header2"><spring:theme code="text.company.column.name.name" text="Name"/></th>
								<th id="header3"><spring:theme code="text.company.column.parentUnit.name" text="Parent unit"/></th>
								<th id="header4"><spring:theme code="text.company.manage.units.costCenters" text="Cost Centers"/></th>
								<th id="header5"><spring:theme code="text.company.budget.start" text="Start"/></th>
								<th id="header6"><spring:theme code="text.company.budget.end" text="End"/></th>
								<th id="header7"><spring:theme code="text.company.budget.currency" text="Currency"/></th>
								<th id="header8"><spring:theme code="text.company.budget.amount" text="Budget Amount"/></th>
								<th id="header9"><spring:theme code="text.company.column.status.name" text="Status"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${searchPageData.results}" var="b2bBudget">
								<spring:url value="/my-company/organization-management/manage-budgets/view/" var="viewBudgetDetailsUrl">
									<spring:param name="budgetCode" value="${b2bBudget.code}"/>
								</spring:url>
								<spring:url value="/my-company/organization-management/manage-units/details/" var="unitDetailsUrl">
									<spring:param name="unit" value="${b2bBudget.unit.name}"/>
								</spring:url>
								<tr> 
									<td headers="header1">
										<ycommerce:testId code="budget_id_link">
											<a href="${viewBudgetDetailsUrl}">${b2bBudget.code}</a>
										</ycommerce:testId>
									</td>
									<td headers="header2">
										<ycommerce:testId code="budget_name_link">
											${b2bBudget.name}
										</ycommerce:testId>
									</td>
									<td headers="header3">
										<ycommerce:testId code="budget_unit_label">
											<p><a href="${unitDetailsUrl}">${b2bBudget.unit.name}</a></p>
										</ycommerce:testId>
									</td>
									<td headers="header4">
										<ycommerce:testId code="budget_unit_label">
											<c:forEach items="${b2bBudget.costCenterNames}" var="costCenter">
												<p>${costCenter}</p>
											</c:forEach>
										</ycommerce:testId>
									</td>
									<td headers="header5">
										<ycommerce:testId code="budget_startDate_label">
											<p><fmt:formatDate value="${b2bBudget.startDate}" /></p>
										</ycommerce:testId>
									</td>
									<td headers="header6">
										<ycommerce:testId code="budget_endDate_label">
											<p><fmt:formatDate value="${b2bBudget.endDate}" /></p>
										</ycommerce:testId>
									</td>
									<td headers="header7">
										<ycommerce:testId code="budget_currency_label">
											<p>${b2bBudget.currency.isocode}</p>
										</ycommerce:testId>
									</td>
									<td headers="header8">
										<ycommerce:testId code="budget_amount_label">
											<p><fmt:formatNumber value="${b2bBudget.budget}" /></p>
										</ycommerce:testId>
									</td>
									<td headers="header9">
										<ycommerce:testId code="budget_status_label">
											<c:choose>
												<c:when test="${b2bBudget.active}">
													<spring:theme code="text.company.budget.status.active" text="Active" />
												</c:when>
												<c:otherwise>
													<spring:theme code="text.company.budget.status.disabled" text="Disabled" />
												</c:otherwise>
											</c:choose>
										</ycommerce:testId>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				<nav:pagination top="false"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-company/organization-management/manage-budgets?sort=${searchPageData.pagination.sort}" msgKey="text.company.budget.page" numberPagesShown="${numberPagesShown}"/>
				<c:if test="${empty searchPageData.results}">
					<p><spring:theme code="text.company.noentries" text="No entries" /></p>
				</c:if>
		
		
	</div>
</template:page>
