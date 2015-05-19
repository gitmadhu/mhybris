ACC.billingAddressForm = {

	bindAll: function()
	{
		this.updateBillingAddressForm();

		$("#differentAddress").click(function() {
			this.updateBillingAddressForm();
		})

		this.bindCycleFocusEvent();
		
	},

	bindCycleFocusEvent: function()
	{
		$('#lastInTheForm').blur(function() {
			$('#paymentDetailsForm [tabindex$="10"]').focus();
		})
	},

	updateBillingAddressForm: function()
	{
		var editMode = ("true" == $('#newBillingAddressFields').attr('data-edit-mode'));
		var newAddress = $('#differentAddress').attr("checked");
		if(editMode || newAddress)
		{
			$("#newBillingAddressFields :input").removeAttr('disabled');
		}
		else
		{
			$("#newBillingAddressFields :input").attr('disabled', 'disabled');
		}
	}
};

$(document).ready(function()
{
	ACC.billingAddressForm.bindAll();
});


