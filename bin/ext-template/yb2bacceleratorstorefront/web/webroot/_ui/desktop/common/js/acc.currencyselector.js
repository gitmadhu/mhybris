ACC.langcurrency = {
	
	bindAll: function()
	{
		this.bindCurrencySelector();
	},
	bindCurrencySelector: function()
	{
			
			
			$('#currency-selector').change(function() {
				$('#currency-form').submit();
			})
			
	}

};

$(document).ready(function() {
	ACC.langcurrency.bindAll();
});