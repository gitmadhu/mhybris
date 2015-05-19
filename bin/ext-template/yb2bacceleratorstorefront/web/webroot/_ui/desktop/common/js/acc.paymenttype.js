ACC.paymenttype = {

	bindAll: function()
	{
		this.bindToPaymentTypeSelection();
		this.bindToPurchaseOrderNumberInput();
	},

	bindToPaymentTypeSelection: function()
	{
		$("input:radio[name='PaymentType']").change(function()
		{
			$('#checkout_summary_paymentType_div').removeClass('complete');
			var paymentTypeSelected = $("input:radio[name='PaymentType']:checked").val();
			$.postJSON(setPaymentTypeURL, {paymentType: paymentTypeSelected}, ACC.paymenttype.summaryFlowAfterPaymentTypeSetSuccess);
		});
	},

	bindToPurchaseOrderNumberInput: function()
	{
		$("#PurchaseOrderNumber").focusout(function()
		{
			var purchaseOrderNumber = $("input[name='PurchaseOrderNumber']").val();
			$.postJSON(setPurchaseOrderNumberURL, {purchaseOrderNumber: purchaseOrderNumber}, ACC.paymenttype.summaryFlowAfterPurchaseOrderNumberSuccess);
		});
	},

	summaryFlowAfterPaymentTypeSetSuccess: function(checkoutCartData) 
	{
		ACC.paymenttype.markPaymentTypeSectionAsCompleted();
		ACC.paymenttype.hideAndShowRequiredDiv( checkoutCartData.paymentType.code);
		ACC.costcenter.refreshCostCenterSection(checkoutCartData);
		ACC.address.refreshDeliveryAddressSection(checkoutCartData);
		ACC.deliverymode.refreshDeliveryMethodSection(checkoutCartData);
		ACC.refresh.refreshCartItems(checkoutCartData);
		ACC.refresh.refreshCartTotals(checkoutCartData);
		ACC.negotiatequote.cancelQuoteNegotiationEvent();
		ACC.replenishment.cancelReplenishmentEvent();
	},

	refreshPaymentTypeSection: function(checkoutCartData)
	{
			var paymentTypeFromCart =  checkoutCartData.paymentType.code;
		   	$("input:radio[name='PaymentType'][value="+paymentTypeFromCart+"]").attr('checked',true);
		   	$("input[name='PurchaseOrderNumber']").attr('value',checkoutCartData.purchaseOrderNumber);
		    ACC.paymenttype.markPaymentTypeSectionAsCompleted();
			ACC.paymenttype.hideAndShowRequiredDiv(checkoutCartData.paymentType.code);
	},

	summaryFlowAfterPurchaseOrderNumberSuccess: function(checkoutCartData) 
	{
		if ($("input:radio[name='PaymentType']:checked").val() != ''){
			$('#checkout_summary_paymentType_div').addClass('complete');
		}else{
			$('#checkout_summary_paymentType_div').removeClass('complete');
		}
	},

	markPaymentTypeSectionAsCompleted: function()
	{
		if ($("input:radio[name='PaymentType']:checked").val() != ''){
			$('#checkout_summary_paymentType_div').addClass('complete');
		}else{
			$('#checkout_summary_paymentType_div').removeClass('complete');
		}
	},

	hideAndShowRequiredDiv: function(paymentType)
	{
		if(paymentType == 'CARD'){
			$('#checkout_summary_costcenter_div').hide();
			$('#checkout_summary_payment_div').show();
		}else{
			$('#checkout_summary_payment_div').hide();
			$('#checkout_summary_costcenter_div').show();
		}
	}

};

$(document).ready(function()
{
	ACC.paymenttype.bindAll();
});



	
	
