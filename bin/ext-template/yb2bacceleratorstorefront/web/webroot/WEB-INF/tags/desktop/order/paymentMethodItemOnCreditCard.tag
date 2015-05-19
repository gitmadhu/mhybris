<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="left">
	<ul class="pad_none">
		<li>${fn:escapeXml(order.paymentInfo.cardNumber)}</li>
		<li>${fn:escapeXml(order.paymentInfo.cardTypeData.name)}</li>
		<li><spring:theme code="paymentMethod.paymentDetails.expires" arguments="${fn:escapeXml(order.paymentInfo.expiryMonth)},${fn:escapeXml(order.paymentInfo.expiryYear)}" /></li>
	</ul>
</div>
<div class="left">
	<ul>
		<li><b><spring:theme code="paymentMethod.billingAddress.header" /></b></li>
		<li>${fn:escapeXml(order.paymentInfo.billingAddress.title)}&nbsp;${fn:escapeXml(order.paymentInfo.billingAddress.firstName)}&nbsp;${fn:escapeXml(order.paymentInfo.billingAddress.lastName)}</li>
		<li>${fn:escapeXml(order.paymentInfo.billingAddress.line1)}</li>
		<li>${fn:escapeXml(order.paymentInfo.billingAddress.line2)}</li>
		<li>${fn:escapeXml(order.paymentInfo.billingAddress.town)}</li>
		<li>${fn:escapeXml(order.paymentInfo.billingAddress.postalCode)}</li>
		<li>${fn:escapeXml(order.paymentInfo.billingAddress.country.name)}</li>
	</ul>
</div>


