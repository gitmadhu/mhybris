<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryAddress" required="true" type="de.hybris.platform.commercefacades.user.data.AddressData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url value="/checkout/multi/choose-delivery-address" var="changeDeliveryAddressUrl"/>

<div class="existing_address">
	<ul>
		<li>${fn:escapeXml(deliveryAddress.title)}&nbsp;${fn:escapeXml(deliveryAddress.firstName)}&nbsp;${fn:escapeXml(deliveryAddress.lastName)}</li>
		<li>${fn:escapeXml(deliveryAddress.line1)}</li>
		<li>${fn:escapeXml(deliveryAddress.line2)}</li>
		<li>${fn:escapeXml(deliveryAddress.town)}</li>
		<li>${fn:escapeXml(deliveryAddress.postalCode)}</li>
		<li>${fn:escapeXml(deliveryAddress.country.name)}</li>
	</ul>

	<ycommerce:testId code="selectedDeliveryAddressDetails_change_button">
		<a href="${changeDeliveryAddressUrl}" class="right"><spring:theme code="checkout.multi.deliveryAddress.edit"/></a>
	</ycommerce:testId>
</div>