<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/desktop/user" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<div class="span-4 side-content-slot advert">
		<cms:slot var="feature" contentSlot="${slots.SideContent}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>

<div class="telco-checkout checkout-login"> <!-- telco change -->

	<div class="span-20">

		<div class="span-20 top-content-slot advert last">
			<cms:slot var="feature" contentSlot="${slots.TopContent}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>

		<div class="span-10">
			<c:url value="/login/register" var="registerActionUrl" />
			<user:register actionNameKey="register.submit" action="${registerActionUrl}"/>
		</div>

		<div class="span-10 last">
			<c:url value="/j_spring_security_check" var="loginActionUrl" />
			<user:login actionNameKey="login.login" action="${loginActionUrl}"/>
		</div>

	</div>
</div>
</template:page>