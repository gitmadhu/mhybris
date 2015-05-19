<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div class="item_container_holder">
	<div class="title_holder">
		<div class="title">
			<div class="title-top">
			<span></span>
			</div>
		</div>
		<h2><spring:theme code="order.order.totals" /></h2>
	</div>
	<div class="item_container">
		<!--dl class="order_totals"-->

		<table class="cart-total">
            <thead class="hidden">
                <tr>
                    <td></td>
                    <c:forEach items="${cartData.orderPrices}" var="tpentry" varStatus="rowCounter">
                        <th id="header-lr${rowCounter.count}" scope="col"><span class="hidden">${tpentry.billingTime.name}</span></th>
                    </c:forEach>
                </tr>
            </thead>
			<tbody>
			    
				<tr class="cart-total-subtotal-row">
				<th class="cart-bundle-package" colspan="3" scope="row">
					<spring:theme code="basket.page.totals.subtotal"/>	
				</th>
				<ycommerce:testId code="Order_Totals_Subtotal">
						
						<c:forEach items="${cartData.orderPrices}" var="entry">
						<td class="cart-bundle-itemPrice">
                            <format:price priceData="${entry.subTotal}"/>
						</td>
						</c:forEach>
					</ycommerce:testId>
				</tr>

                <tr class="cart-total-savings-row">
                    <th class="cart-bundle-package" colspan="3" scope="row">
                        <spring:theme code="basket.page.totals.savings"/>
                    </th>
                    <ycommerce:testId code="Order_Totals_Savings">
                    <c:forEach var="entry" items="${cartData.orderPrices}">
                         <td class="cart-bundle-itemPrice">
                            <format:price priceData="${entry.totalDiscounts}"/>
                        </td>
                    </c:forEach>
                    </ycommerce:testId>
                </tr>

				<tr class="cart-total-delivery-row">
					<th class="cart-bundle-package" colspan="3" scope="row">
						<spring:theme code="basket.page.totals.delivery"/>	
					</th>
					<c:forEach items="${cartData.orderPrices}" var="entry">
						 <td class="cart-bundle-itemPrice">
						    <format:price priceData="${entry.deliveryCost}" displayFreeForZero="TRUE"/>
						</td>
					</c:forEach>
				</tr>

			<c:if test="${not cartData.net}">
				<tr class="cart-total-tax-row">
					<th class="cart-bundle-package" colspan="3" scope="row">
						<spring:theme code="basket.page.totals.grossTax"/>
					</th>
					<c:forEach items="${cartData.orderPrices}" var="entry">
						 <td class="cart-bundle-itemPrice">
						    <format:price priceData="${entry.totalTax}" displayFreeForZero="TRUE"/>
						</td>
					</c:forEach>

				</tr>
			</c:if>
			
			<tr class="cart-total-total-row">
			 <th class="cart-bundle-package" colspan="3" scope="row">
			 	<spring:theme code="basket.page.totals.total"/>
			 </th>
			 <ycommerce:testId code="cart_totalPrice_label">
				<c:forEach items="${cartData.orderPrices}" var="entry">
					<td class="cart-bundle-itemPrice">
						<format:price priceData="${entry.totalPrice}"/>  
					</td>
				</c:forEach>
				
				</ycommerce:testId>
			
			</tr>

		         <tr class="cart-totals-headers-row">
		            <td colspan="3">
		            </td>
		         	<c:forEach items="${cartData.orderPrices}" var="tpentry" varStatus="rowCounter">
					      <th headers="header-lr${rowCounter.count}" class="cart-bundle-itemPrice" scope="col">
					      	${tpentry.billingTime.name}
						  </th>
					</c:forEach>
		         </tr>

                <c:if test="${cartData.net}">
                    <tr class="cart-total-tax-row">
                        <td>
                            <spring:theme code="basket.page.totals.netTax"/>
                        </td><td/><td/>
                        <c:forEach items="${cartData.orderPrices}" var="entry">
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