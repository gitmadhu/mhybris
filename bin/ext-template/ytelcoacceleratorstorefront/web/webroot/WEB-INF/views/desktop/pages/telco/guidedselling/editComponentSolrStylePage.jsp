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
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/telco/product" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	
	<div class="span-24 product-list searchlistpage">
		<div class="span-6 facet-filters">
		<nav:facetNavAppliedFilters pageData="${searchPageData}"/>
		<nav:facetNavRefinements pageData="${searchPageData}"/>
	</div>

		<div class="span-18 last searchlist-results">
				
			<div class="span-18 last spellingSuggestion">
			<nav:searchSpellingSuggestion spellingSuggestion="${searchPageData.spellingSuggestion}" />
		</div>		

			<nav:pagination top="true" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"/>
			
			
			<input type="hidden" id="refreshed" value="no">
			<script type="text/javascript">
			    onload=function(){
 			        var e=document.getElementById("refreshed");
 			        if(e.value=="no") {
 			        	e.value="yes";
 			        } else {
 			        	e.value="no";location.reload();
 			        }
 			    }
			</script>


					<script type="text/javascript">
						$(document).ready(function(){
							$(".delayed-button").removeAttr("disabled")
							$(".delayed-button").click(function(event){
								event.preventDefault();
								var $this=$(this);
								$this.attr("disabled", "disabled").addClass("disabled").html("Please wait");
				  
					           setTimeout(function() {
					               $this.parents("form").submit();
					            }, 2000);
	
							});		
						});
					</script> 
		
			<div class="prod-list-container">
				<c:forEach items="${searchPageData.results}" var="product">

					<product:productListerGridItemForGuidedSelling product="${product}" bundleNo="${bundleNo}" componentId="${componentId}"/>

			</c:forEach>
		</div>
		
		<nav:pagination top="false" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"/>
			
	</div>
</div>	
		
	</jsp:body> 
</template:page>