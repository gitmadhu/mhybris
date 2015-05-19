ACC.langselector = {
	
	bindAll: function()
	{
		this.bindLangSelector();
	},
	bindLangSelector: function()
	{
		$('#lang-form').change(function() {
			this.submit();
		});
	}

};

$(document).ready(function() {
	ACC.langselector.bindAll();
});