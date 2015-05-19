<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="paymentMethod" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
<%@ attribute name="isSelected" required="false" type="java.lang.Boolean" %>
<%@ attribute name="count" required="false" type="java.lang.Integer" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>

<c:url value="/checkout/multi/select-payment-method" var="selectPaymentMethodUrl"/>
<c:set value="${not empty paymentMethod and not empty paymentMethod.billingAddress}" var="billingAddressOk"/>

<tr class="existing_payment_details">
	<td headers="header1">
		<ul class="table_action_col_item">
			<li>
			<c:choose>
				<c:when test="${isSelected}">
					<theme:image code="img.iconSelected" alt="Selected"/>
				</c:when>
				<c:otherwise>
					<a id="paymentMethod_select_link_${count}" href="${selectPaymentMethodUrl}/?selectedPaymentMethodId=${paymentMethod.id}"><spring:theme code="checkout.multi.paymentMethod.savedCards.select"/></a>
				</c:otherwise>
			</c:choose>
			</li>
		</ul>
	</td>
	<td headers="header2">
		<ul>
			<li>${fn:escapeXml(paymentMethod.cardNumber)}</li>
			<li>${fn:escapeXml(paymentMethod.cardTypeData.name)}</li>
			<li><spring:theme code="checkout.multi.paymentMethod.paymentDetails.expires" arguments="${fn:escapeXml(paymentMethod.expiryMonth)},${fn:escapeXml(paymentMethod.expiryYear)}"/></li>
		</ul>
	</td>
	<td headers="header3" >
		<ul>
			<c:if test="${billingAddressOk}">
				<li><c:if test="${not empty paymentInfo.billingAddress.title}">${fn:escapeXml(paymentMethod.billingAddress.title)}&nbsp;</c:if>${fn:escapeXml(paymentMethod.billingAddress.firstName)}&nbsp;${fn:escapeXml(paymentMethod.billingAddress.lastName)}</li>
				<li>${fn:escapeXml(paymentMethod.billingAddress.line1)}</li>
				<li>${fn:escapeXml(paymentMethod.billingAddress.line2)}</li>
				<li>${fn:escapeXml(paymentMethod.billingAddress.town)}</li>
				<li>${fn:escapeXml(paymentMethod.billingAddress.postalCode)}</li>
			</c:if>
		</ul>
	</td>
</tr>
