<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="paymentInfo" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
<%@ attribute name="requestSecurityCode" required="true" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function()
	{
		bindSecurityCodeWhatIs();
	});

	function bindSecurityCodeWhatIs()
	{
		var securityWhatText = "<spring:message code='checkout.summary.paymentMethod.securityCode.whatIsThis.description'/>";
		$('.security_code_what').bt(securityWhatText, {
			trigger: 'click',
			positions: 'bottom',
			fill: '#efefef',
			cssStyles: {
				fontSize: '11px'
			}
		});
	}
/*]]>*/
</script>

<c:set value="${not empty paymentInfo and not empty paymentInfo.billingAddress}" var="billingAddressOk"/>

<div class="checkout_summary_flow_c complete" id="checkout_summary_payment_div">
	<div class="item_container_holder">
		<ycommerce:testId code="checkout_paymentDetails_text">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="checkout.summary.paymentMethod.header" htmlEscape="false"/><span></span></h2>
			</div>

			<div class="item_container">
				<div class="left">
					<ul>
						<li>${fn:escapeXml(paymentInfo.cardNumber)}</li>
						<li>${fn:escapeXml(paymentInfo.cardTypeData.name)}</li>
						<li><spring:theme code="checkout.summary.paymentMethod.paymentDetails.expires" arguments="${paymentInfo.expiryMonth},${paymentInfo.expiryYear}"/></li>
					</ul>

					<c:if test="${requestSecurityCode}">
						<form>
							<dl>
								<dt><label for="SecurityCode"><spring:theme code="checkout.summary.paymentMethod.securityCode" />*</label></dt>
								<dd>
									<input type="text" class="text security" id="SecurityCode"/>
									<a href="#" class="security_code_what"><spring:theme code="checkout.summary.paymentMethod.securityCode.whatIsThis"/></a>
								</dd>
							</dl>
						</form>
					</c:if>

				</div>
				<div class="right">
					<ul>
						<c:if test="${billingAddressOk}">
							<li><spring:theme code="checkout.summary.paymentMethod.billingAddress.header"/></li>
							<li><c:if test="${not empty paymentInfo.billingAddress.title}">${fn:escapeXml(paymentInfo.billingAddress.title)}&nbsp;</c:if>${fn:escapeXml(paymentInfo.billingAddress.firstName)}&nbsp;${fn:escapeXml(paymentInfo.billingAddress.lastName)}</li>
							<li>${fn:escapeXml(paymentInfo.billingAddress.line1)}</li>
							<li>${fn:escapeXml(paymentInfo.billingAddress.line2)}</li>
							<li>${fn:escapeXml(paymentInfo.billingAddress.town)}</li>
							<li>${fn:escapeXml(paymentInfo.billingAddress.postalCode)}</li>
							<li>${fn:escapeXml(paymentInfo.billingAddress.country.name)}</li>
						</c:if>
					</ul>
				</div>
			</div>
		</ycommerce:testId>
	</div>

	<ycommerce:testId code="checkout_changePayment_element">
		<a href="<c:url value="/checkout/multi/choose-payment-method"/>" class="edit_complete change_payment_method_button"><spring:theme code="checkout.summary.paymentMethod.editPaymentMethod"/></a>
	</ycommerce:testId>
</div>