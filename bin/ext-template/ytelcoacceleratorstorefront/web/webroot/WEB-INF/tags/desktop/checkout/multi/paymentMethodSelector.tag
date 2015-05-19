<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="paymentMethods" required="true" type="java.util.List" %>
<%@ attribute name="selectedPaymentMethodId" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/desktop/checkout/multi" %>

<table id="payment_details_modal">
	<thead>
		<tr>
			<th id="header1"class="pad_left"/>
			<th id="header2" class="pad_left" ><spring:theme code="checkout.multi.paymentMethod.savedCards.paymentCard"/></th>
			<th id="header3" class="pad_left" ><spring:theme code="checkout.multi.paymentMethod.savedCards.billingAddress"/></th>
		</tr>
	</thead>
	<tbody id="saved_cards_tbody">
		<c:forEach items="${paymentMethods}" var="paymentMethod" varStatus="status">
			<multi-checkout:paymentMethodDetails paymentMethod="${paymentMethod}" isSelected="${paymentMethod.id eq selectedPaymentMethodId}" count="${status.count}"/>
		</c:forEach>
	</tbody>
</table>