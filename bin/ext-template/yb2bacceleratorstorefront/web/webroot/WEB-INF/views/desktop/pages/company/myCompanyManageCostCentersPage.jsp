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
<spring:url value="/my-company/organization-management/manage-costcenters/add" var="addCostCenterDetailsUrl"/>

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
			<div class="headline"><spring:theme code="text.company.manage.costcenters.title" text="All Cost Centers"/></div>
			<div class="right last">
						<ycommerce:testId code="CostCenter_AddCostCenter_button">
						<a href="${addCostCenterDetailsUrl}" class="button add" ><spring:theme code="text.company.costCenter.addButton.displayName" /></a>
						</ycommerce:testId>
			</div>

				<spring:theme code="text.company.manage.costcenters.subtitle" text="" arguments="${b2bStore}"/>
				<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-company/organization-management/manage-costcenters?sort=${searchPageData.pagination.sort}" msgKey="text.company.costCenter.page" numberPagesShown="${numberPagesShown}"/>
					<table id="order_history" class="orderListTable">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.company.column.id.name" text="ID"/></th>
								<th id="header2"><spring:theme code="text.company.column.name.name" text="Name"/></th>
								<th id="header3"><spring:theme code="text.company.column.parentUnit.name" text="Parent Unit"/></th>
								<th id="header4"><spring:theme code="text.company.costCenter.currency.title" text="Currency"/></th>
								<th id="header5"><spring:theme code="text.company.status.title" text="Status"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${searchPageData.results}" var="costCenter">
								<spring:url value="/my-company/organization-management/manage-costcenters/view/" var="viewCostCenterDetailsUrl">
									<spring:param name="costCenterCode" value="${costCenter.code}"/>
								</spring:url>
								<spring:url value="/my-company/organization-management/manage-units/details/" var="viewUnitDetailsUrl">
									<spring:param name="unit" value="${costCenter.unit.uid}"/>
								</spring:url>
								<tr>
									<td headers="header1">
										<ycommerce:testId code="costCenter_code_link">
											<a href="${viewCostCenterDetailsUrl}">${costCenter.code}</a>
										</ycommerce:testId>
									</td>
									<td headers="header2">
										<ycommerce:testId code="costCenter_name_label">
											<p>${costCenter.name}</p>
										</ycommerce:testId>
									</td>
									<td headers="header3">
										<ycommerce:testId code="costCenter_b2bunit_label">
											<p>
												<a href="${viewUnitDetailsUrl}">${costCenter.unit.name}</a>
											</p>
										</ycommerce:testId>
									</td>
									<td headers="header4">
										<ycommerce:testId code="costCenter_currency_label">
											<p>${costCenter.currency.isocode}</p>
										</ycommerce:testId>
									</td>
									<td headers="header4">
										<ycommerce:testId code="costCenter_status_label">
											<p>
												<spring:theme code="text.company.status.active.${costCenter.active}" />
											</p>
										</ycommerce:testId>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				<nav:pagination top="false"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="/my-company/organization-management/manage-costcenters?sort=${searchPageData.pagination.sort}" msgKey="text.company.costCenter.page" numberPagesShown="${numberPagesShown}"/>
				<c:if test="${empty searchPageData.results}">
					<p><spring:theme code="text.company.noentries" text="No entries" /></p>
				</c:if>
	
	</div>
</template:page>
