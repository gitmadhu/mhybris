<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<spring:theme code="text.addToCart" var="addToCartText"/>
<spring:theme code="text.popupCartTitle" var="popupCartTitleText"/>
<c:url value="/cart" var="cartUrl"/>
<c:url value="/cart/checkout" var="checkoutUrl"/>

<div class="title">
	<a href="#" class="close" id="ajax_cart_close"><spring:theme code="popup.cart.closeCartPopup"/></a>
</div>

<c:if test="${numberItemsInCart > 0}">
	<p class="legend">
	    <c:if test="${numberShowing > 0}">
		    <spring:theme code="popup.cart.showing"/>
		</c:if>
		<a href="${cartUrl}"><spring:theme code="popup.cart.showAll"/></a>
	</p>
</c:if>
<c:if test="${empty numberItemsInCart or numberItemsInCart == 0}">
	<div class="cart_modal_popup empty-popup-cart">
		<spring:message code="popup.cart.empty"/>
	</div>
</c:if>
<c:if test="${numberShowing > 0 }">
	<c:forEach items="${entries}" var="entry" end="${numberShowing - 1}">
        <c:url value="${entry.product.url}" var="entryProductUrl"/>
		<div class="cart_modal_popup">
			<div class="prod_image">
                <a href="${entryProductUrl}">
                    <product:productPrimaryImage product="${entry.product}" format="cartIcon"/>
                </a>
			</div>
			<div class="prod_info">
                <a href="${entryProductUrl}"><p class="prod_name">${entry.product.name}</p></a>

				<p class="prod_price" align="right">
					<c:choose>
						<c:when test="${entry.product.itemType eq 'ServicePlan' or entry.product.itemType eq 'ServiceAddOn' or entry.product.itemType eq 'SubscriptionProduct'}">
							<c:forEach items="${entry.orderEntryPrices}" var="orderEntryPrice">
							 	<c:if test="${orderEntryPrice.defaultPrice}">
							    	 <format:price priceData="${orderEntryPrice.totalPrice}"/>
							    </c:if>								
							</c:forEach>
							<br>${entry.product.subscriptionTerm.billingPlan.billingTime.name}
						</c:when>
						<c:otherwise>
							<format:price priceData="${entry.totalPrice}"/>
						</c:otherwise>
					</c:choose>
				</p>

				<p class="prod_quantity"><span class="product-variant-label"><spring:message code="popup.cart.quantity"/></span>${entry.quantity}</p>
				<p class="prod_options">
					<c:forEach items="${entry.product.baseOptions}" var="baseOptions">
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
</c:if>

<div  class="prod_cart-total">
	<span class="prod_cart-total-headline">
		<spring:message code="popup.cart.total"/>
	</span>
		<table cellpadding="0" cellspacing="0" class="prod_cart-total-table">				
			<c:forEach items="${cartData.orderPrices}" var="entry" varStatus="loopCount">
				  <tr>
				    <td>
				  		${entry.billingTime.name}
				  	</td>
				  	<td class="prod_cart-total-total">
				  	  <format:price priceData="${cartData.orderPrices[loopCount.count -1].totalPrice}"/>
				  	</td>					  	
				  </tr>
			</c:forEach>
		</table>
</div>

<c:if test="${not empty lightboxBannerComponent && lightboxBannerComponent.visible}">
	<div class="content_slot">
		<cms:component component="${lightboxBannerComponent}"/>
	</div>
</c:if>
