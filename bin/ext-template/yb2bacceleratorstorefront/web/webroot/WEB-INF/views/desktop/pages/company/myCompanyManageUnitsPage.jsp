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

<spring:url value="/my-company/organization-management/manage-units/create" var="createUnitUrl">
	<spring:param name="unit" value=""/>
</spring:url>

<template:page pageTitle="${pageTitle}">

	<script type="text/javascript"> // set vars
		/*<![CDATA[*/
		
		var unittree = true;
		
		/*]]>*/
	</script>
	
	
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:myCompanyNav selected="units"/>
	<div class="column companyContentPane clearfix">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-20 wide-content-slot cms_disp-img_slot">
			<cms:component component="${feature}"/>
		</cms:pageSlot>						
		
		<div class="headline"><spring:theme code="text.company.manage.units.label" text="Manage Units"/></div>
		
		<div class="right">
			<ycommerce:testId code="Unit_CreateNewUnit_button">
				<a href="${createUnitUrl}" class="button add"><spring:theme code="text.company.manage.units.newUnitButton" text="Create New Unit"/></a>
			</ycommerce:testId>
		</div>
		
		<div class="description"><spring:theme code="text.company.manage.units.subtitle"/></div>
				
							
		<ul id="unittree" class="treeview">
			<company:unitTree node="${rootNode}"/>
		</ul>
			
	</div>
</template:page>
