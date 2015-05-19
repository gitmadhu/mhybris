<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="product" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="variant" required="true" type="de.hybris.platform.commercefacades.product.data.VariantMatrixElementData" %>
<%@ attribute name="loopIndexColor" required="true" type="java.lang.Integer"%>
<%@ attribute name="skusId" required="true" type="java.lang.String"%>
<%@ attribute name="showName" required="false" type="java.lang.Boolean"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>

<div class="buttons clearfix">
	<spring:url value="${product.url}/grid/skusFutureStock"	var="skusFutureStockUrl" />
	<button class="update_future_stock_button positive" data-skus-id="${skusId}" data-skus-future-stock-url="${skusFutureStockUrl}" id="update-future-availability-button-${loopIndexColor}">
		<spring:theme code="product.grid.futurestock.refresh" />
	</button>
</div>

<common:spinner spinnerId="${skusId}"></common:spinner>

<div class="span-11">
	<c:if test="${variant.parentVariantCategory.hasImage}">
		<div class="span-3" id="colorImage">
			<product:productImage product="${product}" code="${skusId}" format="cartIcon"/>
		</div>
	</c:if>
	
	<c:if test="${showName == true}">
		<span>${product.name} - ${variant.variantValueCategory.name}</span><br/>
	</c:if>
	<c:if test="${showName != true}">
		<span>${variant.variantValueCategory.name}</span><br/>
	</c:if>
</div>

<div class="span-6 last orderForm_subHeader">
	<span id="subTotal__label" class="subHeader_label"><spring:theme code="product.grid.subtotalText" />:</span> <span id="subtotal" class="subHeader_value">0</span><br/>
	<input type="hidden" id="subtotalValue" value="0">
	<span class="subHeader_label"><spring:theme code="product.grid.averagePriceUnitText" />:</span> <span id="avgPrice" class="subHeader_value">0</span><br/>
	<input type="hidden" id="avgPriceValue" value="0">
	<span class="subHeader_label"><spring:theme code="product.grid.quantityText"/>:</span> <span id="quantity" class="subHeader_value">0</span><br/>
	<input type="hidden" id="quantityValue" value="0">
</div>

<script id="oms-error-message-template" type="text/x-jquery-tmpl">
    <div class="information_message negative">
    	<span class="single"></span>
    	<p>\${errorMessage}</p>
    </div>
</script>