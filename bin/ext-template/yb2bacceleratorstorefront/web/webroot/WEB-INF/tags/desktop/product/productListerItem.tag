<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="isOrderForm" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<spring:theme code="text.addToCart" var="addToCartText"/>
<c:url var="productUrl" value="${product.multidimensional and not empty product.firstVariantUrl ? product.firstVariantUrl : product.url}" />

<c:set value="${not empty product.potentialPromotions}" var="hasPromotion"/>

<div class="productListItem${hasPromotion ? ' productListItemPromotion' : ''}">
    <ycommerce:testId code="test_searchPage_wholeProduct">
        <a href="${productUrl}" title="${fn:escapeXml(product.name)}" class="productMainLink">

        <div class="thumb">
            <product:productPrimaryImage product="${product}" format="product"/>
            <c:if test="${not empty product.potentialPromotions and not empty product.potentialPromotions[0].productBanner}">
                <img class="promo" src="${product.potentialPromotions[0].productBanner.url}" alt="${product.potentialPromotions[0].description}" title="${product.potentialPromotions[0].description}"/>
            </c:if>
        </div>

        <ycommerce:testId code="searchPage_price_label_${product.code}">
            <div class="price"><product:productListerItemPrice product="${product}" /></div>
        </ycommerce:testId>


        <ycommerce:testId code="searchPage_productName_link_${product.code}">
            <div class="head">${fn:escapeXml(product.name)}</div>
        </ycommerce:testId>
        <c:if test="${not empty product.averageRating}">
            <product:productStars rating="${product.averageRating}" />
        </c:if>
        <c:if test="${not empty product.summary}">
            <div class="details">${fn:escapeXml(product.summary)}</div>
        </c:if>
        <product:productListerClassifications product="${product}"/>



        <ycommerce:testId code="searchPage_addToCart_button_${product.code}">
            <c:set var="buttonType">submit</c:set>
            <c:choose>
                <c:when test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">
                    <c:set var="buttonType">button</c:set>
                    <spring:theme code="text.addToCart.outOfStock" var="addToCartText"/>
                </c:when>
            </c:choose>

            </a>
            <div class="cart clearfix">
                <c:choose>
                    <%-- Verify if products is a multidimensional product --%>
                    <c:when test="${product.multidimensional}">
                        <c:choose>
                            <c:when test="${not empty product.firstVariantUrl}">
                                <c:url var="backToProductUrl" value="${product.firstVariantUrl}" />
                                <c:url var="productOrderFormUrl" value="${product.firstVariantUrl}/orderForm"/>
                            </c:when>
                            <c:otherwise>
                                <c:url var="backToProductUrl" value="${productUrl}" />
                                <c:url var="productOrderFormUrl" value="${product.url}/orderForm"/>
                            </c:otherwise>
                        </c:choose>
                        <a href="${backToProductUrl}" class="button right" ><spring:theme code="product.view.details" /></a>


                        <sec:authorize ifAnyGranted="ROLE_CUSTOMERGROUP">
                            <a href="${productOrderFormUrl}"  class="button right"><spring:theme code="order.form" /></a>

                        </sec:authorize>

                    </c:when>
                    <c:otherwise>
                        <c:set var="buttonType">submit</c:set>
                        <c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' or empty product.price}">
                            <c:set var="buttonType">button</c:set>
                            <spring:theme code="text.addToCart.outOfStock" var="addToCartText"/>
                        </c:if>
                        <c:if test="${empty isOrderForm || not isOrderForm}">
                            <form id="addToCartForm${product.code}" action="<c:url value="/cart/add"/>" method="post" class="add_to_cart_form">
                                <input type="hidden" name="productCodePost" value="${product.code}"/>
                                <button type="${buttonType}" class="addToCartButton <c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">out-of-stock</c:if>" <c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' }"> disabled="disabled" aria-disabled="true"</c:if>>${addToCartText}</button>
                            </form>
                        </c:if>
                        <c:if test="${not empty isOrderForm && isOrderForm}">
                            <label for="qty"><spring:theme code="basket.page.quantity" /></label>
                            <input type=hidden id="productPrice[${sessionScope.skuIndex}]" value="${product.price.value}" />
                            <input type="hidden" class="${product.code} sku"  name="cartEntries[${sessionScope.skuIndex}].sku" id="cartEntries[${sessionScope.skuIndex}].sku" value="${product.code}" />
                            <input type="text" maxlength="3"  size="1" id="cartEntries[${sessionScope.skuIndex}].quantity" name="cartEntries[${sessionScope.skuIndex}].quantity" class="sku-quantity" value="0">

                            <c:set var="skuIndex" scope="session" value="${sessionScope.skuIndex + 1}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>

                <c:if test="${isOrderForm and !product.multidimensional}">
                    <div class="productFutureAvailability">
                        <product:productFutureAvailability product="${product}" futureStockEnabled="${futureStockEnabled}" />
                    </div>
                </c:if>

            </div>
        </ycommerce:testId>
    </ycommerce:testId>
</div>
