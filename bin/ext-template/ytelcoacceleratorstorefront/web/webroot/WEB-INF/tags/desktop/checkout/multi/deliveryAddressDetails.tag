<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryAddress" required="true" type="de.hybris.platform.commercefacades.user.data.AddressData" %>
<%@ attribute name="isSelected" required="false" type="java.lang.Boolean" %>
<%@ attribute name="count" required="false" type="java.lang.Integer" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>

<c:url value="/checkout/multi/select-delivery-address" var="selectDeliveryAddressUrl"/>
<c:url value="/checkout/multi/edit-delivery-address" var="editDeliveryAddressUrl"/>

<tr>
	<td headers="header1">
		<ul class="table_action_col_item">
			<li>
			<c:choose>
				<c:when test="${isSelected}">
					<theme:image code="img.iconSelected" alt="Selected"/>
				</c:when>
				<c:otherwise>
					<a id="deliveryAddress_select_link_${count}" href="${selectDeliveryAddressUrl}/?selectedAddressCode=${deliveryAddress.id}"><spring:theme code="checkout.multi.deliveryAddress.select" text="Select"/></a>
				</c:otherwise>
			</c:choose>
			</li>
			<li>
				<a id="deliveryAddress_edit_link_${count}" href="${editDeliveryAddressUrl}/?editAddressCode=${deliveryAddress.id}"><spring:theme code="checkout.multi.deliveryAddress.edit"/></a>
			</li>
		</ul>
	</td>
	<td headers="header2">
		<ul class="pad_left">
			<li>${fn:escapeXml(deliveryAddress.title)}&nbsp;${fn:escapeXml(deliveryAddress.firstName)}&nbsp;${fn:escapeXml(deliveryAddress.lastName)}</li>
			<li>${fn:escapeXml(deliveryAddress.line1)}</li>
			<li>${fn:escapeXml(deliveryAddress.line2)}</li>
			<li>${fn:escapeXml(deliveryAddress.town)}</li>
			<li>${fn:escapeXml(deliveryAddress.postalCode)}</li>
			<li>${fn:escapeXml(deliveryAddress.country.name)}</li>
		</ul>
	</td>
</tr>