<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="single-checkout" tagdir="/WEB-INF/tags/desktop/checkout/single" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:url value="/checkout/single/summary/getCheckoutCart.json" var="getCheckoutCartUrl" />

<script type="text/javascript">
/*<![CDATA[*/
	$.blockUI.defaults.overlayCSS = {};
	$.blockUI.defaults.css = {};
	
	function refreshCartTotals(checkoutCartData)
	{
		$('#cart_totals_div').html($('#cartTotalsTemplate').tmpl(checkoutCartData));
	}
	
	function refreshPage(checkoutCartData)
	{
		//update delivery address, delivery method and payment sections, and cart totals section
		refreshDeliveryAddressSection(checkoutCartData);
		refreshDeliveryMethodSection(checkoutCartData);
		refreshPaymentDetailsSection(checkoutCartData);
		refreshCartTotals(checkoutCartData);
		updatePlaceOrderButton();
	}

	function getCheckoutCartDataAndRefreshPage()
	{
		$.getJSON('${getCheckoutCartUrl}', function(checkoutCartData) {refreshPage(checkoutCartData);});
	}
/*]]>*/
</script>

<div class="checkout_summary_flow">
	<single-checkout:summaryFlowDeliveryAddress deliveryAddress="${deliveryAddress}" />
	<single-checkout:summaryFlowDeliveryMode deliveryMode="${deliveryMode}" />
	<single-checkout:summaryFlowPayment paymentInfo="${paymentInfo}" />
</div>
