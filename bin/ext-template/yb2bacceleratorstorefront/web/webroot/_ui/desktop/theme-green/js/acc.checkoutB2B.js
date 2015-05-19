ACC.checkoutB2B = {
	cartData:"",
	PaymentType: function ()
	{


		if($(".summaryPaymentType").length>0){
			var $element = $(".summaryPaymentType")
			var config = $element.data()


			$(".summaryPaymentType input[name='PaymentType']").on("change",function(){
				$.postJSON(config.setPaymentTypeUrl, {paymentType: $(this).val()}, function(data){	
					ACC.checkoutB2B.refresh(data);	
					$(".summarySection").removeClass("complete")
					$(".summaryPaymentType").addClass("complete")
					$(".summaryCostCenter .constCenterSelect").val("")

				});
				var globalMessage = document.getElementById("globalMessages");
				while (globalMessage.firstChild) {
					globalMessage.removeChild(globalMessage.firstChild);
				}
			})



			$("#PurchaseOrderNumber").on("blur",function(){
				
					$.postJSON(config.setPurchaseOrderNumberUrl, {purchaseOrderNumber: $(this).val()}, function(data){
						ACC.checkoutB2B.refresh(data);		
					});
				
			})

		}
	
	},
		
	costCenter: function ()
	{
		if($(".summaryCostCenter").length>0){
			var config = $(".summaryCostCenter").data()
			$(".summaryCostCenter .constCenterSelect").on("change",function(){
				if($(this).val()!=""){
					$.postJSON(config.setCostCenterUrl, {costCenterId: $(this).val()}, function(data){
						ACC.checkoutB2B.refresh(data);
						$(".summaryCostCenter").addClass("complete")
					});
				}else{
					$(".summaryCostCenter").removeClass("complete")
				}
			})
		}

	},
	createUpdatePaymentForm: function ()
	{

		$(document).on("change", "#cardType", ACC.checkoutB2B.displayStartDateIssueNum);

		if($('#differentAddress:checked').length<1){
			$("#newBillingAddressFields :input").attr('disabled', 'disabled');
		}
		$('.create_update_payment_form').each(function ()
		{

			ACC.checkoutB2B.displayStartDateIssueNum()

			var options = {
				type: 'POST',
				beforeSubmit: function ()
				{
					
				},
				success: function (data)
				{
					$('#summaryPaymentOverlayEnterNew').html(data);
					ACC.checkoutB2B.createUpdatePaymentForm();
					if ($('#paymentDetailsForm').hasClass('Success'))
					{
						ACC.checkoutB2B.refresh();
						
						parent.$.colorbox.close();
					}
					else
					{
						
						$.colorbox.resize();
					}
				},
				error: function (xht, textStatus, ex)
				{
					alert("Failed to create/update payment details. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				},
				complete: function ()
				{
					
	
				}
			};

			$(this).ajaxForm(options);

		});
	},
	payment: function ()
	{
		
		$(document).ready(function(){
			$("#securityCode").val("");
		});
		
		$(document).on("focusout",'.summaryPayment #SecurityCodePayment', function (e){
			$("#securityCode").val($(this).val())
		});
		
		
		
		
		$(document).on("click",'.summaryPayment .security_code_what', function (e){
			$('.security_code_what').bt($(".summaryPayment").data('security-what-text'), {
				trigger: 'click',
				positions: 'bottom',
				fill: '#efefef',
				cssStyles: {
					fontSize: '11px'
				}
			});
		});
		

		$(document).on("click",'#summaryOverlayViewSavedPaymentMethods', function (){
			$("#summaryPaymentOverlay").show();
			$("#summaryPaymentOverlayEnterNew").remove();
			$.colorbox.resize();
		});
		
		
		$(document).on("click",'#summaryPaymentOverlay .useCard', function (e){
			e.preventDefault();
			var paymentId = $(this).data('payment');
			$.postJSON(setPaymentDetailsUrl, {paymentId: paymentId}, function(data){
				ACC.checkoutB2B.refresh(data);
				$.colorbox.close();
			});
		});
		
		
		
		
		
		$(document).on("click",'#summaryPaymentOverlay .enterNewPayment', function (){
			$("#summaryPaymentOverlay").hide();
			$("#summaryPaymentOverlay").after($("#summaryPaymentOverlayEnterNew").clone());
			ACC.checkoutB2B.createUpdatePaymentForm();	
			$.colorbox.resize();
		});
		
		
		$(document).on("click",'.summaryPayment .editButton', function (){

			$("#summaryPaymentOverlayContainer").html("");
			$("#summaryPaymentOverlayContainer").append($("#summaryPaymentOverlayEnterNew").clone()).append($("#summaryPaymentOverlay").clone());



					$.colorbox({
						inline: true,
						href: "#summaryPaymentOverlayContainer",
						height: false,
						overlayClose: false,
						onComplete: function ()
						{
							ACC.common.refreshScreenReaderBuffer();
								$.colorbox.resize();
								ACC.checkoutB2B.createUpdatePaymentForm();	

								$.ajax({
									url: $(".summaryPayment").data("getSavedCardsUrl"),
									type: 'POST',
									cache: false,
									dataType: 'json',
									success: function (data)
									{
										$('#summaryPaymentOverlay').html($('#savedCardsTemplate').tmpl({savedCards: data})).hide();
										
									},
									error: function (xht, textStatus, ex)
									{
										alert("Failed to get saved cards. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
									}
								});
			
						},
						onClosed: function ()
						{
							ACC.common.refreshScreenReaderBuffer();
						}
					});

		});
		
		
		
		$(document).on("change",'#differentAddress', function (){
			var newAddress = $('#differentAddress').attr("checked");
			if(newAddress)
			{
				$("#newBillingAddressFields :input").removeAttr('disabled');
			}
			else
			{
				$("#newBillingAddressFields :input").attr('disabled', 'disabled');
			}
		});
		
	},
	deliveryAddress: function (section)
	{
			
		$(document).on("click",'#summaryDeliveryAddressOverlay #summaryOverlayViewAddressForm', function (){
			$("#summaryDeliveryAddressForm").show();
			$("#summaryDeliveryAddressBook").hide();
			$.colorbox.resize();
		});
		
		$(document).on("click",'#summaryDeliveryAddressOverlay #summaryOverlayViewAddressBook', function (){
			$("#summaryDeliveryAddressBook").show();
			$("#summaryDeliveryAddressForm").hide();
			$.colorbox.resize();
		});		
		
		$(document).on("click",'.summaryDeliveryAddress .editButton', function (){



			if(ACC.checkoutB2B.cartData.paymentType.code == "ACCOUNT"){

				$.postJSON($(".summaryDeliveryAddress").data('get'), function(data){
					section= ".summaryDeliveryAddress";
					$("#summaryDeliveryAddressBook").html($(section+' .colorboxTemplate').tmpl({addresses: data,editable: false}));
					$("#summaryDeliveryAddressBook").show();
					$("#summaryDeliveryAddressForm").hide();


					$.colorbox({
						inline: true,
						href: "#summaryDeliveryAddressOverlay",
						height: false,
						overlayClose: false,
						onComplete: function ()
						{
							ACC.common.refreshScreenReaderBuffer();
								$.colorbox.resize();
						},
						onClosed: function ()
						{

							ACC.common.refreshScreenReaderBuffer();
						}
					});


				});

				


				return;
			}



			$("#summaryDeliveryAddressBook").hide();
			var changeFormUrl= $(".summaryDeliveryAddress").data('get-form')+"?createUpdateStatus=1&addressId="+$(this).data("address");
			$.get(changeFormUrl, function(data){
				$("#summaryDeliveryAddressForm").remove();
				$("#summaryDeliveryAddressOverlay").prepend(data);
				
			
				$.postJSON($(".summaryDeliveryAddress").data('get'), function(data){
					section= ".summaryDeliveryAddress";
					$("#summaryDeliveryAddressBook").html($(section+' .colorboxTemplate').tmpl({addresses: data,editable: true}));
				});
			
				
				ACC.checkoutB2B.createUpdateAddressForm();
				
				$.colorbox({
					inline: true,
					href: "#summaryDeliveryAddressOverlay",
					height: false,
					overlayClose: false,
					onComplete: function ()
					{
						ACC.common.refreshScreenReaderBuffer();
							$.colorbox.resize();
					},
					onClosed: function ()
					{

						ACC.common.refreshScreenReaderBuffer();
					}
				});
			});
		});
		
		
		$(document).on("click",'#summaryDeliveryAddressOverlay .useAddress', function (e){
			e.preventDefault();
			var addressId = $(this).data('address');
			$.postJSON($('.summaryDeliveryAddress').data("set"), {addressId: addressId}, function(data){
				ACC.checkoutB2B.refresh(data);
				$.colorbox.close();
			});
			
		});
		
		
		$(document).on("click",'#summaryDeliveryAddressOverlay #addressForm button', function (){
			var saveAddressChecked = $(this).prop('checked');
			$('#defaultAddress').prop('disabled', !saveAddressChecked);
			if (!saveAddressChecked) {
				$('#defaultAddress').prop('checked', false);
			}
		});




		$(document).on("click",'#summaryDeliveryAddressBook .addressEntry .edit', function (e){
			e.preventDefault();

			var changeFormUrl= $(".summaryDeliveryAddress").data('get-form')+"?createUpdateStatus=1&addressId="+$(this).data("address");
			$.get(changeFormUrl, function(data){

				$("#summaryDeliveryAddressForm").remove();
				$("#summaryDeliveryAddressOverlay").prepend(data);
				$("#summaryDeliveryAddressBook").hide();
				$("#summaryDeliveryAddressForm").show();
				$.colorbox.resize();

				ACC.checkoutB2B.createUpdateAddressForm();

			});
		});


		$(document).on("click",'#summaryDeliveryAddressOverlay button.default', function (e){
			e.preventDefault();
			var addressId = $(this).data('address');
			$.postJSON($('.summaryDeliveryAddress').data("setDefault"), {addressId: addressId}, function(data){
				section= ".summaryDeliveryAddress";
				$("#summaryDeliveryAddressBook").html($(section+' .colorboxTemplate').tmpl({addresses: data}));
			});
			
		});



		
	},
	createUpdateAddressForm: function ()
	{
		$('.create_update_address_form').each(function ()
		{
			var options = {
				type: 'POST',
				beforeSubmit: function ()
				{
					
				},
				success: function (data)
				{
					
					$('#summaryDeliveryAddressForm').html(data);
					ACC.checkoutB2B.createUpdateAddressForm();
					if ("Success" == $(".create_update_address_id").data('status'))
					{
						ACC.checkoutB2B.refresh();
						
						parent.$.colorbox.close();
					}
					else
					{
						
						$.colorbox.resize();
					}
				},
				error: function (xht, textStatus, ex)
				{
					alert("Failed to update cart. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				},
				complete: function ()
				{
					
				}
			};

			$(this).ajaxForm(options);
		});
	},
	deliveryMode: function ()
	{
		
		$(document).on("click",'#summaryDeliveryModeOverlay .saveButton', function (e){
			e.preventDefault();
			var setDeliveryModeUrl = $(".summaryDeliveryMode").data("set");
			var selectedCode = $('input:radio[name=delivery]:checked').val();
			if(selectedCode)
			{
				$.postJSON(setDeliveryModeUrl, {modeCode: selectedCode}, function(data){
					ACC.checkoutB2B.refresh(data);
				});
			}
			$.colorbox.close();
		});
	
	
		$(document).on("click",'.summaryDeliveryMode .editButton', function (){
			section= ".summaryDeliveryMode";
			$.postJSON($(section).data('get'), function(data){
				if (ACC.checkoutB2B.cartData.deliveryMode != null)
					$("#summaryDeliveryModeOverlay").html($(section+' .colorboxTemplate').tmpl({data: data, selectedCode: ACC.checkoutB2B.cartData.deliveryMode.code}));
				else
					$("#summaryDeliveryModeOverlay").html($(section+' .colorboxTemplate').tmpl({data: data, selectedCode: 'standard-net'}));
			});
			
	
			$.colorbox({
				inline: true,
				href: "#summaryDeliveryModeOverlay",
				height: false,
				overlayClose: false,
				onComplete: function ()
				{
					ACC.common.refreshScreenReaderBuffer();
						$.colorbox.resize();
				},
				onClosed: function ()
				{
					ACC.common.refreshScreenReaderBuffer();
				}
			});
	
		});
	},
	displaySection: function (section)
	{
		var cartData = ACC.checkoutB2B.cartData;
		
		if($(".summaryPaymentType input[name=PaymentType]:checked").length < 1){
			$("#PaymentTypeSelection_"+cartData.paymentType.code).attr("checked",true);
		}

		if(cartData.paymentType.code=="ACCOUNT"){
			$(".summaryCostCenter").show();
			$(".summaryPayment").hide();
			$("#deliverySectionNum").text("3");
		}else{
			$(".summaryCostCenter").hide();
			$(".summaryPayment").show();
			$("#deliverySectionNum").text("2");
			
		}
	},
	refreshSection: function (section)
	{
		var cartData = ACC.checkoutB2B.cartData;
		$(section+" .contentSection").html($(section+' .sectionTemplate').tmpl({data: cartData}));
		ACC.checkoutB2B.displaySection();
	},
	refresh: function(data){
		if(data==undefined)
		{
			$.postJSON($("#checkoutContentPanel").data("checkoutCartUrl"), function(data){
				ACC.checkoutB2B.refreshSections(data);
			});
		}
		else
		{
			ACC.checkoutB2B.refreshSections(data);
		}
	},
	refreshSections: function(data){
		ACC.checkoutB2B.cartData=data;
		ACC.checkoutB2B.refreshCart(data);
		// ACC.checkoutB2B.refreshSection(".summaryPaymentType");
		// ACC.checkoutB2B.refreshSection(".summaryCostCenter");
		ACC.checkoutB2B.refreshSection(".summaryPayment");
		ACC.checkoutB2B.refreshSection(".summaryDeliveryAddress");
		ACC.checkoutB2B.refreshSection(".summaryDeliveryMode");

		if (data.deliveryMode == null || data.deliveryAddress == null || (data.paymentType.code == "CARD" && data.paymentInfo == null)) {
			$(".placeOrderButton").attr("disabled", "disabled")
			$(".scheduleReplenishmentButton").attr("disabled", "disabled")
			$(".requestQuoteButton").attr("disabled", "disabled")
		} else {
			if ($('#replenishmentSchedule').is(':visible')) {
				$(".placeOrderButton").attr("disabled", "disabled")
				$(".requestQuoteButton").attr("disabled", "disabled")
				$(".scheduleReplenishmentButton").removeAttr("disabled")
				
			} else if ($('#negotiateQuote').is(':visible')) {
				$(".placeOrderButton").attr("disabled", "disabled")
				$(".scheduleReplenishmentButton").attr("disabled", "disabled")
				$(".requestQuoteButton").removeAttr("disabled")
				
			} else {
				$(".placeOrderButton").removeAttr("disabled")
				$(".scheduleReplenishmentButton").removeAttr("disabled")

				if (data.paymentType.code == "CARD" || !data.quoteAllowed) {
					$(".requestQuoteButton").attr("disabled", "disabled")
				} else {
					$(".requestQuoteButton").removeAttr("disabled")
				}
			}
		}

	},
	refreshCart: function(data){
		$("#ajaxCart").html($("#cartTotalsTemplate").tmpl({data: data}))
		$("#ajaxCartItems").html($("#cartItemsTemplate").tmpl({data: data}))		
	},
	
	
	scheduleReplenishment: function(data){
			 
			$(document).on("click",'#placeOrder .scheduleReplenishmentButton', function (e){
				e.preventDefault();

				if (ACC.checkoutB2B.cartData.quoteAllowed)
					$("#placeOrder .requestQuoteButton").attr('disabled', 'disabled');
				$(".placeOrderButton").attr('disabled', 'disabled');
				$("#placeOrder .scheduleReplenishmentButton").addClass('pressed');
				$('#replenishmentSchedule').show();
				ACC.checkoutB2B.replenishmentInit();
			});

			$(document).on("click",'#replenishmentSchedule #placeReplenishmentOrder', function (e){
				e.preventDefault();
				$(".replenishmentOrderClass").val(true);
				var securityCode = $("#SecurityCodePayment").val();
				$(".securityCodeClass").val(securityCode);
				$("#placeOrderForm1").submit();
			});

			$(document).on("click",'#replenishmentSchedule #cancelReplenishmentOrder', function (e){
				e.preventDefault();
				if (ACC.checkoutB2B.cartData.quoteAllowed && ACC.checkoutB2B.cartData.paymentType.code != "CARD")
					$("#placeOrder .requestQuoteButton").removeAttr('disabled');
				$(".placeOrderButton").removeAttr('disabled');
				$("#placeOrder .scheduleReplenishmentButton").removeClass('pressed');
				$('#replenishmentSchedule').hide();
				$(".replenishmentOrderClass").val(false);
			});

			$(document).on("click",'#replenishmentSchedule .replenishmentfrequencyD, #replenishmentSchedule .replenishmentfrequencyW, #replenishmentSchedule .replenishmentfrequencyM', function (e){
				$('.scheduleform').removeClass('selected');
				$(this).parents('.scheduleform').addClass('selected');
			});	

			var placeOrderFormReplenishmentOrder = $('#replenishmentSchedule').data("placeOrderFormReplenishmentOrder")

			if(placeOrderFormReplenishmentOrder){
				$('#placeOrder .scheduleReplenishmentButton').click()
			}
		
	},

	replenishmentInit: function ()
	{
		var dateForDatePicker = $('#replenishmentSchedule').data("dateForDatePicker");
		var placeOrderFormReplenishmentRecurrence = $('#replenishmentSchedule').data("placeOrderFormReplenishmentRecurrence");
		var placeOrderFormNDays = $('#replenishmentSchedule').data("placeOrderFormNDays");
		var placeOrderFormNthDayOfMonth = $('#replenishmentSchedule').data("placeOrderFormNthDayOfMonth");
		var placeOrderFormNegotiateQuote = $('#replenishmentSchedule').data("placeOrderFormNegotiateQuote");
		var placeOrderFormReplenishmentOrder = $('#replenishmentSchedule').data("placeOrderFormReplenishmentOrder");
		
		$("input:radio[name='replenishmentRecurrence'][value=" + placeOrderFormReplenishmentRecurrence + "]").attr('checked', true);
		$("input:radio[name='replenishmentRecurrence'][value=" + placeOrderFormReplenishmentRecurrence + "]").parents('.scheduleform').addClass('selected');;
		$("#nDays option[value=" + placeOrderFormNDays + "]").attr('selected', 'selected');
		$("#daysoFWeek option[value=" + placeOrderFormNthDayOfMonth + "]").attr('selected', 'selected');
		$("#replenishmentStartDate").datepicker({dateFormat: dateForDatePicker});
		$("#replenishmentStartDate").datepicker("option", "appendText", dateForDatePicker);	
	},
	
	
	negotiateQuote: function(data){
		
			$(document).on("click",'#placeOrder .requestQuoteButton', function (e){
				e.preventDefault();
				$("#placeOrder .scheduleReplenishmentButton").attr('disabled', 'disabled');
				$(".placeOrderButton").attr('disabled', 'disabled');
				$("#placeOrder .requestQuoteButton").addClass('pressed');
				$('#negotiateQuote').show();
				
			});
			
			$(document).on("click",'#negotiateQuote #placeNegotiateQuote', function (e){
				e.preventDefault();
				$(".negotiateQuoteClass").val(true);
				var securityCode = $("#SecurityCodePayment").val();
				$(".securityCodeClass").val(securityCode);
				$("#placeOrderForm1").submit();
			});

			$(document).on("click",'#negotiateQuote #cancelNegotiateQuote', function (e){
				e.preventDefault();
				$("#placeOrder .scheduleReplenishmentButton").removeAttr('disabled');
				$(".placeOrderButton").removeAttr('disabled');
				$("#placeOrder .requestQuoteButton").removeClass('pressed');
				$('#negotiateQuote').hide();
				$(".negotiateQuoteClass").val(false);
			});


			var placeOrderFormNegotiateQuote = $('#replenishmentSchedule').data("placeOrderFormNegotiateQuote");

			if(placeOrderFormNegotiateQuote){
				$('#placeOrder .requestQuoteButton').click()
			}
	},
	
	
	placeOrder: function(data){
		
			$(document).on("click",'.placeOrderButton', function (e){
				e.preventDefault();
				var securityCode = $("#SecurityCodePayment").val();
				$(".securityCodeClass").val(securityCode);
				$("#placeOrderForm1").submit();
			});
			
			
			$(document).on("click",'#Terms1,#Terms2', function (e){
				if($(this).attr('checked')){
					$('#Terms1,#Terms2').attr('checked','checked')
				}else{
					$('#Terms1,#Terms2').removeAttr('checked')
				}
			});

			
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
		
						
    },

    bindTermsAndConditionsLink: function() {
    	$(document).on("click",'.termsAndConditionsLink', function(e) {
			e.preventDefault();
			$.colorbox({
				href: getTermsAndConditionsUrl,
				onComplete: function() {
					ACC.common.refreshScreenReaderBuffer();
				},
				onClosed: function() {
					ACC.common.refreshScreenReaderBuffer();
				}
			});
		});
	}
	
	
	
	
	
	
	
	
	
	

};

$(document).ready(function ()
{
	
	if($("body").hasClass("page-cartPage"))
	{
		$('.checkoutButton').click(function (){
			var checkoutUrl = $(this).data("checkoutUrl");
			window.location = checkoutUrl;
		});
	}
	
	
	if($("body").hasClass("page-singleStepCheckoutSummaryPage"))
	{
		with(ACC.checkoutB2B){
			refresh();
			PaymentType();
			costCenter();
			payment();
			deliveryAddress();
			deliveryMode();
			scheduleReplenishment();
			negotiateQuote();
			placeOrder();
			bindTermsAndConditionsLink();
		}
	}
});
