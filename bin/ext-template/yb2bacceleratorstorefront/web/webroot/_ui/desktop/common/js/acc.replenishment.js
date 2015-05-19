ACC.replenishment = {

	bindAll: function ()
	{
		this.bindToScheduleReplenishmentButtonClick();
		this.bindToCancelReplenishmentClick();
		this.bindToPlaceReplenishmentButtonClick();


	},

	replenishmentInit: function ()
	{
		$("#replenishmentStartDate").datepicker({dateFormat: dateForForDatePicker});
		$("#replenishmentStartDate").datepicker("option", "appendText", dateForForDatePicker);

		$('.replenishmentfrequencyD').click(function ()
		{
			$('.scheduleform').each(function ()
			{
				$(this).removeClass('scheduleformfilled');
			});
			$('.scheduleformD').addClass('scheduleformfilled');

		});
		$('.replenishmentfrequencyW').click(function ()
		{
			$('.scheduleform').each(function ()
			{
				$(this).removeClass('scheduleformfilled');
			});
			$('.scheduleformW').addClass('scheduleformfilled');

		});
		$('.replenishmentfrequencyM').click(function ()
		{
			$('.scheduleform').each(function ()
			{
				$(this).removeClass('scheduleformfilled');
			});
			$('.scheduleformM').addClass('scheduleformfilled');

		});
	},

	bindToScheduleReplenishmentButtonClick: function ()
	{
		$('#scheduleReplenishmentButton').click(function ()
		{
			ACC.replenishment.scheduleReplenishmentDiv();

			return false;
		});
	},

	scheduleReplenishmentDiv: function ()
	{
		$("input:radio[name='replenishmentFrequency'][value=" + placeOrderFormreplenishmentRecurrence + "]").attr('checked', true);
		$("#nDays option[value=" + placeOrderFormnDays + "]").attr('selected', 'selected');
		$("#daysoFWeek option[value=" + placeOrderFormnthDayOfMonth + "]").attr('selected', 'selected');
		$("#requestQuoteButton").attr('disabled', true);
		$("#scheduleReplenishmentButton").addClass('pressed');
		//$('#scheduleReplenishmentButton').removeClass("possitive");
		$('#replenishment-schedule-div').show();
		$(".place-order").attr('disabled', true);
		$("#placeReplenishmentOrderButton").removeAttr('disabled');
		ACC.replenishment.replenishmentInit();
		return false;
	},

	updateScheduleReplenishmentButton: function ()
	{
		var paymentType = $("#checkout_summary_paymentType_div").hasClass("complete");
		var deliveryAddress = $("#checkout_summary_deliveryaddress_div").hasClass("complete");
		var deliveryMode = $("#checkout_summary_deliverymode_div").hasClass("complete");
		var costCenter = $('#checkout_summary_costcenter_div').hasClass("complete");
		var paymentDetails = $("#checkout_summary_payment_div").hasClass("complete")

		if (paymentType && deliveryAddress && deliveryMode && (costCenter || paymentDetails) && !("true" == placeOrderFormnegotiateQuote && $("#requestQuoteButton").hasClass("pressed")))
		{
			$("#scheduleReplenishmentButton").removeAttr('disabled');
		}
		else
		{
			$("#scheduleReplenishmentButton").attr('disabled', true);
		}

		if ($("#scheduleReplenishmentButton").hasClass("pressed"))
		{
			$(".place-order").attr('disabled', true);
			$("#requestQuoteButton").attr('disabled', true);
			$("#placeReplenishmentOrderButton").removeAttr('disabled');
		}
	},

	bindToPlaceReplenishmentButtonClick: function ()
	{
		$('#placeReplenishmentOrderButton').on("click", function ()
		{
			ACC.common.blockFormAndShowProcessingMessage($(this));
			$("#replenishmentOrder").attr('value', true);
			ACC.placeorder.placeOrderWithSecurityCode(1);
		});
	},

	bindToCancelReplenishmentClick: function ()
	{
		$('#cancel-place-replenishmentOrder').on("click", function ()
		{
			ACC.replenishment.cancelReplenishmentEvent();
		});
	},

	cancelReplenishmentEvent: function ()
	{
		$("#replenishmentOrder").val(false);
		$("#scheduleReplenishmentButton").removeClass('pressed');
		$('#replenishment-schedule-div').hide();
		ACC.placeorder.updatePlaceOrderButton();
		ACC.negotiatequote.updateRequestQuoteButton();
		ACC.replenishment.updateScheduleReplenishmentButton();
	}
};

$(document).ready(function ()
{
	ACC.replenishment.bindAll();
});

