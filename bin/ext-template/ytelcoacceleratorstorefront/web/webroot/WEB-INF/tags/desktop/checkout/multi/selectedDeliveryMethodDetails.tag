<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="deliveryMethod" required="true" type="de.hybris.platform.commercefacades.order.data.DeliveryModeData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>


<c:url value="/checkout/multi/choose-delivery-method" var="changeDeliveryMethodUrl"/>

<div class="delivery_method">
	<ul>
		<li>${deliveryMethod.name}</li>
		<li>${deliveryMethod.description}</li>
		<li>${deliveryMethod.deliveryCost.formattedValue}</li>
	</ul>
	<ycommerce:testId code="selectedDeliveryMethodDetails_change_button">
		<a href="${changeDeliveryMethodUrl}" class="right"><spring:theme code="checkout.multi.deliveryMethod.edit"/></a>
	</ycommerce:testId>
</div>
