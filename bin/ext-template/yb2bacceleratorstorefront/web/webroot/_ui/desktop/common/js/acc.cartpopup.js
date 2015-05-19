ACC.cartpopup = {
	
	bindAll: function()
	{
		this.bindCartPop();
	},
	bindCartPop: function()
	{
	
		$('#rollover_cart_popup').hide();
		
		$('#cart_content').hover(
				function() { $.data(this, 'hover', true); },
				function() { $.data(this, 'hover', false); }
		).data('hover', false);
		
		$('#rollover_cart_popup').hover(
				function() { $.data(this, 'hover', true); },
				function() { $.data(this, 'hover', false); }
		).data('hover', false);
		
		$('#cart_content').on('click keypress', function(e) {
			if (e.type === 'click' || e.which === 13)
			{
				$('#cart_popup').hide();
				$.ajax({
					url: rolloverPopupUrl,
					cache: false,
					type: 'POST',
					success: function(result) {
						$('#rollover_cart_popup').html(result);
						$('#rollover_cart_popup').fadeIn();
					}
				});
			}
		});

		$(document).on('click', '#ajax_cart_close', function(e) {
			e.preventDefault();
			$('#rollover_cart_popup').hide();
		});

		$('#cart_content').mouseleave(function() {
			setTimeout(function() {
				if (!$('#cart_content').data('hover') && !$('#rollover_cart_popup').data('hover')) {
					$('#rollover_cart_popup').fadeOut();
				}
			}, 100);
		});
		
		$('#rollover_cart_popup').mouseenter(function() {
			$('#rollover_cart_popup').show();
		});
		$('#rollover_cart_popup').mouseleave(function() {
			setTimeout(function() {
				if(!$('#cart_content').data('hover') && !$('#rollover_cart_popup').data('hover')) {
					$('#rollover_cart_popup').fadeOut();
				}
			}, 100);
		});
	
	}

};

$(document).ready(function() {
	ACC.cartpopup.bindAll();
});

function refreshMiniCart() {
	$.get(refreshMiniCartUrl+ Math.floor(Math.random()*101) * (new Date().getTime()), function(result) {
		$('#minicart_data').html(result)
	});
}