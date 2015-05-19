/*
 * [y] hybris Platform
 *
 * Copyright (c) 2000-2013 hybris AG
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of hybris
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with hybris.
 */

// This JavaScript code is used to fix a bug where the IE browser will trigger an onChange event if the
// up/down arrow keys are used.
// For more information see https://confluence.sakaiproject.org/display/2ACC/Fix+for+Select+Elements+with+Inaccessible+Onchange+Events

$(document).ready(function () {
	if ($.browser.msie)
	{
		$('select').parent('form').each(function (index, objElement) {
			if (typeof $(objElement).data('events') !== 'undefined' &&
					typeof $(objElement).data('events').change !== 'undefined')
			{
				$(objElement).unbind('change');

				$(objElement).children('select').keydown(function(e) {
					if (e.which === 38 || e.which === 40)
					{
						$(this).parent().data('updownPressed', true);
						$(this).parent().data('selectedVal', $(this).val());
					}
					else if (e.which === 13 && $(this).val() !== $(this).parent().data('selectedVal'))
					{
						$(this).parent().submit();
					}
					else
					{
						$(this).parent().data('updownPressed', false);
					}
				});

				$(objElement).change(function() {
					if ($(this).data('updownPressed'))
					{
						$(this).data('updownPressed', false);
					}
					else
					{
						this.submit();
					}
				});
			}
		});
	}
});