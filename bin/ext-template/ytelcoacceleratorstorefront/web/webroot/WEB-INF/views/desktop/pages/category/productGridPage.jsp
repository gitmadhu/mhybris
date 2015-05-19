<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
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
	<cms:slot var="feature" contentSlot="${slots['Section1']}">
		<div class="span-24 section1 advert">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	<div class="span-24 product-list product-list-grid">
		<div class="span-6">

			<nav:facetNavAppliedFilters pageData="${searchPageData}"/>
			<nav:facetNavRefinements pageData="${searchPageData}"/>

			<cms:slot var="feature" contentSlot="${slots['Section4']}">
				<div class="span-4 section4 advert">
					<cms:component component="${feature}"/>
				</div>
			</cms:slot>
		</div>
	
		<div class="span-18 last productgridcontainer">
			<cms:slot var="feature" contentSlot="${slots['Section2']}">
				<div class="section2 advert">
					<cms:component component="${feature}"/>
				</div>
			</cms:slot>
			
			<nav:pagination top="true" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"/>
			
			<cms:slot var="feature" contentSlot="${slots['Section3']}">
				<div class="span-5 section3 small_detail">
					<cms:component component="${feature}"/>
				</div>
			</cms:slot>
			
			<div class="prod-list-container">
				<c:forEach items="${searchPageData.results}" var="product" varStatus="status">
				
					<div class="span-9${(status.index+1)%2 == 0 ? ' last' : ''} <c:if test="${fn:contains(product.url, 'Add-Ons')}"> productlist-addon</c:if>">
						<product:productListerGridItem product="${product}"/>
					</div>
				</c:forEach>
			</div>

			<nav:pagination top="false" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"/>

		</div>
	</div>
</template:page>
