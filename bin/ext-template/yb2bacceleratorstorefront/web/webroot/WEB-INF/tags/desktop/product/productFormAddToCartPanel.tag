<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="showViewDetails" required="false" type="java.lang.Boolean"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<c:url value="/${product.url}" var="productUrl"/>

<div class="orderForm clearfix">
	<div class="headline"><spring:theme code="order.form.total"/></div>
<div  class="clearfix">
		<div class="left total-items-count">(<span id="total-items-count">0</span> <spring:theme code="product.grid.itemsText"/>)</div>
		<div class="right" id="total-price">0</div>
		<input type="hidden" id="total-price-value" value="0">
</div>


		<div class="left viewDetailButton">
			<c:if test="${showViewDetails != false}">
				<c:url value="${productUrl}" var="backToProductUrl"/>
				<a href="${backToProductUrl}" class="button" ><spring:theme code="product.view.details" /></a>
			</c:if>
		</div>

		<div id="orderFormAddToCart" class="right prod_add_to_cart">
			<spring:theme code="text.addToCart" var="addToCartText"/>
			<button  id="addToCartBtn" type="button" class="positive" disabled="disabled">
				<spring:theme code="text.addToCart" var="addToCartText"/>
				<spring:theme code="basket.add.to.basket" />
			</button>
		</div>
		

</div>
  