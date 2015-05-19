ACC.costcenter = {

	bindAll: function()
	{
		this.bindToCostCenterSelection();

	},

	updateCostCenterForCart: function(costCenterId)
	{
		$.postJSON(updateCostCenterUrl, {costCenterId: costCenterId});
		return false;
	},

	bindToCostCenterSelection: function()
	{
		$('#CostCenter').change(function()
		{
			var costCenterId = $("#CostCenter option:selected")[0].value;
			$.postJSON(setCostCenterUrl, {costCenterId: costCenterId}, ACC.costcenter.handleSelectSavedCostCenterSuccess);
			return false;
		});
	},

	markCostCenterSectionAsCompleted: function()
	{
		if ($("#CostCenter option:selected")[0].value != '')
		{
			$('#checkout_summary_costcenter_div').addClass('complete');
		}
		else
		{
			$('#checkout_summary_costcenter_div').removeClass('complete');
		}
	},

	handleSelectSavedCostCenterSuccess: function(checkoutCartData) 
	{
			ACC.costcenter.markCostCenterSectionAsCompleted();
			ACC.address.refreshDeliveryAddressSection(checkoutCartData);
			ACC.deliverymode.refreshDeliveryMethodSection(checkoutCartData);
			ACC.refresh.refreshCartTotals(checkoutCartData);
			ACC.negotiatequote.cancelQuoteNegotiationEvent();
			ACC.replenishment.cancelReplenishmentEvent();

	},

	refreshCostCenterSection: function(checkoutCartData)
	{
		if (checkoutCartData.costCenter != null && checkoutCartData.costCenter.code != '')
		{
			$("#CostCenter").val(checkoutCartData.costCenter.code);
			ACC.costcenter.markCostCenterSectionAsCompleted();
			ACC.costcenter.updateCostCenterForCart(checkoutCartData.costCenter.code);
		}
		else
		{
			$("#CostCenter").val('');
			$("#requestQuoteButton").attr('disabled', true);
			$('#checkout_summary_costcenter_div').removeClass('complete');
		}
	}
	
};

$(document).ready(function()
{
	ACC.costcenter.bindAll();
});



