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
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company" %>

<spring:theme code="text.company.select.action.label" text="Select" var="selectAction"/>
<spring:theme code="text.company.deselect.action.label" text="Deselect" var="deselectAction"/>
<spring:theme code="text.company.budget.status.disabled" text="Disabled" var="disabled"/>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="costCenters"/>
	<div class="column companyContentPane clearfix orderList">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>			
		<div class="headline"><spring:theme code="text.company.select.budget" text="Edit Related Budgets for Cost Center: {0}" arguments="${param.costCenterCode}"/></div>
		
		
		
				<spring:theme code="text.company.manage.costcenters.edit.budgets.subtitle"/>
				<nav:pagination top="true"  supportShowPaged="${isShowPageAllowed}"
								supportShowAll="${isShowAllAllowed}"
								searchPageData="${searchPageData}"
								searchUrl="/my-company/organization-management/manage-costcenters/selectBudget?costCenterCode=${param.costCenterCode}&sort=${searchPageData.pagination.sort}"
								sortQueryParams="costCenterCode=${param.costCenterCode}"
								msgKey="text.company.budget.page"
								numberPagesShown="${numberPagesShown}"/>
					<table id="order_history" class="orderListTable">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.company.budget.name" text="Budget Name"/></th>
								<th id="header2"><spring:theme code="text.company.budget.start" text="Start"/></th>
								<th id="header3"><spring:theme code="text.company.budget.end" text="End"/></th>
								<th id="header4"><spring:theme code="text.company.budget.currency" text="Currency"/></th>
								<th id="header5"><spring:theme code="text.company.budget.amount" text="Budget Amount"/></th>
								<th id="header6"><spring:theme code="text.company.budget.unit" text="Parent business unit"/></th>
								<th id="header7"><spring:theme code="text.company.budget.actions" text="Actions"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${searchPageData.results}" var="b2bBudget">
								<tr class="${b2bBudget.selected ? 'selected' : ''}" id="row-${ycommerce:normalizedCode(b2bBudget.code)}">
									<td headers="header1">
										<spring:url value="/my-company/organization-management/manage-budgets/view/"
													var="viewBudgetUrl">
											<spring:param name="budgetCode" value="${b2bBudget.code}"/>
										</spring:url>
										<ycommerce:testId code="budget_name_link">
											<a href="${viewBudgetUrl}">${b2bBudget.name}</a>
										</ycommerce:testId>
									</td>
									<td headers="header2">
										<ycommerce:testId code="budget_startDate_label">
											<p><fmt:formatDate value="${b2bBudget.startDate}" /></p>
										</ycommerce:testId>
									</td>
									<td headers="header3">
										<ycommerce:testId code="budget_endDate_label">
											<p><fmt:formatDate value="${b2bBudget.endDate}" /></p>
										</ycommerce:testId>
									</td>
									<td headers="header4">
										<ycommerce:testId code="budget_currency_label">
											<p>${b2bBudget.currency.isocode}</p>
										</ycommerce:testId>
									</td>
									<td headers="header5">
										<ycommerce:testId code="budget_amount_label">
											<p><fmt:formatNumber value="${b2bBudget.budget}" /></p>
										</ycommerce:testId>
									</td>
									<td headers="header6">
										<ycommerce:testId code="budget_unit_label">
											<p>${b2bBudget.unit.name}</p>
										</ycommerce:testId>
									</td>
									<td headers="header7" >
										<ycommerce:testId code="budget_select_link_label">
										<span id="span-${ycommerce:normalizedCode(b2bBudget.code)}">
											<spring:url value="${baseUrl}/budgets/deselect/"
													var="deselectUrl">
												<spring:param name="costCenterCode" value="${param.costCenterCode}"/>
												<spring:param name="budgetCode" value="${b2bBudget.code}"/>
										</spring:url>
												<spring:url value="${baseUrl}/budgets/select/"
													var="selectUrl">
													<spring:param name="costCenterCode" value="${param.costCenterCode}"/>
													<spring:param name="budgetCode" value="${b2bBudget.code}"/>
										</spring:url>
											<c:choose>
												<c:when test="${b2bBudget.selected}">
													${selectAction} | <a href="#" url="${deselectUrl}" class="deselectBudget">${deselectAction}</a>
												</c:when>
												<c:when test="${b2bBudget.active }">
														<a href="#" url="${selectUrl}" class="selectBudget">${selectAction}</a> | ${deselectAction}
												</c:when>
												<c:otherwise>
													${disabled}
												</c:otherwise>
											</c:choose>
										</span>

										</ycommerce:testId>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

				<nav:pagination top="false"  supportShowPaged="${isShowPageAllowed}"
								supportShowAll="${isShowAllAllowed}"
								searchPageData="${searchPageData}"
								searchUrl="/my-company/organization-management/manage-costcenters/selectBudget?costCenterCode=${param.costCenterCode}&sort=${searchPageData.pagination.sort}"
								sortQueryParams="costCenterCode=${param.costCenterCode}"
								msgKey="text.company.budget.page"
								numberPagesShown="${numberPagesShown}"/>
				<c:if test="${empty searchPageData.results}">
					<p><spring:theme code="text.company.noentries" text="No Entries"/></p>
				</c:if>
		<common:back/>
	</div>

	<company:deselectBudgetPopup/>

	<c:url value="${baseUrl}/budgets" var="budgetsActionLink" />
	<script id="enableDisableLinksTemplate" type="text/x-jquery-tmpl">
	{{if active}}
		{{if selected}}
		${selectAction} | <a href="#"
					url="${budgetsActionLink}/deselect/?budgetCode={{= id}}&costCenterCode=${param.costCenterCode}"
					class="deselectBudget">${deselectAction}</a>
		{{else}}
		<a href="#"
			url="${budgetsActionLink}/select/?budgetCode={{= id}}&costCenterCode=${param.costCenterCode}"
			class="selectBudget">${selectAction}</a> | ${deselectAction}
		{{/if}}
		{{else}} ${disabled}
	{{/if}}

	</script>
</template:page>
