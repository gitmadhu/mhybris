ACC.refresh = {
	refreshCartTotals: function (checkoutCartData)
	{
		$('#ajaxCart').html($('#cartTotalsTemplate').tmpl(checkoutCartData));
	},

	refreshPage: function (checkoutCartData)
	{
		//update delivery address, delivery method and payment sections, and cart totals section
		
	
	},
	getCheckoutCartDataAndRefreshPage: function ()
	{
		$.postJSON(getCheckoutCartUrl, function (checkoutCartData)
		{
			ACC.refresh.refreshPage(checkoutCartData);
		});
	}
}

$.blockUI.defaults.overlayCSS = {};
$.blockUI.defaults.css = {};
