ACC.product = {

	bindAll: function() {
		ACC.product.bindToAddToCartForm();
	},

	bindToAddToCartForm: function() {
		var addToCartForm = $('.add_to_cart_form');
		addToCartForm.ajaxForm({success: ACC.product.displayAddToCartPopup});
	},
	
	displayAddToCartPopup: function(cartResult, statusText, xhr, formElement) {
		var productCode = $('[name=productCodePost]', formElement).val();
		var quantityField = $('[name=qty]', formElement).val();

		var quantity = 1;
		if (quantityField != undefined) {
			quantity = quantityField;
		}

		ACC.product.trackAddToCart(productCode, quantity, cartResult.cartData);

		/*$('#cart_popup').hide();*/
		$('#cart_popup').html(cartResult.cartPopupHtml);

		$('#add_to_cart_close').click(function(e) {
			e.preventDefault();
			$('#cart_popup').hide();
		});

		$('#cart_popup').fadeIn();
		if (typeof timeoutId != 'undefined') {
			clearTimeout(timeoutId);
		}
		/*timeoutId = setTimeout(function() {$('#cart_popup').fadeOut();}, 5000);*/
		$.colorbox.close();
	},

	trackAddToCart: function(productCode, quantity, cartData) {
		if(window.trackAddToCart_jirafe) {
			trackAddToCart_jirafe(cartData);
		}

		if(window.trackAddToCart_google) {
			trackAddToCart_google(productCode, quantity);
		}
	}

};

$(document).ready(function() {
	ACC.product.bindAll();
});

