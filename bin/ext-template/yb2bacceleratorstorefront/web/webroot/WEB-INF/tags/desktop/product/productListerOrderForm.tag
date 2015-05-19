<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="filterSkus" required="false" type="java.util.List" %>

<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="productListItem clearfix">
	<product:productListerItemDetails product="${product}" skipSummary="true" />
	<form name="AddToCartOrderForm${product.code}" id="AddToCartOrderForm${product.code}" class="add_to_cart_order_form"
		  action="<c:url value="/cart/addGrid"/>" method="post" data-grid-confirm-message="${gridConfirmMessage}">
		<product:productOrderFormGrid product="${product}" showName="true" filterSkus="${filterSkus}"/>
	</form>
</div>