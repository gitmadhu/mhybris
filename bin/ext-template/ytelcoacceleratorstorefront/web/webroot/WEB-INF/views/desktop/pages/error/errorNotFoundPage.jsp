<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${additionalBreadcrumb}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<div>
		<c:if test="${not empty message}">
			<c:out value="${message}"/>
		</c:if>
	</div>
	<div class="span-20" id="">
		<cms:slot var="comp" contentSlot="${slots.MiddleContent}">
			<cms:component component="${comp}"/>
		</cms:slot>
	</div>

	<div class="span-20 advert last">
		<cms:slot var="comp" contentSlot="${slots.BottomContent}">
			<cms:component component="${comp}"/>
		</cms:slot>
	</div>
	
	<div class="span-4 narrow-content-slot advert">
		<cms:slot var="feature" contentSlot="${slots['SideContent']}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
</template:page>