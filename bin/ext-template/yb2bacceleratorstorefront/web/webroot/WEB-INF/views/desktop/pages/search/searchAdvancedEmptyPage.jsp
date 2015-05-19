<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/desktop/grid" %>


<template:page pageTitle="${pageTitle}">
	<jsp:attribute name="pageScripts">
		<script type="text/javascript" src="${commonResourcePath}/js/acc.productlisting.js"></script>
		<product:productDetailsJavascript/>
	</jsp:attribute>
	
	<jsp:body>
		<div id="breadcrumb" class="breadcrumb">
			<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}" />
		</div>
		<c:if test="${not empty message}">
			<spring:theme code="${message}" />
		</c:if>
		<div id="globalMessages">
			<common:globalMessages />
		</div>
		<div class="span-24">
			
			<cms:pageSlot position="SideContent" var="feature" element="div" class="span-4 side-content-slot cms_disp-img_slot">
				<cms:component component="${feature}" />
			</cms:pageSlot>
			
			<div class="last advancedSearch">
			
			<c:if test="${ not advancedSearchForm.catalogSearchResultType}">
				<div class="span-24 advancedSearch">
			</c:if>
				<div class="headline"><spring:theme code="search.advanced" text="Advanced Search" /></div>
						
					<div class="advancedSearchSection clearfix">
						<c:url value="/search/advanced" var="advancedSearchUrl"/>
						<form:form action="${advancedSearchUrl}" method="get" name="advancedSearchForm" commandName="advancedSearchForm">
							<div class="advanced_search_area">
								
								
									
							<div class="searchInput">	
								<formElement:formInputBox idKey="js-product-ids" labelKey="search.advanced.keyword" path="keywords" inputCSS="" mandatory="false" />
								<button id="js-add-product-ids"  type="submit"><spring:theme code="search.advanced.productids.add" text="Enter" /></button>
							</div>
							
							<sec:authorize ifAnyGranted="ROLE_CUSTOMERGROUP">
								<div class="radios clearfix right">
									<formElement:formRadioBoxLeft idKey="search-order-form" labelKey="search.advanced.orderform" value="order-form" path="searchResultType" />
									<formElement:formRadioBoxLeft idKey="search-create-order-form" labelKey="search.advanced.createorderform" value="create-order-form" path="searchResultType" />
									<formElement:formRadioBoxLeft idKey="search-catalog" labelKey="search.advanced.catalog" value="catalog" path="searchResultType" />
								</div>
							</sec:authorize>
							
							<div class="idCheckbox">		
								<formElement:formCheckbox idKey="js-enable-product-ids" labelKey="search.advanced.onlyproductids" path="onlyProductIds" inputCSS="advanced-onlyProductIds" labelCSS="" mandatory="false" />
							</div>
							
							
							
							<c:set var="isCreateOrderForm" value="${form.createOrderForm}" />
							<c:if test="${empty isCreateOrderForm }">
								<c:set var="isCreateOrderForm" value="false" />
							</c:if>
							<div id="js-selected-product-ids" class="selected_product_ids clearfix"></div>
			
							<div class="searchButton">
								<input type="hidden" name="skus" id="skus" value=""/>
								<input type="hidden" name="isCreateOrderForm" id="isCreateOrderForm" value="${isCreateOrderForm}"/>
					
							    <%-- please leave the instock checkbox it will come in the next sprint, just hiding for now --%>
								<%-- formElement:formCheckbox idKey="advanced-exact" labelKey="search.advanced.inventory" path="inStockOnly" inputCSS="" labelCSS="" mandatory="false" /> --%>
								<button class="positive adv_search_button" type="submit"><spring:theme code="search.advanced.search" text="Search" /></button>
							</div>
						</form:form>
					</div>
					
				</div>
				<c:url value="/search" var="currentURL"/>
				<div id="currentPath" data-current-path="${currentURL}"></div>
			
				<c:if test="${advancedSearchForm.orderFormSearchResultType}">
					<div class="span-8 last right orderFormTotal">
						<product:productFormAddToCartPanel product="${product}" showViewDetails="false"/>
					</div>
				</c:if>
				

				<c:if test="${not empty advancedSearchForm.keywords}">
						<nav:pagination top="true"  supportShowPaged="${isShowPageAllowed}"
													supportShowAll="${isShowAllAllowed}"
													searchPageData="${searchPageData}"
													searchUrl="${searchPageData.currentQuery.url}"
													numberPagesShown="${numberPagesShown}"
													searchResultType="${advancedSearchForm.searchResultType}"/>
				</c:if>



				<c:set var="skuIndex" scope="session" value="0" />
				<spring:theme code="product.grid.confirmQtys.message" var="gridConfirmMessage" />



				<c:if test="${advancedSearchForm.catalogSearchResultType}">
					<product:productLister 	pageData="${searchPageData}" path="/search" 
											isOnlyProductIds="${advancedSearchForm.onlyProductIds}"/>
				</c:if>

				<c:if test="${advancedSearchForm.orderFormSearchResultType}">
					
					<grid:gridLegend />
					
					<form name="AddToCartOrderForm" id="AddToCartOrderForm" class="add_to_cart_order_form" action="<c:url value="/cart/addGrid"/>" method="post" data-grid-confirm-message="${gridConfirmMessage}">

						<product:productLister 	pageData="${searchPageData}" path="/search" 
												itemType="ORDERFORM" 
												isOnlyProductIds="${advancedSearchForm.onlyProductIds}"
												filterSkus="${advancedSearchForm.filterSkus}" 
												/>
					</form>

					<div id="skuIndexSavedValue" name="skuIndexSavedValue" data-sku-index="${sessionScope.skuIndex}"><!--  don't remove this div. This is used by the order form search --></div>
				</c:if>
				<c:if test="${advancedSearchForm.createOrderFormSearchResultType}">
					<form name="createOrderForm" id="createOrderForm" class="create-order-form" data-grid-confirm-message="${gridConfirmMessage}">
						<div class="clearfix"><button id="js-create-order-form-button" class="positive" type="button"><spring:theme code='search.advanced.createorderform' /></button></div>


						<product:productLister 	pageData="${searchPageData}" path="/search"
												itemType="FILTER" 
												isOnlyProductIds="false"
												filterSkus="${advancedSearchForm.filterSkus}" 
												/>

					</form>
				</c:if>


				<c:if test="${not empty advancedSearchForm.keywords}">
					<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}"
												supportShowAll="${isShowAllAllowed}"
												searchPageData="${searchPageData}"
												searchUrl="${searchPageData.currentQuery.url}"
												numberPagesShown="${numberPagesShown}"
												searchResultType="${advancedSearchForm.searchResultType}"/>
				</c:if>
				
				<script id="product-id-tag-box-template" type="text/x-jquery-tmpl">
				<span class="product-id-tag-box" id="product-id-\${productId}-tag">
				  <span>\${productId}</span>
				  <button class="js-remove-product-id" type="button">x</button>
				</span>
				</script>

				<product:productOrderFormJQueryTemplates />
				
				<cms:pageSlot position="BottomContent" var="comp" element="div" class="span-20 cms_disp-img_slot right last">
					<cms:component component="${comp}" />
				</cms:pageSlot>
			</div>
		</div>
		<input id="searchByKeywordLabel" type="hidden" value='<spring:theme code="search.advanced.keyword"/>' />
		<input id="searchByIdsLabel" type="hidden" value='<spring:theme code="search.advanced.productids"/>' />
		<c:remove var="skuIndex" scope="session" />
	</jsp:body>
</template:page>