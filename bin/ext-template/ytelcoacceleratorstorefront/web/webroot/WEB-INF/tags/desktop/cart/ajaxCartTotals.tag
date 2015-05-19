<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<script id="cartTotalsTemplate" type="text/x-jquery-tmpl">

	<dl class="order_totals">
		<dt><spring:theme code="basket.page.totals.subtotal"/></dt>
		<dd>{{= subTotal.formattedValue}}</dd>
		<dt class="savings"><spring:theme code="basket.page.totals.savings"/></dt>
		<dd class="savings">{{= totalDiscounts.formattedValue}}</dd>
		{{if deliveryCost}}
			<dt><spring:theme code="basket.page.totals.delivery"/></dt>
			<dd>
				{{if deliveryCost.value > 0}}
					{{= deliveryCost.formattedValue}}
				{{else}}
					<spring:theme code="basket.page.free"/>
				{{/if}}
			</dd>
		{{/if}}
		<dt class="total"><spring:theme code="basket.page.totals.total"/></dt>
		<dd class="total">{{= totalPrice.formattedValue}}</dd>
	</dl>
	{{if !net}}
		<p><spring:theme code="basket.page.totals.grossTax" arguments="{{= totalTax.formattedValue}}" argumentSeparator="!!!!" /></p>
	{{/if}}

</script>

<div class="item_container_holder">
	<div class="title_holder">
		<div class="title">
			<div class="title-top">
				<span></span>
			</div>
		</div>
		<h2><spring:theme code="order.order.totals" /></h2>
	</div>
	<div class="item_container" id="cart_totals_div">
	<!-- TELCO START -->
		<table class="cart-total">
			<tbody>
				<tr class="cart-total-subtotal-row">
				<td class="cart-bundle-package" colspan="3">
					<spring:theme code="basket.page.totals.subtotal"/>	
				</td>
				<ycommerce:testId code="Order_Totals_Subtotal">
						
						<c:forEach items="${cartData.totals}" var="entry">
						 <td class="cart-bundle-itemPrice">
							<format:price priceData="${entry.subTotal}"/> 
						</td>
						</c:forEach>
					</ycommerce:testId>
				</tr>
				 
				
				<tr class="cart-total-savings-row">
						<td class="cart-bundle-package"><spring:theme code="basket.page.totals.savings"/></td>
						
							<ycommerce:testId code="Order_Totals_Savings">
							<c:forEach var="entry" items="${cartData.orderPrices}">
								 <td class="cart-bundle-itemPrice">
								  
								   		<format:price priceData="${entry.totalDiscounts}"/>
								     
								</td>
							</c:forEach>
							</ycommerce:testId>
						
						
					</tr>	
			
				<tr class="cart-total-delivery-row">
					<td class="cart-bundle-package">
						<spring:theme code="basket.page.totals.delivery"/>	
					</td>
					<c:forEach items="${cartData.totals}" var="entry">
						 <td class="cart-bundle-itemPrice">
						    <format:price priceData="${entry.deliveryCost}" displayFreeForZero="TRUE"/>
						</td>
					</c:forEach>
				</tr>
			<c:if test="${cartData.net}">
				<tr class="cart-total-tax-row">
					<td class="cart-bundle-itemPrice">
					<spring:theme code="basket.page.totals.netTax"/>
					</td>
					<td class="cart-bundle-itemPrice"><format:price priceData="${cartData.totalTax}"/></td>
				</tr>
			</c:if>
			
			<tr class="cart-total-total-row">
			 <td class="cart-bundle-package">
			 	<spring:theme code="basket.page.totals.total"/><format:price priceData="${cartData.totalTax}"/>
			 </td>
			 <ycommerce:testId code="cart_totalPrice_label">
				<c:forEach items="${cartData.totals}" var="entry">
					<td class="cart-bundle-itemPrice">
						<format:price priceData="${entry.totalPrice}"/>  
					</td>
				</c:forEach>
				
				</ycommerce:testId>
			
			</tr>
			</tbody>
		</table>

		<c:if test="${not cartData.net}">
			<p>
				<ycommerce:testId code="checkout_tax_label">
					<spring:theme code="basket.page.totals.grossTax" arguments="${cartData.totalTax.formattedValue}" argumentSeparator="!!!!" />
				</ycommerce:testId>
			</p>
		</c:if>
	</div>
</div>
