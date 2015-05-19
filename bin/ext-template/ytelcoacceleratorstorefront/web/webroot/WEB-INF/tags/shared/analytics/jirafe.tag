<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty jirafeApiToken}">
<script type="text/javascript">
/* Jirafe */

<c:choose>
	<c:when test="${pageType.value == 'ProductSearch'}">
		var jirafe = <json:object>
			<json:property name="id" value="${jirafeSiteId}"/>
			<json:property name="baseUrl" value="${jirafeDataUrl}"/>
			<json:object name="search">
				<json:property name="keyword" value="${searchPageData.freeTextSearch}"/>
			</json:object>
		</json:object>;
	</c:when>
		
	<c:when test="${pageType.value == 'Product'}">
		var jirafe = <json:object>
			<json:property name="id" value="${jirafeSiteId}"/>
			<json:property name="baseUrl" value="${jirafeDataUrl}"/>
			<json:object name="product">
				<json:property name="sku" value="${product.code}"/>
				<json:property name="name" value="${product.name}"/>
				<json:property name="price" value="${product.price.value}"/>
				<json:array name="categories" items="${product.categories}" var="category">
					<json:property value="${category.name}"/>
				</json:array>
			</json:object>
		</json:object>;
	</c:when>
	
	<c:when test="${pageType.value == 'Category'}">
		var jirafe = <json:object>
			<json:property name="id" value="${jirafeSiteId}"/>
			<json:property name="baseUrl" value="${jirafeDataUrl}"/>
			<json:object name="category">
				<json:property name="name" value="${categoryName}"/>
			</json:object>
		</json:object>;
	</c:when>

	<c:when test="${pageType.value == 'Cart'}">
		var jirafe = <json:object>
			<json:property name="id" value="${jirafeSiteId}"/>
			<json:property name="baseUrl" value="${jirafeDataUrl}"/>
			<json:object name="cart">
				<json:property name="total" value="${cartData.totalPrice.value}"/>
				<json:array name="products" items="${cartData.entries}" var="entry">
					<json:object>
						<json:property name="sku" value="${entry.product.code}"/>
						<json:property name="name" value="${entry.product.name}"/>
						<json:property name="qty" value="${entry.quantity}"/>
						<json:property name="price" value="${entry.basePrice.value}"/>
						<json:array name="categories" items="${entry.product.categories}" var="category">
							<json:property value="${category.name}"/>
						</json:array>
					</json:object>
				</json:array>
			</json:object>
		</json:object>;
	</c:when>

	<c:when test="${pageType.value == 'OrderConfirmation'}">
		var jirafe = <json:object>
			<json:property name="id" value="${jirafeSiteId}"/>
			<json:property name="baseUrl" value="${jirafeDataUrl}"/>
			<json:object name="confirm">
				<json:property name="orderid" value="${orderData.code}"/>
				<json:property name="total" value="${orderData.totalPrice.value}"/>
				<json:property name="shipping" value="${orderData.deliveryCost.value}"/>
				<json:property name="tax" value="${orderData.totalTax.value}"/>
				<json:property name="discount" value="${orderData.totalDiscounts.value}"/>
				<json:property name="subtotal" value="${orderData.subTotal.value}"/>
				<json:array name="products" items="${orderData.entries}" var="entry">
					<json:object>
						<json:property name="sku" value="${entry.product.code}"/>
						<json:property name="name" value="${entry.product.name}"/>
						<json:property name="qty" value="${entry.quantity}"/>
						<json:property name="price" value="${entry.basePrice.value}"/>
						<json:array name="categories" items="${entry.product.categories}" var="category">
							<json:property value="${category.name}"/>
						</json:array>
					</json:object>
				</json:array>
			</json:object>
		</json:object>;
	</c:when>

	<c:otherwise>
		var jirafe = { "id": "${jirafeSiteId}", "baseUrl":"${jirafeDataUrl}" };
	</c:otherwise>
</c:choose>

(function(){
	var d=document,g=d.createElement('script'),s=d.getElementsByTagName('script')[0];
	g.type='text/javascript';g.defer=g.async=true;g.src=d.location.protocol+'//c.jirafe.com/jirafe.js';
	s.parentNode.insertBefore(g, s);
})();


<%-- JS method to dynamically update Jirafe with a new snapshot of the cart data --%>
function trackAddToCart_jirafe(cartData) {

	jirafe = {
		"force": "true",
		"id": "${jirafeSiteId}",
		"baseUrl": "${jirafeDataUrl}",
		"cart": {
			"total": cartData.total,
			"products": cartData.products
		}
	};

	(ff = function(){
		var d=document,g=d.createElement('script'),h=d.getElementsByTagName('head')[0];
		g.type='text/javascript';g.src=d.location.protocol+'//test-c.jirafe.com/jirafe.js';
		h.appendChild(g);
	})();
}

</script>
</c:if>