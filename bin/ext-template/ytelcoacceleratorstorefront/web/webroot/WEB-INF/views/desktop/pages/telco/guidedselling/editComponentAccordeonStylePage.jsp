<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="extra" tagdir="/WEB-INF/tags/desktop/telco/guidedselling" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/desktop/telco/guidedselling" %>

<template:page pageTitle="${pageTitle}">
 	<jsp:body>
		<c:if test="${not empty message}">
			<spring:theme code="${message}"/>
		</c:if>
		<div id="breadcrumb" class="breadcrumb">
			<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
		</div>
		<div id="globalMessages">
			<common:globalMessages/>
		</div>
		
		<guidedselling:dashboard dashboard="${dashboard}"/>
		
		<h1 class="guided-selling-headline"><spring:theme code="guidedselling.select.text.${productType}"/></h1>
		
		<div class="span-20">
		
			<div class="span-20" id="productDetailUpdateable">
				<extra:editComponentAccordeonStyle bundleTemplateData="${bundleTemplateData}" bundleNo="${bundleNo}"/>
			</div>
			<div class="span-20">
				<div class="span-4">
					<cms:slot var="comp" contentSlot="${slots.CrossSelling}">
						<cms:component component="${comp}"/>
					</cms:slot>
				</div>
			</div>
		</div>
		<div class="span-4 last">
			<cms:slot var="comp" contentSlot="${slots.Accessories}">
				<cms:component component="${comp}"/>
			</cms:slot>
		</div>
	</jsp:body>
 
 
 
</template:page>