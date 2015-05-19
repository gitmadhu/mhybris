<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="profile" />
	<div class="span-20 last cust_acc-page">
		<div class="item_container_holder no-border">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.profile" text="Profile"/></h2>
			</div>
			<div class="item_container">
				<p><spring:theme code="text.account.profile.manageYourProfile" text="Manage your profile "/></p>


				<table class="account-table no-margin">
					<thead>
						<tr>
							<th id="header1"><spring:theme code="text.profile" text="Profile"/></th>
							<th id="header2"><spring:theme code="text.actions" text="Actions"/></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td headers="header1">
								<table class="cust_acc-profile">
									<tr>
										<td class="label"><spring:theme code="profile.title" text="Title"/>: </td>
										<td>${fn:escapeXml(title.name)}</td>
									</tr>
									<tr>
										<td class="label"><spring:theme code="profile.firstName" text="First name"/>: </td>
										<td>${fn:escapeXml(customerData.firstName)}</td>
									</tr>
									<tr>
										<td class="label"><spring:theme code="profile.lastName" text="Last name"/>: </td>
										<td>${fn:escapeXml(customerData.lastName)}</td>
									</tr>
									<tr>
										<td class="label"><spring:theme code="profile.email" text="E-mail"/>: </td>
										<td>${fn:escapeXml(customerData.displayUid)}</td>
									</tr>
								</table>
							</td>
							<td headers="header2" class="actions background">
								<ul>
									<li>
										<a href="update-profile" class="positive btn_add"><spring:theme code="text.account.profile.updatePersonalDetails" text="Update personal details"/></a>
									</li>
									<li>
										<a href="update-email" class="positive btn_add"><spring:theme code="text.account.profile.updateEmail" text="Update email"/></a>
									</li>
									<li>
										<a href="update-password" class="positive btn_add"><spring:theme code="text.account.profile.changePassword" text="Change password"/></a>
									</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>

			</div>
			
		</div>
	</div>
</template:page>