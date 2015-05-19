<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/desktop/checkout/multi" %>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/desktop/address" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %> 

<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<th><spring:theme code="checkout.order.settle.products.money" text=""/></th>
		<td>
			<ycommerce:testId code="Order_Totals_Subtotal">
			<format:price priceData="${cartData.subTotal}"/>
			</ycommerce:testId>
		</td>
	</tr>
	 <tr>
	  	<th><spring:theme code="checkout.order.settle.freight" text=""/></th>
	    <td><format:price priceData="${cartData.deliveryCost}" displayFreeForZero="TRUE"/></td>
	</tr>
	<tr>
		<th><spring:theme code="checkout.order.settle.vouche" text=""/></th>
	    <td><format:price priceData="${cartData.totalDiscounts}"/></td>
	</tr>
</table>
<p class="orderTotal clearfix"><spring:theme code="checkout.order.settle.should.pay.amount" text=""/>
	<span><format:price priceData="${cartData.totalPrice}"/></span>
</p>
