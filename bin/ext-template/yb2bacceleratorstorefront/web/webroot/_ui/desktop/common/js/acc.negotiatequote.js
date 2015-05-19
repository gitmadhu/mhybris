ACC.negotiatequote = {

	bindAll: function()
	{
		
		if(typeof cartDataquoteAllowed != 'undefined')
		{
			$("#requestQuoteButton").attr('quoteAllowed',cartDataquoteAllowed);
			this.bindToCancelQuoteClick();
			this.updateRequestQuoteButton();
			this.bindToProceedButtonClick();
			this.bindToRequestQuoteButtonClick();
			this.bindToQuoteDescriptionValidation();
		}
		
	},
	
	displayNegotiateQuoteDiv: function() 
	{
		$("#requestQuoteButton").addClass('pressed');
		$('#negotiate-quote-div').show();
		$(".place-order").attr('disabled', true);
		$("#scheduleReplenishmentButton").attr('disabled', true);
		return false;	
	},
	
	bindToCancelQuoteClick: function()
	{
		$('#cancel-quote-negotiation').click(function()
		{
			ACC.negotiatequote.cancelQuoteNegotiationEvent();
		});
	},
	
	cancelQuoteNegotiationEvent: function()
	{
		$("#requestQuoteButton").removeClass('pressed');
		$('#negotiate-quote-div').hide();
		$('#quoteRequestDescription').value = "";
		$("#negotiateQuote").val(false);
		ACC.placeorder.updatePlaceOrderButton();
		ACC.negotiatequote.updateRequestQuoteButton();
		ACC.replenishment.updateScheduleReplenishmentButton();
	},

	bindToProceedButtonClick: function()
	{
		$('#negotiateQuoteButton').click(function()
		{
			$("#negotiateQuote").val(true);
			ACC.placeorder.placeOrderWithSecurityCode();
			return false;
		});
	},
	
	bindToRequestQuoteButtonClick: function()
	{
		$('#requestQuoteButton').click(function()
		{
			$('#requestQuoteButton').addClass("pressed");;
			ACC.negotiatequote.displayNegotiateQuoteDiv();
			return false;
		});
	},
	
	bindToQuoteDescriptionValidation: function()
	{
		$('#quoteRequestDescription[maxlength]').keyup(function(){  

	        var limit = parseInt($(this).attr('maxlength'));  
	        var text = $(this).val();  
	        var chars = text.length;  
	  
	        if(chars > limit){  
	            var new_text = text.substr(0, limit);  
	            $(this).val(new_text);  
	        }  
	    }); 
	},
		
	updateRequestQuoteButton: function()
	{
		var paymentType = $("#checkout_summary_paymentType_div").hasClass("complete");
		var deliveryAddress = $("#checkout_summary_deliveryaddress_div").hasClass("complete");
		var deliveryMode = $("#checkout_summary_deliverymode_div").hasClass("complete");
		var costCenter = $('#checkout_summary_costcenter_div').hasClass("complete");
		var paymentDetails = $("#checkout_summary_payment_div").hasClass("complete")
		var selectedPaymentType = $("input:radio[name='PaymentType']:checked").val() != 'CARD';
		var costCenterSelected = $("#CostCenter option:selected")[0].value != '';
		var quoteAllowed = 'true' == $("#requestQuoteButton").attr("quoteAllowed");
		
		if (quoteAllowed && paymentType && deliveryAddress && deliveryMode && (costCenter || paymentDetails) && selectedPaymentType
			&& costCenterSelected)
		{
			$("#requestQuoteButton").removeAttr('disabled');
		}
		else
		{
			$("#requestQuoteButton").attr('disabled', true);
		}

		if ($("#requestQuoteButton").hasClass("pressed"))
		{
			$(".place-order").attr('disabled', true);
			$("#scheduleReplenishmentButton").attr('disabled', true);
		}
	}
	
		
	

};

$(document).ready(function()
{
	if (typeof negotiateQuote !== 'undefined' && negotiateQuote)
	{
		ACC.negotiatequote.displayNegotiateQuoteDiv();

		// Used in Account Quote Management page
		$('#negotiate-quote-div-label-add-comment').show();
	}

	ACC.negotiatequote.bindAll();
});








