<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="formElement"
	tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb"
	tagdir="/WEB-INF/tags/desktop/nav/breadcrumb"%>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld"%>
<%@ taglib prefix="multi-checkout"
	tagdir="/WEB-INF/tags/desktop/checkout/multi"%>
<%@ taglib prefix="payment" tagdir="/WEB-INF/tags/desktop/payment"%>

<c:url value="/checkout/multi/choose-payment-method"
	var="choosePaymentMethodUrl" />
<template:page pageTitle="${pageTitle}">
	<script type="text/javascript">
		/*<![CDATA[*/
		$(document).ready(function()
		{
			updateBillingAddressForm();

			$("#differentAddress").click(function()
			{
				updateBillingAddressForm();
			})

			bindCycleFocusEvent();
		})

		function bindCycleFocusEvent()
		{
			$('#lastInTheForm').blur(function()
			{
				$('#paymentDetailsForm [tabindex$="10"]').focus();
			})
		}

		function updateBillingAddressForm()
		{
			var newAddress = $('#differentAddress').attr("checked");
			if (newAddress)
			{
				$("#newBillingAddressFields :input").removeAttr('disabled');
			} else
			{
				$("#newBillingAddressFields :input").attr('disabled', 'disabled');
			}
		}
		/*]]>*/
	</script>

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}" />
	</div>
	<div id="globalMessages">
		<common:globalMessages />
	</div>
	<nav:accountNav selected="payment-details" />
	<div class="span-20 last cust_acc-page">
		<!-- telco change -->

		<div class="item_container_holder">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2>
					<spring:theme
						code="checkout.multi.paymentMethod.addPaymentDetails.header"
						text="Payment Details" />
				</h2>
			</div>
			<div class="item_container">
				<form:form method="post" commandName="paymentDetailsForm"
					class="create_update_payment_form">
					<payment:paymentMethodDetails />
				</form:form>
			</div>
		</div>
	</div>
</template:page>
