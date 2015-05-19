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

<spring:url value="/my-company/organization-management/manage-permissions/add" var="createUrl"/>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="managePermissions"/>
	<div class="column companyContentPane clearfix orderList">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>				
			<div class="headline"><spring:theme code="text.company.${action}.title" text="All Permissions"/></div>
			<div class="right">
				<ycommerce:testId code="Add_New_Permission_button">
					<a href="${createUrl}" class="button add"><spring:theme code="text.company.managePermissions.addButton.displayName" text="Add New" /></a>
				</ycommerce:testId>	
			</div>
			<div class="description"><spring:theme code="text.company.${action}.subtitle" /></div>
			
		
				<nav:pagination top="true"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
								searchUrl="/my-company/organization-management/manage-permissions?sort=${searchPageData.pagination.sort}"
								msgKey="text.company.${action}.page"
								sortQueryParams="user=${param.user}&permission=${param.permission}"
								numberPagesShown="${numberPagesShown}"/>
				<table id="order_history" class="orderListTable">
					<thead>
					<tr>
						<th id="header1">
							<spring:theme code="text.company.column.id.name" text="ID"/>
						</th>
						<th id="header2">
							<spring:theme code="text.company.column.name.name" text="Name"/>
						</th>
						<th id="header3">
							<spring:theme code="text.company.${action}.currency.title" text="Currency"/>
						</th>
						<th id="header4">
							<spring:theme code="text.company.${action}.value.title" text="Value"/>
						</th>
						<th id="header5">
							<spring:theme code="text.company.${action}.timespan.title" text="TimeSpan"/>
						</th>
						<th id="header6">
							<spring:theme code="text.company.column.parentUnit.name" text="Parent Unit"/>
						</th>
						<th id="header7">
							<spring:theme code="text.company.column.status.name" text="Status"/>
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${searchPageData.results}" var="result">
						<spring:url value="/my-company/organization-management/manage-permissions/view" var="viewPermissionDetailsUrl">
								<spring:param name="permissionCode" value="${result.code}"/>
						</spring:url>
						<tr id="row-${result.normalizedId}">
							<td headers="header1">
								<ycommerce:testId code="${action}_name_link">
									<a href="${viewPermissionDetailsUrl}">${result.code}</a>
								</ycommerce:testId>
							</td>
							<td headers="header2">
								<ycommerce:testId code="${action}_type_link">
									${result.b2BPermissionTypeData.name}
								</ycommerce:testId>
							</td>
							
							<td headers="header3">
								<ycommerce:testId code="${action}_currency_link">
									<p>${result.currency.name}</p>
								</ycommerce:testId>
							</td>
							<td headers="header4">
								<ycommerce:testId code="${action}_value_link">
									<p><fmt:formatNumber maxFractionDigits="0" value="${result.value}" /></p>
								</ycommerce:testId>
							</td>
							<td headers="header5">
								<ycommerce:testId code="${action}_timespan_link">
									<p>${result.timeSpan}</p>
								</ycommerce:testId>
							</td>
							<td headers="header6">
								<ycommerce:testId code="${action}_b2bunit_label">
									<p>${result.unit.uid}</p>
								</ycommerce:testId>
							</td>

							<td headers="header7">
								<ycommerce:testId code="${action}_status_label">
									<c:choose>
										<c:when test="${result.active}">
											<spring:theme code="text.company.${action}.status.enabled" text="Enabled"/>
										</c:when>
										<c:otherwise>
											<spring:theme code="text.company.${action}.status.disabled" text="Disabled"/>
										</c:otherwise>
									</c:choose>
								</ycommerce:testId>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>

				<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
								searchUrl="/my-company/organization-management/manage-permissions?sort=${searchPageData.pagination.sort}"
								msgKey="text.company.${action}.page"
								sortQueryParams="user=${param.user}&permission=${param.permission}"
								numberPagesShown="${numberPagesShown}"/>
				<c:if test="${empty searchPageData.results}">
					<p><spring:theme code="text.company.noentries" text="No entries" /></p>
				</c:if>
		
	
	</div>
</template:page>
