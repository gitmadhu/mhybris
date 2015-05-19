<%@ page trimDirectiveWhitespaces="true" contentType="application/json" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="json" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>

{
	"cartData": {
		"total":	"${cartData.totalPrice.value}",
		"products":	[ <c:forEach items="${cartData.entries}" var="cartEntry" varStatus="status">
						{
							"code":			"${cartEntry.product.code}",
							"name":			"<c:out value='${cartEntry.product.name}' />",
							"quantity":		"${cartEntry.quantity}",
							"price":		"${cartEntry.basePrice.value}",
							"categories":	[<c:forEach items="${cartEntry.product.categories}" var="category" varStatus="categoryStatus">
												"<c:out value='${category.name}' />"<c:if test="${not categoryStatus.last}">,</c:if>
											</c:forEach>]
						}<c:if test="${not status.last}">,</c:if>
					</c:forEach>]
	},

	"cartGlobalMessagesHtml" : "<spring:escapeBody javaScriptEscape="true"><common:globalMessages/></spring:escapeBody>"
	,

	"addToCartLayer": "<spring:escapeBody javaScriptEscape="true">
						<spring:theme code="text.addToCart" var="addToCartText"/>
						<c:url value="/cart" var="cartUrl"/>
						
					<div id="addToCartLayer">										
						<div class="headline">
							<spring:theme code="basket.added.to.basket" />
							<c:if test="${numberShowing > 0 and fn:length(products) > numberShowing}">
								<p class="legend">
									<spring:theme code="popup.cart.showing" arguments="${numberShowing},${fn:length(products)}"/>
									<c:if test="${fn:length(products) > numberShowing}">
										<a href="${cartUrl}">Show All</a>
									</c:if>
								</p>
							</c:if>
						</div>

						<c:forEach items="${modifications}" var="modification" end="${numberShowing - 1}">
                            <c:set var="product" value="${modification.entry.product}" />
                            <c:set var="entry" value="${modification.entry}" />
							<div class="popupCartItem">
								<div class="itemThumb"><product:productPrimaryImage product="${product}" format="cartIcon"/></div>
								<div class="itemDesc">
									<div class="itemName"><c:out value="${product.name}" /></div>

										<c:forEach items="${product.baseOptions}" var="baseOptions">
											<c:forEach items="${baseOptions.selected.variantOptionQualifiers}" var="baseOptionQualifier">
												<c:if test="${baseOptionQualifier.qualifier eq 'style' and not empty baseOptionQualifier.image.url}">
													<div class="itemColor">
														<span class="label"><spring:theme code="product.variants.colour"/></span>
														<img src="${baseOptionQualifier.image.url}"  alt="${baseOptionQualifier.value}" title="${baseOptionQualifier.value}"/>
													</div>
												</c:if>
												<c:if test="${baseOptionQualifier.qualifier eq 'size'}">
													<div class="itemSize">
														<span class="label"><spring:theme code="product.variants.size"/></span>
														${baseOptionQualifier.value}
													</div>
												</c:if>
											</c:forEach>
										</c:forEach>

									<div class="itemQuantity"><span class="label"><spring:theme code="popup.cart.quantity.added"/></span>${modification.quantityAdded}</div>
									<div class="itemPrice">
										<c:choose>
											<c:when test="${not empty product.variantType and (product.priceRange.minPrice.value ne product.priceRange.maxPrice.value)}">
												<format:price priceData="${product.priceRange.minPrice}"/> - <format:price priceData="${product.priceRange.maxPrice}"/>
											</c:when>
											<c:otherwise>
												<format:price priceData="${entry.basePrice}"/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="links"><a href="${cartUrl}" class="button positive"><spring:theme code="checkout.checkout" /></a></div>
					</div>
				</spring:escapeBody>"
}
