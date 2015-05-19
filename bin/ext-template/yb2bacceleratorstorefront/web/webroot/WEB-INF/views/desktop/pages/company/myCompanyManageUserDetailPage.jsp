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
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:url value="/my-company/organization-management/manage-users/edit"
			var="editUserUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-users/disable"
			var="disableUserUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-users/enable"
			var="enableUserUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-users/resetpassword"
			var="resetPasswordUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-users/approvers"
			var="approversUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-users/permissions"
			var="permissionsUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-users/usergroups"
			var="usergroupsUrl">
	<spring:param name="user" value="${customerData.uid}"/>
</spring:url>
<spring:url value="/my-company/organization-management/manage-units/details"
			var="unitDetailsUrl">
	<spring:param name="unit" value="${customerData.unit.uid}"/>
</spring:url>
<template:page pageTitle="${pageTitle}">


<div id="breadcrumb" class="breadcrumb">
	<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
</div>
<div id="globalMessages">
	<common:globalMessages/>
</div>
<nav:myCompanyNav selected="users"/>
<div class="column companyContentPane clearfix orderList">

<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
	<cms:component component="${feature}"/>
</cms:pageSlot>

	<div class="headline"><spring:theme code="text.company.${action}.userDetails.title" text="User Details" arguments="${customerData.uid}"/></div>
	<div class="right">
		<a href="${editUserUrl}"  class="button edit"><spring:theme code="text.company.manageUser.button.edit" text="Edit"/></a>
		<c:choose>
			<c:when test="${customerData.active}">
				<a href="${disableUserUrl}" class="button disable"><spring:theme code="text.company.manageusers.button.disableuser" text="Disable User"/></a>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${customerData.unit.active}">
						<form:form action="${enableUserUrl}">
							<button class="enable"><spring:theme code="text.company.manageusers.button.enableuser" text="Enable User"/></button>
						</form:form>
					</c:when>
					<c:otherwise>
						<a class="button disabled"><spring:theme code="text.company.manageusers.button.enableuser" text="Enable User"/></a>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
	
	
	 <div class="description"><spring:theme code="text.company.manageusers.details.subtitle" /></div>

		<table class="table_budget orderListTable">
			<tr>
				<td>
					<spring:theme code="text.company.user.email" text="Email:  "/>
				</td>
				<td>${customerData.displayUid}</td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.user.title" text="Title:  "/>
				</td>
				<td>
					<spring:theme code="text.company.user.${customerData.titleCode}.name" text="N/A"/>
				</td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.user.name" text="First Name:  "/>
				</td>
				<td>${customerData.firstName}</td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.unit.name" text="Last Name:  "/>
				</td>
				<td>${customerData.lastName}</td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.unit.contactNumber" text="Contact Number:  "/>
				</td>
				<td>${customerData.contactNumber}</td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.user.password" text="Password:  "/>
				</td>
				<td><a href="${resetPasswordUrl}"><spring:theme code="text.company.user.resetPassword" text="Reset Password"/></a></td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.user.parentBusinessUnit" text="Parent Business Unit:  "/>
				</td>
				<td><a href="${unitDetailsUrl}">${customerData.unit.name}</a></td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.company.user.userEnabledStatus" text="User Enabled Status:  "/>
				</td>
				<td>
					<c:choose>
						<c:when test="${customerData.active}">
							<spring:theme code="text.company.manage.unit.user.enable" text="Enable"/>
						</c:when>
						<c:otherwise>
							<spring:theme code="text.company.manage.unit.user.disable" text="Disable"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	<div class="headline"><spring:theme code="text.company.manageUser.roles" text="Roles"/></div>
	<div class="description"><spring:theme code="text.company.manageusers.roles.subtitle" arguments="${b2bStore}" /></div>
	
					<table class="orderListTable">
						<thead>
						<tr>
							<th id="roles">
								<spring:theme code="text.company.manageUser.roles" text="Roles"/>
							</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td headers="1">
								<c:forEach items="${customerData.roles}" var="group">
									<p>
										<spring:theme code="b2busergroup.${group}.name"/>
									</p>
								</c:forEach>

							</td>
						</tr>
						</tbody>
					</table>
	

	<div class="headline"><spring:theme code="text.company.manage.units.header.approvers" text="Approvers"/></div>
	<div class="right">
		<a href="${approversUrl}" class="button edit"><spring:theme code="text.company.manage.units.users.button.edit" text="edit"/></a>
	</div>
	<div class="description"><spring:theme code="text.company.manageusers.approvers.subtitle" /></div>
	
					<table class="orderListTable">
						<thead>
						<tr>
							<th id="userheader1">
								<spring:theme code="text.company.manage.units.user.name" text="Name"/>
							</th>
							<th id="userheader2">
								<spring:theme code="text.company.manage.units.user.email" text="Email"/>
							</th>
							<th id="userheader3">
								<spring:theme code="text.company.manage.units.user.roles" text="Roles"/>
							</th>
							<th id="userheader4">
								<spring:theme code="text.company.manage.units.user.actions" text="Actions"/>
							</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${customerData.approvers}" var="user">
							<tr>
								<td headers="header1">
									<ycommerce:testId code="user_name_link_details">
										<spring:url value="/my-company/organization-management/manage-users/details"
													var="approverUrl">
											<spring:param name="user" value="${user.email}"/>
										</spring:url>
										<a href="${approverUrl}">${user.name}</a>
									</ycommerce:testId>
								</td>
								<td headers="2">${user.email}</td>
								<td headers="3">
									<c:forEach items="${user.roles}" var="group">
										<p>
											<spring:theme code="b2busergroup.${group}.name"/>
										</p>
									</c:forEach>
								</td>
								<td headers="4">

									<spring:url
										value="/my-company/organization-management/manage-users/edit-approver/"
										var="editUserUrl">
										<spring:param name="user" value="${customerData.uid}"/>
										<spring:param name="approver" value="${user.uid}"/>
									</spring:url>
									<spring:url value="/my-company/organization-management/manage-users/approvers/confirm/remove/"
										var="removeUserUrl">
										<spring:param name="user" value="${customerData.uid}"/>
										<spring:param name="approver" value="${user.uid}"/>
									</spring:url>

									<a href="${editUserUrl}">
										<spring:theme code="text.company.manage.unit.user.edit"
													  text="Edit"/>
									</a>
									|
									<a href="${removeUserUrl}">
										<spring:theme code="text.company.manage.unit.user.remove"
													  text="Remove"/>
									</a>

								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
	
	<div class="headline"><spring:theme code="text.company.manageUser.permission.title" text="Permissions"/></div>
	<div class="right">
		<a href="${permissionsUrl}" class="button edit"><spring:theme code="text.edit" text="Edit"/></a>
	</div>
	<div class="description"><spring:theme code="text.company.manageusers.permissions.subtitle" /></div>
	
					<table class="orderListTable">
						<thead>
						<tr>
							<th id="header1">
								<spring:theme code="text.company.permissions.title" text="Name"/>
							</th>
							<th id="header2">
								<spring:theme code="text.company.permissions.currency.title" text="Currency"/>
							</th>
							<th id="header3">
								<spring:theme code="text.company.permissions.value.title" text="Value"/>
							</th>
							<th id="header4">
								<spring:theme code="text.company.permissions.timespan.title" text="TimeSpan"/>
							</th>
							<th id="header5">
								<spring:theme code="text.company.permissions.unit.title" text="Parent Unit"/>
							</th>
							<th id="header6">
								<spring:theme code="text.company.permissions.actions.title" text="Actions"/>
							</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${customerData.permissions}" var="permission">
							<tr>
								<td headers="header1">
									<ycommerce:testId code="permission_name_link">
										<spring:url value="/my-company/organization-management/manage-permissions
										/view"
													var="permissionUrl">
											<spring:param name="permissionCode" value="${permission.code}"/>
										</spring:url>
										<a href="${permissionUrl}">${permission.code}</a>
									</ycommerce:testId>
								</td>
								<td headers="header2">
									<ycommerce:testId code="permission_currency_link">
										<p>${permission.currency.name}</p>
									</ycommerce:testId>
								</td>
								<td headers="header3">
									<ycommerce:testId code="permission_value_link">
										<p>
											<fmt:formatNumber maxFractionDigits="0" value="${permission.value}"/>
										</p>
									</ycommerce:testId>
								</td>
								<td headers="header4">
									<ycommerce:testId code="permission_timespan_link">
										<p>${permission.timeSpan}</p>
									</ycommerce:testId>
								</td>
								<td headers="header5">
									<ycommerce:testId code="permission_b2bunit_label">
										<spring:url value="/my-company/organization-management/manage-units/details"
													var="parentUnitUrl">
											<spring:param name="unit" value="${permission.unit.uid}"/>
										</spring:url>
										<a href="${parentUnitUrl}">${permission.unit.name}</a>
									</ycommerce:testId>
								</td>
								<td headers="header6">
									<spring:url
										value="/my-company/organization-management/manage-users/edit-permission/"
										var="editPermissionUrl">
										<spring:param name="user" value="${customerData.uid}"/>
										<spring:param name="permission" value="${permission.code}"/>
									</spring:url>
									<spring:url
										value="/my-company/organization-management/manage-users/permissions/confirm/remove
										/"
										var="removePermissionUrl">
										<spring:param name="user" value="${customerData.uid}"/>
										<spring:param name="permission" value="${permission.code}"/>
									</spring:url>

									<a href="${editPermissionUrl}">
										<spring:theme code="text.company.manage.unit.user.edit"
													  text="Edit"/>
									</a>
									|
									<a href="${removePermissionUrl}">
										<spring:theme code="text.company.manage.unit.user.remove"
													  text="Remove"/>
									</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
		
	<div class="headline"><spring:theme code="text.company.manageUser.usergroups.title" text="User Groups"/></div>
	<div class="right"><a href="${usergroupsUrl}" class="button edit"><spring:theme code="text.edit" text="Edit"/></a></div>
	<div class="description"><spring:theme code="text.company.manageusers.usergroups.subtitle" /></div>
	
					<table class="orderListTable">
						<thead>
						<tr>
							<th id="headerug1">
								<spring:theme code="text.company.id.name" text="ID"/>
							</th>
							<th id="headerug2">
								<spring:theme code="text.company.name.name" text="Name"/>
							</th>
							<th id="headerug3">
								<spring:theme code="text.company.parentUnit.name" text="Parent Unit"/>
							</th>
							<th id="headerug3">
								<spring:theme code="text.company.actions.name" text="Actions"/>
							</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${customerData.permissionGroups}" var="group">
							<tr>
								<td headers="header1">
									<ycommerce:testId code="permissiongroup_id_link">
										<spring:url
											value="/my-company/organization-management/manage-usergroups/details/"
											var="permissionGroupUrl">
											<spring:param name="usergroup" value="${group.uid}"/>
										</spring:url>
										<c:choose>
											<c:when test="${group.editable}">
												<a href="${permissionGroupUrl}">${group.uid}</a>
											</c:when>
											<c:otherwise>
												<p>${group.uid}</p>
											</c:otherwise>
										</c:choose>
									</ycommerce:testId>
								</td>
								<td headers="header2">
									<ycommerce:testId code="permissiongroup_name_link">
										<p>${group.name}</p>
									</ycommerce:testId>
								</td>
								<td headers="header3">
									<ycommerce:testId code="permissiongroup_parentunit_link">
										<spring:url value="/my-company/organization-management/manage-units/details"
													var="parentUnitUrl">
											<spring:param name="unit" value="${group.unit.uid}"/>
										</spring:url>
										<c:choose>
											<c:when test="${group.editable}">
												<a href="${parentUnitUrl}">${group.unit.name}</a>
											</c:when>
											<c:otherwise>
												<p>${group.unit.name}</p>
											</c:otherwise>
										</c:choose>
									</ycommerce:testId>
								</td>
								<td headers="header4">
									<spring:url
										value="/my-company/organization-management/manage-usergroups/edit"
										var="editUserGroupsUrl">
										<spring:param name="usergroup" value="${group.uid}"/>
									</spring:url>
									<spring:url
										value="/my-company/organization-management/manage-users/usergroups/confirm/remove/"
										var="removeUserGroupUrl">
										<spring:param name="user" value="${customerData.uid}"/>
										<spring:param name="usergroup" value="${group.uid}"/>
									</spring:url>
									<c:choose>
										<c:when test="${group.editable}">
											<a href="${editUserGroupsUrl}">
												<spring:theme code="text.company.manage.unit.user.edit"
															  text="Edit"/>
											</a>
											|
											<a href="${removeUserGroupUrl}">
												<spring:theme code="text.company.manage.unit.user.remove"
															  text="Remove"/>
											</a>
										</c:when>
										<c:otherwise>
											<spring:theme code="text.company.manage.unit.user.edit"
															  text="Edit"/>
											|
											<a href="${removeUserGroupUrl}">
												<spring:theme code="text.company.manage.unit.user.remove"
															  text="Remove"/>
											</a>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
	
</div>
</template:page>
