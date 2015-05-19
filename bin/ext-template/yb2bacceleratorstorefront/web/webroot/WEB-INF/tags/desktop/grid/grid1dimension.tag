<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/desktop/grid" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="titleQuantityText"><spring:theme code="product.grid.quantityText" /></c:set>

<div class="orderForm_grid_group">
	
	<div class="span-16 grid-buttons">
		<c:set var="skusId" value="${product.variantMatrix[0].variantOption.code}"/>
		<spring:url value="${product.url}/grid/skusFutureStock"	var="skusFutureStockUrl" />
		<button class="form update_future_stock_button positive" data-skus-id="${skusId}" data-skus-future-stock-url="${skusFutureStockUrl}">
			<spring:theme code="product.grid.futurestock.refresh" />
		</button>
	</div>
	
	<div class="span-7 last orderForm_subHeader">
		<span id="subTotal__label" class="subHeader_label"><spring:theme code="product.grid.subtotalText" />:</span> <span id="subtotal" class="subHeader_value">0.00</span><br/>
		<input type="hidden" id="subtotalValue" value="0">
		<span class="subHeader_label"><spring:theme code="product.grid.averagePriceUnitText" />:</span> <span id="avgPrice" class="subHeader_value">0.00</span><br/>
		<input type="hidden" id="avgPriceValue" value="0">
		<span class="subHeader_label"><spring:theme code="product.grid.quantityText"/>:</span> <span id="quantity" class="subHeader_value">0</span><br/>
		<input type="hidden" id="quantityValue" value="0">
	</div>
	
	<c:set var="loopIndexColor" value="${loopIndexColor +1}"/>
	<div class="product-grid-container clear">
		<grid:coreTable variants="${product.variantMatrix}"
						inputTitle="${titleQuantityText}"
						loopIndex="${loopIndex}" />
	</div>
</div>