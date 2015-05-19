ACC.mycompany = {

	bindAll: function()
	{
		this.mycompanyInit()

		if(typeof selectDeselectBudget != 'undefined' && selectDeselectBudget)
		{
			this.selectDeselectBudgetInit()
		}
		
		if(typeof selectDeselectUser != 'undefined' && selectDeselectUser)
		{
			this.selectDeselectUserInit()
		}
		
		if(typeof selectDeselectLink != 'undefined' && selectDeselectLink)
		{
			this.selectDeselectLinkInit()
		}
	},

	mycompanyInit: function()
	{
		if(typeof budgetStartEnd != 'undefined')
		{

			$("#budgetStartDate").datepicker({dateFormat: budgetStartEnd});
			$("#budgetEndDate").datepicker({dateFormat: budgetStartEnd});
			$("#budgetStartDate").datepicker( "option", "appendText",  budgetStartEndHint);
			$("#budgetEndDate").datepicker( "option", "appendText",  budgetStartEndHint);

			$('#editB2bBudgetform').validate({
				rules:{
					startDate:{
						required: true,
						dpDate: true
					},
					endDate:{
						required: true,
						dpDate: true
					}
				}
			});
		}

		if (typeof unitactive != 'undefined'  && !unitactive  )
		{
			$('.create').removeAttr("href").addClass("disabled");
		}

		if (typeof unittree != 'undefined' && unittree) {
			$("#unittree").treeview();
		}

		if (typeof customerDataactive != 'undefined'  && customerDataactive != 'true')
		{
			$('.create-new').removeAttr("href").addClass("disabled");
		}

		if (typeof customerDataunitactive != 'undefined'  && customerDataunitactive != 'true')
		{
			$('.disable').removeAttr("href").addClass("disabled");
			$('.enable').removeAttr("href").addClass("disabled");
			$('.create').removeAttr("href").addClass("disabled");
		}
	},

	selectDeselectBudgetInit: function()
	{
		ACC.mycompany.bindToSelectBudget();
		ACC.mycompany.bindToDeselectBudget();
	},

	bindToSelectBudget: function()
	{
		$('.selectBudget').live('click',function()
		{
			$.postJSON(this.getAttribute('url'),{}, ACC.mycompany.selectionCallback);
			return false;
		});
	},

	bindToDeselectBudget: function()
	{
		$('.deselectBudget').live('click',function()
		{
			var url = this.getAttribute('url');
			ACC.mycompany.bindConfirmDeselectButton(url);
			ACC.mycompany.bindCancelDeselectButton();

			$.colorbox({
				inline: true,
				height: false,
				width: 300,
				href: "#deselect_budget_warning",
				overlayClose: false,
				onComplete: function ()
				{
					$(this).colorbox.resize();
				},
				onClosed: function()
				{
					$('#confirm_deselect').off('click');
				}
			});
		});
	},

	bindConfirmDeselectButton: function(url)
	{
		$('#confirm_deselect').on('click', function()
		{
			$.postJSON(url,{}, ACC.mycompany.deselectionCallback);
			$.colorbox.close();
		});
	},

	bindCancelDeselectButton: function()
	{
		$('#cancel_deselect').on('click', function()
		{
			$.colorbox.close();
		});
	},

	selectionCallback: function(budget)
	{
		$('#row-' + budget.normalizedCode).addClass("selected");
		$('#span-' + budget.normalizedCode).html($('#enableDisableLinksForBudgetsTemplate').tmpl(budget));
	},

	deselectionCallback: function(budget)
	{
		$('#row-' + budget.normalizedCode).removeClass("selected");
		$('#span-' + budget.normalizedCode).html($('#enableDisableLinksForBudgetsTemplate').tmpl(budget));
	},

	selectDeselectUserInit: function()
	{
		ACC.mycompany.bindToSelectUser();
		ACC.mycompany.bindToDeselectUser();
	},

	bindToSelectUser: function()
	{
		$('.selectUser').live('click', function()
		{
			$.postJSON(this.getAttribute('url'), {}, ACC.mycompany.selectionUserCallback);
			return false;
		});
	},

	bindToDeselectUser: function()
	{

		$('.deselectUser').live('click', function()
		{
			$.postJSON(this.getAttribute('url'), {}, ACC.mycompany.deselectionUserCallback);
			return false;
		});
	},

	selectionUserCallback: function(user)
	{
		if( typeof user.normalizedUid != 'undefined')
		{
			$('#row-' + user.normalizedUid).addClass("selected");
			$('#selection-' + user.normalizedUid).html($('#enableDisableLinksTemplate').tmpl(user));
			$('#roles-' + user.normalizedUid).html($('#userRolesTemplate').tmpl(user));
		}else{
			$('#row-' + user.normalizedCode).addClass("selected");
			$('#selection-' + user.normalizedCode).html($('#enableDisableLinksTemplate').tmpl(user));
			$('#roles-' + user.normalizedCode).html($('#userRolesTemplate').tmpl(user));			
		}
	},

	deselectionUserCallback: function(user)
	{
		if( typeof user.normalizedUid != 'undefined')
		{
			$('#row-' + user.normalizedUid).removeClass("selected");
			$('#selection-' + user.normalizedUid).html($('#enableDisableLinksTemplate').tmpl(user));
			$('#roles-' + user.normalizedUid).html($('#userRolesTemplate').tmpl(user));
		}else{
			$('#row-' + user.normalizedCode).removeClass("selected");
			$('#selection-' + user.normalizedCode).html($('#enableDisableLinksTemplate').tmpl(user));
			$('#roles-' + user.normalizedCode).html($('#userRolesTemplate').tmpl(user));
		}
	},

	selectDeselectLinkInit: function()
	{
		ACC.mycompany.bindToSelectLink();
		ACC.mycompany.bindToDeselectLink();	
	},

	bindToSelectLink: function()
	{
		$('.selectionLink').live('click', function()
		{
			$.postJSON(this.getAttribute('url'), {}, ACC.mycompany.selectionLinkCallback);
			return false;
		});
	},

	bindToDeselectLink: function()
	{
		$('.deselectionLink').live('click', function()
		{
			$.postJSON(this.getAttribute('url'), {}, ACC.mycompany.deselectionLinkCallback);
			return false;
		});
	},

	selectionLinkCallback: function(obj)
	{
		$('#row-' + obj.normalizedCode).addClass("selected");
		$('#' + obj.normalizedCode).html($('#enableDisableLinksTemplate').tmpl(obj));
	},

	deselectionLinkCallback: function(obj)
	{
		$('#row-' + obj.normalizedCode).removeClass("selected");
		$('#' + obj.normalizedCode).html($('#enableDisableLinksTemplate').tmpl(obj));
	}

};

$(document).ready(function()
{
	ACC.mycompany.bindAll();
});



