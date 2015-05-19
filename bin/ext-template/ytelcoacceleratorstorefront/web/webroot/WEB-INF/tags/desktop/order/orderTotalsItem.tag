<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<%@ attribute name="containerCSS" required="false" type="java.lang.String" %>

<div class="item_container_holder ${containerCSS}">
	<div class="title_holder">
		<div class="title">
			<div class="title-top">
				<span></span>
			</div>
		</div>
		<h2><spring:theme code="text.account.order.orderTotals" text="Order Totals"/></h2>
	</div>
	<div class="item_container">
		<table class="order_totals">
            <thead>
            </thead>
			<tbody>
			    
				<tr class="cart-total-subtotal-row">
                    <td class="cart-bundle-package">
                        <spring:theme code="text.account.order.subtotal" text="Subtotal:"/>
                    </td>
                    <ycommerce:testId code="Order_Totals_Subtotal">
                        <c:forEach items="${order.orderPrices}" var="entry">
                         <td class="cart-bundle-itemPrice">
                            <format:price priceData="${entry.subTotal}"/>
                        </td>
                        </c:forEach>
                    </ycommerce:testId>
				</tr>

                <tr class="cart-total-savings-row">
                    <td class="cart-bundle-package"> <spring:theme code="text.account.order.savings" text="Savings:"/>
                    </td>
                    <ycommerce:testId code="Order_Totals_Savings">
                        <c:forEach var="entry" items="${order.orderPrices}">
                            <td class="cart-bundle-itemPrice">
                                <format:price priceData="${entry.totalDiscounts}"/>
                            </td>
                        </c:forEach>
                    </ycommerce:testId>
                </tr>

                <tr class="cart-total-delivery-row">
                    <td class="cart-bundle-package">
                        <spring:theme code="text.account.order.delivery" text="Delivery:"/>
                    </td>
                    <c:forEach items="${order.orderPrices}" var="entry">
                         <td class="cart-bundle-itemPrice">
                            <format:price priceData="${entry.deliveryCost}" displayFreeForZero="TRUE"/>
                        </td>
                    </c:forEach>
                </tr>

                <c:if test="${not orderData.net}">
                    <tr class="cart-total-tax-row">
                        <th class="cart-bundle-package" scope="row">
                            <spring:theme code="text.account.order.includesTax"/>
                        </th>
                        <c:forEach items="${order.orderPrices}" var="entry">
                             <td class="cart-bundle-itemPrice">
                                <format:price priceData="${entry.totalTax}" displayFreeForZero="TRUE"/>
                            </td>
                        </c:forEach>

                    </tr>
                </c:if>

                <tr class="cart-total-total-row">
                 <td class="cart-bundle-package">
                    <spring:theme code="text.account.order.total" text="Total:"/>
                 </td>
                 <ycommerce:testId code="cart_totalPrice_label">
                    <c:forEach items="${order.orderPrices}" var="entry">
                        <td class="cart-bundle-itemPrice">
                            <format:price priceData="${entry.totalPrice}"/>
                        </td>
                    </c:forEach>

                    </ycommerce:testId>
                </tr>

                <tr class="cart-totals-headers-row">
                    <th>
                    </th>
                    <c:forEach items="${order.orderPrices}" var="tpentry" varStatus="rowCounter">
                        <th headers="header${rowCounter.count}">
                            <c:choose>
                                <c:when test="${not empty tpentry.billingTime.nameInOrder}">
                                    ${tpentry.billingTime.nameInOrder}
                                </c:when>
                                <c:otherwise>
                                    ${tpentry.billingTime.name}
                                </c:otherwise>
                            </c:choose>
                        </th>
                    </c:forEach>
                </tr>

                <c:if test="${orderData.net}">
                    <tr class="cart-total-tax-row">
                        <td>
                            <spring:theme code="basket.page.totals.netTax"/>
                        </td>
                        <c:forEach items="${orderData.orderPrices}" var="entry">
                            <td class="rightAlign">
                                <format:price priceData="${entry.totalTax}" displayFreeForZero="TRUE"/>
                            </td>
                        </c:forEach>
                    </tr>
                </c:if>
			</tbody>
		</table>
	</div>
</div>