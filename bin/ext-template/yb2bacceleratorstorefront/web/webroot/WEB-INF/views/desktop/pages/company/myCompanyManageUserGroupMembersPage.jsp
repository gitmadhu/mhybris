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
<spring:theme code="text.company.disable.action.label" text="Disable" var="disableAction"/>


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
		<div class="headline"><spring:theme code="text.company.usergroups.${action}.title" text="${action}" arguments="${param.usergroup}"/></div>
			
				<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
								searchUrl="${baseUrl}/${action}?usergroup=${param.usergroup}&sort=${searchPageData.pagination.sort}"
								msgKey="text.company.${action}.page"
								sortQueryParams="user=${param.user}"
								numberPagesShown="${numberPagesShown}"/>
				<table id="order_history" class="orderListTable">
					<thead>
					<tr>
						<th id="header1">
							<spring:theme code="text.company.${action}.name.title" text="Name"/>
						</th>
						<th id="header2">
							<spring:theme code="text.company.${action}.unit.title" text="Parent unit"/>
						</th>
						<th id="header3">
							<spring:theme code="text.company.${action}.roles.title" text="Roles"/>
						</th>
						<th id="header4">
							<spring:theme code="text.company.${action}.actions.title" text="Actions"/>
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${searchPageData.results}" var="user">
						<spring:url value="/my-company/organization-management/manage-users/details"
									var="viewUrl">
							<spring:param name="user" value="${user.uid}"/>
						</spring:url>
						<spring:url value="${baseUrl}/${action}/select/"
									var="selectUrl">
							<spring:param name="user" value="${user.uid}"/>
							<spring:param name="usergroup" value="${param.usergroup}"/>
						</spring:url>
						<spring:url value="${baseUrl}/${action}/deselect/"
									var="deselectUrl">
							<spring:param name="user" value="${user.uid}"/>
							<spring:param name="usergroup" value="${param.usergroup}"/>
						</spring:url>
						<spring:url
							value="/my-company/organization-management/manage-units/details/"
							var="unitDetailUrl">
							<spring:param name="unit" value="${user.unit.uid}"/>
						</spring:url>
						
						<tr class="${user.selected ? 'selected' : ''}" id="row-${user.normalizedUid}">
							<td headers="header1">
								<ycommerce:testId code="${action}_name_link">
									<a href="${viewUrl}">${user.name}</a>
								</ycommerce:testId>
							</td>
							<td headers="header2">
								<ycommerce:testId code="${action}_b2bunit_label">
									<p><a href="${unitDetailUrl}">${user.unit.name}</a></p>
								</ycommerce:testId>
							</td>
							<td headers="header3">
								<ycommerce:testId code="${action}_roles_label">
									<div id="roles-${user.normalizedUid}">
										<c:forEach items="${user.roles}" var="role">
											<p>
												<spring:theme code="b2busergroup.${role}.name"/>
											</p>
										</c:forEach>
									</div>
								</ycommerce:testId>
							</td>
							<td headers="header4">
								<ycommerce:testId code="${action}_actions_label">
									<p>
									<span id="selection-${user.normalizedUid}">
										<c:choose>
											<c:when test="${user.selected}">
												${selectAction} |
												<a href="#"
												   url="${deselectUrl}"
												   class="deselectUser"
													>${deselectAction}</a>
											</c:when>
											<c:otherwise>
												<a href="#"
												   url="${selectUrl}"
												   class="selectUser"
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

				<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
								searchUrl="${baseUrl}/${action}?usergroup=${param.usergroup}&sort=${searchPageData.pagination.sort}"
								msgKey="text.company.${action}.page"
								sortQueryParams="user=${param.user}"
								numberPagesShown="${numberPagesShown}"/>
				<c:if test="${empty searchPageData.results}">
					<p>No entries.</p>
				</c:if>
			<common:back/>
	</div>

	<c:url value="${baseUrl}/${action}" var="actionLink" />
	<script id="enableDisableLinksTemplate" type="text/x-jquery-tmpl">
		{{if selected}}
		${selectAction} | <a href="#"
							 url="${actionLink}/deselect/?user={{= uid}}&usergroup=${param.usergroup}"
							 class="deselectUser">${deselectAction}</a>
		{{else}}
		<a href="#"
		   url="${actionLink}/select/?user={{= uid}}&usergroup=${param.usergroup}"
		   class="selectUser">${selectAction}</a> | ${deselectAction}
		{{/if}}
	</script>
	
	<script id="userRolesTemplate" type="text/x-jquery-tmpl">
	{{each displayRoles}}
		<p>
			{{= $value}}
		</p>
	{{/each}}
	</script>

</template:page>
