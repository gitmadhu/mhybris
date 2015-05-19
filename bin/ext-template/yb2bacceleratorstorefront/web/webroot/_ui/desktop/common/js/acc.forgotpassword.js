ACC.forgotpassword = {
	$forgottenPwdForm:   $('#forgottenPwdForm'),
	$forgotPasswordLink: $('.password-forgotten'),


	bindForgotPasswordLink: function(link) {
		link.click(function() {
			$.get(link.data('url')).done(function(data) {
				$.colorbox({
					html: data,
					height: '250px',
					overlayClose: false,
					onOpen: function() {
						$('#validEmail').remove();
					},
					onComplete: function() {
						ACC.forgotpassword.$forgottenPwdForm.ajaxForm({
							success: function(data)
							{
								if ($(data).closest('#validEmail').length)
								{
									if ($('#validEmail').length === 0)
									{
										ACC.common.$globalMessages.append(data);
									}
									$.colorbox.close();
								}
								else
								{
									ACC.forgotpassword.$forgottenPwdForm
										.find('.form_field-elements')
										.html($(data)
										.find('#forgottenPwdForm .form_field-elements'));
									$.colorbox.resize();
								}
							}
						});
						ACC.common.refreshScreenReaderBuffer();
					},
					onClosed: function() {
						ACC.common.refreshScreenReaderBuffer();
					}
				});
			});
		});
	},

	bindAll: function() {
		ACC.forgotpassword.bindForgotPasswordLink(ACC.forgotpassword.$forgotPasswordLink);
	}
};

$(document).ready(function() {
	ACC.forgotpassword.bindAll();
});