<%@ page trimDirectiveWhitespaces="true" contentType="application/json" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<json:object>
	<json:object name="cartData">
		<json:property name="total" value="${cartData.totalPrice.value}"/>
		<json:array name="products" items="${cartData.entries}" var="cartEntry">
			<json:object>
				<json:property name="sku" value="${cartEntry.product.code}"/>
				<json:property name="name" value="${cartEntry.product.name}"/>
				<json:property name="qty" value="${cartEntry.quantity}"/>

				<json:property name="price" value="${cartEntry.totalPrice.value}"/>

				<json:array name="categories" items="${cartEntry.product.categories}" var="category">
					<json:property value="${category.name}"/>
				</json:array>
			</json:object>
		</json:array>

	</json:object>
	
	<json:property name="cartPopupHtml" escapeXml="false">
		<spring:theme code="text.addToCart" var="addToCartText"/>
		<c:url value="/cart" var="cartUrl"/>
		<c:url value="/cart/checkout" var="checkoutUrl"/>

		<div class="title">
			<theme:image code="img.addToCartIcon" alt="${addToCartText}" title="${addToCartText}"/>
			<a href="#" tabindex="1"><h3><spring:theme code="basket.added.to.basket" /></h3></a>
			<a href="#" class="close" id="add_to_cart_close" tabindex="1"></a>
		</div>

		<c:forEach items="${modifiedCartData}" var="modifiedEntry">
        <c:url value="${modifiedEntry.entry.product.url}" var="entryProductUrl"/>
		<div class="cart_modal_popup">
		    <div class="cart_popup_error_msg"><spring:theme code="${errorMsg}" /></div>
			<div class="prod_image">
                <a href="${entryProductUrl}" tabindex="1">
                    <product:productPrimaryImage product="${modifiedEntry.entry.product}" format="cartIcon"/>
                </a>
			</div>
			<div class="prod_info">
                <a href="${entryProductUrl}" tabindex="1"><p class="prod_name">${modifiedEntry.entry.product.name}</p></a>

				<p class="prod_price"><format:price priceData="${modifiedEntry.entry.totalPrice}"/></p>

				<p class="prod_quantity"><span class="product-variant-label"><spring:message code="popup.cart.quantity"/></span>${modifiedEntry.entry.quantity}</p>
				<p class="prod_options">
					<c:forEach items="${modifiedEntry.entry.product.baseOptions}" var="baseOptions">
						<c:forEach items="${baseOptions.selected.variantOptionQualifiers}" var="baseOptionQualifier">
							<c:if test="${baseOptionQualifier.qualifier eq 'style' and not empty baseOptionQualifier.image.url}">
								<span class="prod_color"><span class="product-variant-label"><spring:theme code="product.variants.colour"/></span><img src="${baseOptionQualifier.image.url}"/></span>
							</c:if>
							<c:if test="${baseOptionQualifier.qualifier eq 'size'}">
								<span class="prod_size"><span class="product-variant-label"><spring:theme code="product.variants.size"/></span>${baseOptionQualifier.value}</span>
							</c:if>
						</c:forEach>
					</c:forEach>
				</p>
			</div>
		</div>
	</c:forEach>

		<div class="links">
			<a href="${cartUrl}" class="neutral large" tabindex="1">
				<spring:theme code="basket.view.basket" />
			</a>
			<a href="${checkoutUrl}" class="positive large" tabindex="1">
				<theme:image code="img.addToCartIcon" alt="${addToCartText}" title="${addToCartText}"/>
				<spring:theme code="checkout.checkout" />
			</a>
		</div>
	</json:property>
</json:object>
