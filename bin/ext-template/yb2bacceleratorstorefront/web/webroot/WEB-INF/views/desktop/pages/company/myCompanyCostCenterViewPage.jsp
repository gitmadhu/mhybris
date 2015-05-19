<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb"%>


<c:if test="${empty editUrl}">
	<spring:url
		value="/my-company/organization-management/manage-costcenters/edit"
		var="editUrl">
		<spring:param name="costCenterCode" value="${b2bCostCenter.code}" />
	</spring:url>
</c:if>
<spring:url
	value="/my-company/organization-management/manage-costcenters/selectBudget"
	var="selectBudgetsForCostcenterUrl">
	<spring:param name="costCenterCode" value="${b2bCostCenter.code}" />
</spring:url>
<spring:url
	value="/my-company/organization-management/manage-costcenters/disable"
	var="disableCostCenterUrl">
	<spring:param name="costCenterCode" value="${b2bCostCenter.code}" />
</spring:url>
<spring:url
	value="/my-company/organization-management/manage-costcenters/enable"
	var="enableCostCenterUrl">
	<spring:param name="costCenterCode" value="${b2bCostCenter.code}" />
</spring:url>
<spring:url
	value="/my-company/organization-management/manage-costcenters/unitDetails"
	var="viewCostCenterUnitUrl">
	<spring:param name="costCenterCode" value="${b2bCostCenter.code}" />
	<spring:param name="unit" value="${b2bCostCenter.unit.uid}" />
</spring:url>

<template:page pageTitle="${pageTitle}">



	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}" />
	</div>
	<div id="globalMessages">
		<common:globalMessages />
	</div>
	<nav:myCompanyNav selected="costCenters" />
	<div class="column companyContentPane clearfix orderList">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>		
		<div class="headline"><spring:theme code="text.company.costCenter.viewDetails.label" text="View Cost Center: {0}" arguments="${b2bCostCenter.name}" /></div>
			<div class="right">
				<a href="${editUrl}" class="button edit"><spring:theme code="text.company.costCenter.button.displayName" /></a>
				<c:choose>
					<c:when test="${b2bCostCenter.active && empty accErrorMsgs}">
						<ycommerce:testId	code="costCenter_DisableCC_button">
								<a href="${disableCostCenterUrl}" class="button disable"><spring:theme code="text.company.costCenter.disable.button" /></a>
						</ycommerce:testId>
					</c:when>
					<c:otherwise>
						<ycommerce:testId code="costCenter_EnableCC_button">
							<a href="${enableCostCenterUrl}" class="button enable"><spring:theme code="text.company.costCenter.enable.button" /></a>
						</ycommerce:testId>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="description"><spring:theme code="text.company.manage.costcenters.subtitle"	arguments="${b2bStore}" /></div>
			
				<table class="table_budget orderListTable">
					<tr>
						<td><spring:theme code="text.company.costCenter.id.title"
								text="Cost Center ID" />:</td>
						<td>${b2bCostCenter.code}</td>
					</tr>
					<tr>
						<td><spring:theme code="text.company.costCenter.name.title"
								text="Cost Center Name" />:</td>
						<td>${b2bCostCenter.name}</td>
					</tr>
					<tr>
						<td><spring:theme code="text.company.costCenter.unit.title"
								text="Parent business unit" />:</td>
						<td><a href="${viewCostCenterUnitUrl}">${b2bCostCenter.unit.uid}</a></td>
					</tr>
					<tr>
						<td><spring:theme
								code="text.company.costCenter.currency.title" text="Currency" />:</td>
						<td>${b2bCostCenter.currency.isocode}</td>
					</tr>
				</table>



				<div class="headline"><spring:theme code="text.company.manage.costcenter.budget.title" text="Budgets" /></div>
				<div class="right">
					<a href="${selectBudgetsForCostcenterUrl}" class="button edit"><spring:theme code="text.company.costCenter.button.displayName" /></a>
				</div>
						
							<spring:theme
								code="text.company.manage.costcenters.view.budgets.subtitle" />
						
						
							<c:choose>
								<c:when test="${not empty b2bCostCenter.b2bBudgetData}">
									<table class="orderListTable">
										<thead>
											<tr>
												<th><span><spring:theme
															code="text.company.budget.id" text="ID" /> </span></th>
												<th><span><spring:theme
															code="text.company.budget.name" text="Budget Name" /> </span></th>
												<th><span><spring:theme
															code="text.company.budget.start" text="Start" /> </span></th>
												<th><span><spring:theme
															code="text.company.budget.currency" text="Currency" /> </span></th>
												<th><span><spring:theme
															code="text.company.budget.amount" text="Budget Amount" />
												</span></th>
											</tr>
										</thead>
										<tbody>


											<c:forEach items="${b2bCostCenter.b2bBudgetData}"
												var="b2bBudget">
												<tr>
													<spring:url
														value="/my-company/organization-management/manage-budgets/view"
														var="viewBudgetUrl">
														<spring:param name="budgetCode" value="${b2bBudget.code}" />
													</spring:url>
													<td><ycommerce:testId code="test_budget_id_link">
															<a href="${viewBudgetUrl}">${b2bBudget.code}</a>
														</ycommerce:testId></td>
													<td>${b2bBudget.name}</td>
													<td><fmt:formatDate value="${b2bBudget.startDate}" />
													</td>
													<td>${b2bBudget.currency.isocode}</td>
													<td><fmt:formatNumber value="${b2bBudget.budget}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:when>
								<c:otherwise>
									<spring:theme code="text.company.budget.noBudgetMessage" />
								</c:otherwise>
							</c:choose>
					
				
			
		
				<spring:theme code="text.company.costCenter.enabled.title"	text="Cost Center Enables/disabled" /> :
				<c:choose>
					<c:when test="${b2bCostCenter.active}">
						<spring:theme code="text.company.on" text="ON" />
					</c:when>
					<c:otherwise>
						<spring:theme code="text.company.off" text="OFF" />
					</c:otherwise>
				</c:choose>
			
	</div>
</template:page>
