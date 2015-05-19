ACC.quote = {

	bindAll: function()
	{
		this.bindToCancelQuoteButtonClick();
		this.bindToNegotiateQuoteButtonClick();
		this.bindToCancelClick();
		this.bindToAddAdditionalComment();
	},

	showRequestRequoteForm: function()
	{
		ACC.quote.displayNegotiateQuoteDiv();
		$("#cancelQuoteButton").attr('disabled', true);
	},

	displayNegotiateQuoteDiv: function()
	{
		$('#negotiate-quote-div').show();
		return false;
	},

	bindToCancelQuoteButtonClick: function()
	{
		$('#cancelQuoteButton').click(function() {
			ACC.quote.displayNegotiateQuoteDiv();
			$('#negotiate-quote-div-label-cancel').show();
			$("#cancelQuoteButton").addClass('pressed');
			$("#negotiateQuoteButton").attr('disabled', true);
			$("#acceptQuoteButton").attr('disabled', true);
			$("#addAdditionalComment").attr('disabled', true);
			$('#selectedQuoteDecision').val(this.name);
			return false;
		});
	},

	updateNogotiatiateQuoteDivLabel: function(label)
	{
		$('#negotiate-quote-div-label').html(label)
	},

	bindToNegotiateQuoteButtonClick: function()
	{
		$('#negotiateQuoteButton').click(function() {
			$("#negotiateQuote").val(true);
			$("#negotiateQuoteButton").addClass('pressed');
			$("#cancelQuoteButton").attr('disabled', true);
			$("#acceptQuoteButton").attr('disabled', true);
			$("#addAdditionalComment").attr('disabled', true);
			$('#selectedQuoteDecision').val(this.name);
			ACC.quote.displayNegotiateQuoteDiv();
			$('#negotiate-quote-div-label-add-comment').show();

			return false;
		});
	},

	submitQuoteDecision: function(selectedQuoteDecision)
	{
		$('#selectedQuoteDecision').attr("value", selectedQuoteDecision);
		$("#quoteOrderDecisionForm").submit();
	},

	bindToCancelClick: function()
	{
		$('#cancelComment').click(function() {
			$("#negotiateQuote").val(false);
			$('#negotiate-quote-div, #negotiate-quote-div h2 > div').hide()
			$("#cancelQuoteButton").removeClass('pressed');
			$("#negotiateQuoteButton").removeClass('pressed');
			$("#acceptQuoteButton").removeClass('pressed');
			$("#addAdditionalComment").removeClass('pressed');

			$("#negotiateQuoteButton").removeAttr("disabled");
			$("#cancelQuoteButton").removeAttr("disabled");
			$("#acceptQuoteButton").removeAttr("disabled");
			$("#addAdditionalComment").removeAttr("disabled");
			$('#selectedQuoteDecision').val("");
			return false;
		});
	},

	bindToAddAdditionalComment: function()
	{
		$('#addAdditionalComment').click(function() {
			$("#addAdditionalComment").addClass('pressed');
			$("#negotiateQuoteButton").attr('disabled', true);
			$("#cancelQuoteButton").attr('disabled', true);
			$("#acceptQuoteButton").attr('disabled', true);
			$('#selectedQuoteDecision').val(this.name);
			ACC.quote.displayNegotiateQuoteDiv();
			$('#negotiate-quote-div-label-add-comment').show();
			return false;
		});		
	}
	
	
};

$(document).ready(function()
{
	
	if(typeof quoteActive != 'undefined' && quoteActive)
	{
		ACC.quote.bindAll();
	}
	
});










