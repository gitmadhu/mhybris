<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/desktop/storepickup" %>

<template:page pageTitle="${pageTitle}">

	<jsp:attribute name="pageScripts">

		<script type="text/javascript">
		$(function(){
			$('.product_grid_more').click(function(){
				if($(this).hasClass('product_grid_more_hide')){
					$(this).removeClass('product_grid_more_hide');
					$('.facet_hide').show();
				}else{
					$(this).addClass('product_grid_more_hide');
					$('.facet_hide').hide();
				}
			});
		})
		</script>
	</jsp:attribute>
	<jsp:body>
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	
	<cms:pageSlot position="Section1" var="feature">
		<cms:component component="${feature}" element="div" class="span-24 section1 cms_disp-img_slot"/>
	</cms:pageSlot>

	<div class="span-24">
		<div class="span-6 facetNavigation">

			<cms:pageSlot position="Section4" var="feature">
				<cms:component component="${feature}" element="div" class="span-6 section4 cms_disp-img_slot"/>
			</cms:pageSlot>
		</div>
	
		<div class="span-18 last">
		
			<cms:pageSlot position="Section2" var="feature">
				<cms:component component="${feature}" element="div" class="section2 cms_disp-img_slot"/>
			</cms:pageSlot>
			
			<div class="product_grid_search">
				<div class="product_grid_search2">
			<nav:facetNavAppliedFilters pageData="${searchPageData}"/>
			<nav:facetNavRefinements pageData="${searchPageData}"/>
				</div>
				<c:if test='${fn:length(searchPageData.facets) > 3}'>
				<div class="product_grid_more product_grid_more_hide">more</div>
				</c:if>
			</div>
			
			<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}" numberPagesShown="${numberPagesShown}"/>

			<cms:pageSlot position="Section3" var="feature" element="div" class="span-20 last">
				<cms:component component="${feature}" element="div" class="span-5 section3 small_detail"/>
			</cms:pageSlot>

			<div class="productGrid">
				<c:forEach items="${searchPageData.results}" var="product" varStatus="status">
					<div class="span-6 ${(status.index+1)%3 == 0 ? ' last' : ''}${(status.index)%3 == 0 ? ' first clear' : ''}">
						<product:accProductListerGridItem product="${product}" />
					</div>
				</c:forEach>
			</div>
			
				<nav:pagination top="false"  supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}"  searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"  numberPagesShown="${numberPagesShown}"/>
		
		</div>
	</div>
	
	
	
<storepickup:pickupStorePopup />
	<div class="lazyLoadConfig"  data-lazy-load-config='{ "failure_limit" : 0, "threshold" : 0 }' data-timeout='250'></div>
	</jsp:body>
</template:page>
