<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
		
	<div id="globalMessages">
		<common:globalMessages/>
	</div>

<div class="product-list searchgridpage"> <!-- changed for telco -->
	<div class="span-24 last">
		<cms:slot var="feature" contentSlot="${slots['Section2']}">
			<div class="section2 advert">
				<cms:component component="${feature}"/>
			</div>
		</cms:slot>
	</div>
	
	<div class="span-6 facet-filters">
		<nav:facetNavAppliedFilters pageData="${searchPageData}"/>
		<nav:facetNavRefinements pageData="${searchPageData}"/>
	</div>

	<div class="span-18 last searchgrid-results">
		<div class="results">
			<h1><spring:theme code="search.page.searchText" arguments="${searchPageData.freeTextSearch}"/></h1>
		</div>
		
		<div class="span-18 last spellingSuggestion">
			<nav:searchSpellingSuggestion spellingSuggestion="${searchPageData.spellingSuggestion}" />
		</div>		

		<nav:pagination top="true" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"/>
		
		<div class="prod-list-container"><!-- telco two column grid container -->
			<c:forEach items="${searchPageData.results}" var="product" varStatus="status">
					<c:if test="${fn:contains(product.url, 'Devices')}"><div class="span-9${(status.index+1)%2 == 0 ? ' last' : ''} productlist-device"><product:productListerGridItem product="${product}"/></div></c:if>
					<c:if test="${fn:contains(product.url, 'Accessories')}"><div class="span-9${(status.index+1)%2 == 0 ? ' last' : ''} productlist-accessory"><product:productListerGridItem product="${product}"/></div></c:if>
					<c:if test="${fn:contains(product.url, 'Plans')}"><div class="span-9${(status.index+1)%2 == 0 ? ' last' : ''} productlist-plan"><product:productListerGridItem product="${product}"/></div></c:if>
					<c:if test="${fn:contains(product.url, 'Add-Ons')}"><div class="span-9${(status.index+1)%2 == 0 ? ' last' : ''} productlist-addon"><product:productListerGridItem product="${product}"/></div></c:if>
			</c:forEach>
		</div>
		
		<nav:pagination top="false" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"/>

	</div>
</div>	
</template:page>