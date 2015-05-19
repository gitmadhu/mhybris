<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryAddress" required="true" type="de.hybris.platform.commercefacades.user.data.AddressData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="checkout_summary_flow_a complete" id="checkout_summary_deliveryaddress_div">
	<div class="item_container_holder">
		<ycommerce:testId code="checkout_deliveryAddressData_text">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="checkout.summary.deliveryAddress.header" htmlEscape="false"/><span></span></h2>
			</div>

			<div class="item_container">
				<ul>
					<li>${fn:escapeXml(deliveryAddress.title)}&nbsp;${fn:escapeXml(deliveryAddress.firstName)}&nbsp;${fn:escapeXml(deliveryAddress.lastName)}</li>
					<li>${fn:escapeXml(deliveryAddress.line1)}</li>
					<li>${fn:escapeXml(deliveryAddress.line2)}</li>
					<li>${fn:escapeXml(deliveryAddress.town)}</li>
					<li>${fn:escapeXml(deliveryAddress.postalCode)}</li>
					<li>${fn:escapeXml(deliveryAddress.country.name)}</li>
				</ul>
			</div>
		</ycommerce:testId>
	</div>

	<ycommerce:testId code="checkout_changeAddress_element">
		<a href="<c:url value="/checkout/multi/choose-delivery-address"/>" class="edit_complete change_address_button"><spring:theme code="checkout.summary.deliveryAddress.editDeliveryAddressButton"/></a>
	</ycommerce:testId>
</div>