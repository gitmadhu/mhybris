<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryAddresses" required="true" type="java.util.List" %>
<%@ attribute name="selectedAddressId" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/desktop/checkout/multi" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<table id="payment_details_modal">
	<thead>
		<tr>
			<th id="header1" class="pad_left" style="width:25%;"/>
			<th id="header2" class="pad_left"><spring:theme code="checkout.multi.deliveryAddress.address"/></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${deliveryAddresses}" var="deliveryAddress" varStatus="status">
			<multi-checkout:deliveryAddressDetails deliveryAddress="${deliveryAddress}" isSelected="${deliveryAddress.id eq selectedAddressId}" count="${status.count}" />
		</c:forEach>
	</tbody>
</table>