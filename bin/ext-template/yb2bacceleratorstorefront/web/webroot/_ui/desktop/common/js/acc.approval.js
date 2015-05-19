ACC.approval = {

	submitApprovalDecision: function (desictionCode)
	{
		$('#approverSelectedDecision').attr("value", desictionCode);
		$("#approvalDecisionForm").submit();
	},

	bindToApproverDecisionButton: function ()
	{
		$('.approverDecisionButton').click(function()
		{
			ACC.approval.submitApprovalDecision($(this).data("decision"));

		});
	}
};

$(document).ready(function ()
{
	ACC.approval.bindToApproverDecisionButton();
});
