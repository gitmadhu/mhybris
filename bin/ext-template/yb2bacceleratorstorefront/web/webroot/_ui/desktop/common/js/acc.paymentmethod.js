ACC.paymentmethod = {

	bindAll: function ()
	{
		this.bindEditPaymentMethodButton();
		this.bindSecurityCodeWhatIs();
		
		$(document).on("change", "#cardType", ACC.paymentmethod.displayStartDateIssueNum);

	},

	bindSecurityCodeWhatIs: function ()
	{
		if (typeof securityWhatText != 'undefined')
		{
			$('.security_code_what').bt(securityWhatText, {
				trigger: 'click',
				positions: 'bottom',
				fill: '#efefef',
				cssStyles: {
					fontSize: '11px'
				}
			});
		}
	},

	bindEditPaymentMethodButton: function ()
	{
		$('div.checkout_summary_flow_b .change_payment_method_button').click(function ()
		{
			var paymentId = $(this).attr('data-payment_id');
			var options = {
				url: getPaymentDetailsFormUrl,
				data: {paymentId: paymentId, createUpdateStatus: ''},
				target: '#popup_checkout_add_edit_payment_method',
				type: 'POST',
				cache: false,
				success: function (data)
				{
					ACC.paymentmethod.bindCreateUpdatePaymentDetailsForm();

					// Show the payment method popup
					$.colorbox({inline: true, href: "#popup_checkout_add_edit_payment_method", height: false, overlayClose: false});
					$(document).on('cbox_complete', function ()
					{
						$.colorbox.resize();
					});

				},
				error: function (xht, textStatus, ex)
				{
					alert("Failed to get payment details. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				}
			};

			$(this).ajaxSubmit(options);

			return false;
		});
	},

	bindUseSavedCardButton: function ()
	{
		$('button.use_saved_card_button').click(function ()
		{
			$.ajax({
				url: getSavedCardsUrl,
				type: 'POST',
				cache: false,
				dataType: 'json',
				success: function (data)
				{
					// Fill the available saved cards
					$('#saved_cards_tbody').html($('#savedCardsTemplate').tmpl({savedCards: data}));
					ACC.paymentmethod.bindUseThisSavedCardButton();
					ACC.paymentmethod.bindEnterNewPaymentButton();

					// Show the saved cards popup
					$.colorbox({inline: true, href: "#popup_checkout_saved_payment_method", height: false, innerHeight: "530px"});
				},
				error: function (xht, textStatus, ex)
				{
					alert("Failed to get saved cards. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				}
			});

			return false;
		});
	},

	bindEnterNewPaymentButton: function ()
	{
		$('button.enter_new_payment_button').click(function ()
		{
			// Show the payment method popup
			$.colorbox({inline: true, href: "#popup_checkout_add_edit_payment_method", height: false, innerHeight: "930px"});
			return false;
		});
	},

	bindCreateUpdatePaymentDetailsForm: function ()
	{
		ACC.paymentmethod.bindUseSavedCardButton();

		$('.create_update_payment_form').each(function ()
		{
			var options = {
				type: 'POST',
				beforeSubmit: function ()
				{
					$('#popup_checkout_add_edit_payment_method').block({ message: "<img src='" + spinnerUrl + "' />" });
					$.colorbox.toggleLoadingOverlay();
				},
				success: function (data)
				{
					$('#popup_checkout_add_edit_payment_method').html(data);
					var status = $('.create_update_payment_id').attr('status');
					if (status != null && "success" == status.toLowerCase())
					{
						ACC.refresh.getCheckoutCartDataAndRefreshPage();
						parent.$.colorbox.close();
					}
					else
					{
						ACC.paymentmethod.bindCreateUpdatePaymentDetailsForm();
						parent.$.colorbox.resize()
						
					}
				},
				error: function (xht, textStatus, ex)
				{
					alert("Failed to create/update payment details. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				},
				complete: function ()
				{
					$('#popup_checkout_add_edit_payment_method').unblock();
					$.colorbox.toggleLoadingOverlay();
					ACC.paymentmethod.displayStartDateIssueNum()
					
				}
			};

			$(this).ajaxForm(options);

		});
	},

	bindUseThisSavedCardButton: function ()
	{
		$('.use_this_saved_card_button').click(function ()
		{
			var paymentId = $(this).attr('data-payment_id');
			$.postJSON(setPaymentDetailsUrl, {paymentId: paymentId}, ACC.paymentmethod.handleSelectSavedCardSuccess);
			return false;
		});
	},

	handleSelectSavedCardSuccess: function (data)
	{
		if (data != null)
		{
			ACC.refresh.refreshPage(data);
			parent.$.colorbox.close();
		}
		else
		{
			alert("Failed to set payment details");
		}
	},

	refreshPaymentDetailsSection: function (data)
	{
		$('#checkout_summary_payment_div').replaceWith($('#paymentSummaryTemplate').tmpl(data));
		//bind edit payment details button
		ACC.paymentmethod.bindEditPaymentMethodButton();
		ACC.paymentmethod.bindSecurityCodeWhatIs();
	},
	
	displayStartDateIssueNum: function()
	{
		
		var cardType = $("#cardType").val();
    	            	
    	if (cardType == 'maestro' || cardType == 'switch')
        {
            $('#startDate, #issueNum').show("fast",'linear', function() {
				parent.$.colorbox.resize()
			});
        }
        else
        {
            $('#startDate, #issueNum').hide('fast','linear', function() {
				parent.$.colorbox.resize()
			});
            
	    }
		
						
    }

};

$(document).ready(function ()
{
	ACC.paymentmethod.bindAll();
	

});







