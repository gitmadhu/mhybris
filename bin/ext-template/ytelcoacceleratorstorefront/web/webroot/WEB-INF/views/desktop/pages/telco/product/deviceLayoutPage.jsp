
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
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/desktop/telco/guidedselling" %>

<template:page pageTitle="${pageTitle}">
	<jsp:attribute name="pageScripts">
		<product:productDetailsJavascript product="${product}"/>
	</jsp:attribute>

	<jsp:body>

		<c:if test="${not empty message}">
			<spring:theme code="${message}"/>
		</c:if>

		<c:if test="${not empty product.bundleTabs}">
			<guidedselling:dashboardEmpty type="DeviceModel"/>
		</c:if>

		<div id="breadcrumb" class="breadcrumb">
			<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
		</div>
		<div id="globalMessages">
			<common:globalMessages/>
		</div>

	<div class="deviceContainer">
	
		<div id="productDetailUpdateable">
			<product:productDetailsPanel product="${product}" galleryImages="${galleryImages}"/>
		</div>
		
		<div class="span-24 productDetailFeatures"><!-- telco feature container -->
			
				<product:productPageTabs />
		</div>
			
		

	<div class="span-24 last productDetailAccessories">
	 <cms:slot var="comp" contentSlot="${slots.DeviceContentPosition}">
	  	<cms:component component="${comp}" />
   </cms:slot>
	 </div>
	 
	</div>
	 
	</jsp:body>
</template:page>
