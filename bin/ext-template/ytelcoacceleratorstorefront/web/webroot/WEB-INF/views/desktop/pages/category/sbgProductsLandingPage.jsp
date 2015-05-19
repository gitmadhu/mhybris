<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="sbgproduct" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<template:page pageTitle="${pageTitle}">
	<jsp:attribute name="pageScripts">
		<script  type="text/javascript">
			$(function() {
				$(".sbgProduct:first-child div[data-row]").each(function(i){
					 var maxheight=0 
					$(".sbgProduct form > div[data-row="+(i+1)+"]").each(function(){
					    var height=$(this).height();
					    maxheight=(maxheight<height)?height:maxheight; 
					})
					$(".sbgProduct form > div[data-row="+(i+1)+"]").css("height",maxheight);
				});
			});
		</script>
	</jsp:attribute>
	<jsp:body>
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
		<div class="span-24 sbgProductList">
			<c:forEach items="${searchPageData.results}" var="product" varStatus="status">
				<div class="sbgProduct <c:if test="${fn:contains(product.url, 'Add-Ons')}"> productlist-addon</c:if>">
					<sbgproduct:sbgProductListerGridItem product="${product}"/> 
				</div>
			</c:forEach>
		</div>
	 </jsp:body>
</template:page>