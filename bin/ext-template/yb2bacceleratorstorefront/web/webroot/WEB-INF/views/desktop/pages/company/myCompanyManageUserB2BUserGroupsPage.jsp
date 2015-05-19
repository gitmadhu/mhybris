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

<spring:theme code="text.company.select.action.label" text="Select" var="selectAction"/>
<spring:theme code="text.company.deselect.action.label" text="Deselect" var="deselectAction"/>


<template:page pageTitle="${pageTitle}">

<div id="breadcrumb" class="breadcrumb">
	<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	<common:back/>
</div>
<div id="globalMessages">
	<common:globalMessages/>
</div>
<nav:myCompanyNav selected="users"/>
<div class="column companyContentPane clearfix orderList">
	<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
		<cms:component component="${feature}"/>
	</cms:pageSlot>								
	<div class="headline"><spring:theme code="text.company.manage.units.${action}.title" text="${action}" arguments="${param.user}"/></div>

			<nav:pagination top="true"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
							searchUrl="${baseUrl}/${action}?user=${param.user}&sort=${searchPageData.pagination.sort}"
							msgKey="text.company.${action}.page"
							sortQueryParams="user=${param.user}"
							numberPagesShown="${numberPagesShown}"/>
			<table id="order_history" class="orderListTable">
				<thead>
				<tr>
					<th id="header1">
						<spring:theme code="text.company.id.name" text="ID"/>
					</th>
					<th id="header2">
						<spring:theme code="text.company.name.name" text="Name"/>
					</th>
					<th id="header5">
						<spring:theme code="text.company.parentUnit.name" text="Parent unit"/>
					</th>
					<th id="header6">
						<spring:theme code="text.company.actions.name" text="Actions"/>
					</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${searchPageData.results}" var="result">
					<spring:url value="/my-company/organization-management/manage-usergroups/details/"
								var="viewUserGroupUrl">
						<spring:param name="usergroup" value="${result.uid}"/>
					</spring:url>
					<spring:url value="/my-company/organization-management/manage-units/details/"
								var="unitUrl">
						<spring:param name="unit" value="${result.unit.uid}"/>
					</spring:url>
					<tr class="${result.selected ? 'selected' : ''}" id="row-${ycommerce:normalizedCode(result.uid)}">
						<td headers="header1">
							<ycommerce:testId code="${action}_id_link">
								<p><a href="${viewUserGroupUrl}">${result.uid}</a></p>
							</ycommerce:testId>
						</td>
						<td headers="header2">
							<ycommerce:testId code="${action}_name_link">
								<p>${result.name}</p>
							</ycommerce:testId>
						</td>
						<td headers="header2">
							<ycommerce:testId code="${action}_b2bunit_label">
								<p><a href="${unitUrl}">${result.unit.name}</a></p>
							</ycommerce:testId>
						</td>

						<td headers="header4">
							<ycommerce:testId code="${action}_actions_label">
								<p>
									<span id="span-${ycommerce:normalizedCode(result.uid)}">
											<spring:url value="${baseUrl}/${action}/select/"
														var="selectUrl">
												<spring:param name="user" value="${param.user}"/>
												<spring:param name="usergroup" value="${result.uid}"/>
											</spring:url>
											<spring:url value="${baseUrl}/${action}/deselect/"
														var="deselectUrl">
												<spring:param name="user" value="${param.user}"/>
												<spring:param name="usergroup" value="${result.uid}"/>
											</spring:url>

										<c:choose>
											<c:when test="${result.selected}">
												${selectAction} |
												<a href="#"
												   url="${deselectUrl}"
												   class="deselectionLink"
													>${deselectAction}</a>
											</c:when>
											<c:otherwise>
												<a href="#"
												   url="${selectUrl}"
												   class="selectionLink"
													>${selectAction}</a> | ${deselectAction}
											</c:otherwise>
										</c:choose>
									</span>
								</p>
							</ycommerce:testId>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>

			<nav:pagination top="false"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
							searchUrl="${baseUrl}/${action}?user=${param.user}&sort=${searchPageData.pagination.sort}"
							msgKey="text.company.${action}.page"
							sortQueryParams="user=${param.user}"
							numberPagesShown="${numberPagesShown}"/>
			<c:if test="${empty searchPageData.results}">
				<p>No entries.</p>
			</c:if>
</div>

<c:url value="${baseUrl}/${action}" var="actionLink" />
<script id="enableDisableLinksTemplate" type="text/x-jquery-tmpl">
	{{if selected}}
	${selectAction} | <a href="#"
				url="${actionLink}/deselect/?usergroup={{= id}}&user=${param.user}"
				class="deselectionLink">${deselectAction}</a>
	{{else}}
	<a href="#"
	   url="${actionLink}/select/?usergroup={{= id}}&user=${param.user}"
	   class="selectionLink">${selectAction}</a> | ${deselectAction}
	{{/if}}
</script>

</template:page>
