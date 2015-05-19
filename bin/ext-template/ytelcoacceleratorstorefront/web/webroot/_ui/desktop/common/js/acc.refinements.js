ACC.refinements = {

	bindAll: function()
	{
		this.bindRefinementCategoryToggles();
	},

	bindRefinementCategoryToggles: function()
	{
		$('a.refinementToggle').each(function ()
		{
			$(this).attr('title', $(this).data('hideFacetText'));

			$(this).click(function ()
			{
				var content = $(this).closest('div.item').find('div.facetValues');

				$(this).attr('title', $(content).is(':visible') ? $(this).data('showFacetText') : $(this).data('hideFacetText'));
				$(this).next().toggleClass('toggleArrow');

				$(content).slideToggle();

				return false;
			});

			$(this).next().click(function ()
			{
				$(this).prev().click();
			});
		});
	}
};

$(document).ready(function()
{
	ACC.refinements.bindAll();
});
