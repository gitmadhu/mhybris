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

<spring:url value="/my-company/organization-management/manage-usergroups/create" var="createUserGroupUrl"/>
<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="manageUsergroups"/>
	<div class="column companyContentPane clearfix orderList">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>		

			
			<div class="headline"><spring:theme code="text.company.${action}.title" text="All UserGroups"/></div>
			<div class="right">
					<ycommerce:testId code="Usergroup_createNew_button">
						<a href="${createUserGroupUrl}" class="button add"><spring:theme code="text.company.manageUsergroups.newUserGroupButton" text="Create New Usergroup"/></a>
					</ycommerce:testId>
			</div>
			<div class="description"><spring:theme code="text.company.${action}.subtitle" /></div>
	
	
				<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
								searchUrl="/my-company/organization-management/manage-usergroups?sort=$
								{searchPageData.pagination.sort}"
								sortQueryParams="user=${param.user}"
								msgKey="text.company.${action}.page"
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
							<spring:theme code="text.company.column.parentUnit.name" text="Parent unit"/>
						</th>
						<th id="header4"><spring:theme code="text.company.status.title" text="Status"/></th>

					</tr>
					</thead>
					<tbody>
					<c:forEach items="${searchPageData.results}" var="group">
						<tr id="row-${result.normalizedId}">
							<td headers="header1">
								<spring:url
									value="/my-company/organization-management/manage-usergroups/details/"
									var="viewUrl">
									<spring:param name="usergroup" value="${group.uid}"/>
								</spring:url>
								<spring:url
									value="/my-company/organization-management/manage-units/details/"
									var="viewUnitUrl">
									<spring:param name="unit" value="${group.unit.uid}"/>
								</spring:url>
								<ycommerce:testId code="${action}_uid_link">
									<p><a href="${viewUrl}">${group.uid}</a></p>
								</ycommerce:testId>
							</td>
							<td headers="header2">
								<ycommerce:testId code="${action}_name_link">
									<p>${group.name}</p>
								</ycommerce:testId>
							</td>
							<td headers="header3">
								<ycommerce:testId code="${action}_b2bunit_label">
									<p><a href="${viewUnitUrl}">${group.unit.name}</a></p>
								</ycommerce:testId>
							</td>
							<td headers="header4">
								<ycommerce:testId code="costCenter_status_label">
									<p>
										<spring:theme code="text.company.status.active.${fn:length(group.members)>0}"/>
									</p>
								</ycommerce:testId>
							</td>

						</tr>
					</c:forEach>
					</tbody>
				</table>

				<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
								searchUrl="/my-company/organization-management/manage-usergroups?sort=$
								{searchPageData.pagination.sort}"
								sortQueryParams="user=${param.user}"
								msgKey="text.company.${action}.page"
								numberPagesShown="${numberPagesShown}"/>
				<c:if test="${empty searchPageData.results}">
					<p>No entries.</p>
				</c:if>
	
	</div>
</template:page>
