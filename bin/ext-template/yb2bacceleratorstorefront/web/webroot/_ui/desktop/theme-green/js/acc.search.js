var ACC = ACC || {}; // make sure ACC is available

ACC.search = {
	/*
	* Register selectors for later re-use.
	*/
	$selectedProductIdsContainer: $("#js-selected-product-ids"),
	$productIdsInput:             $("#js-product-ids"),
	$addProductIdsButton:         $("#js-add-product-ids"),
	$enableProductIdsCheckBox:    $("#js-enable-product-ids"),
	$productIdTagBoxTemplate:     $("#product-id-tag-box-template"),
	$removeProductIdButton:       $(".js-remove-product-id"),
	$advSearchButton:             $(".adv_search_button"),
	$skusHidden:                  $("#skus"),
	$searchCurrentLabel:          $(".searchInput label"),
	$createOrderFormButton:		  $("#js-create-order-form-button"),
	$createOrderFormCheckbox:	  $(".js-checkbox-sku-id, .js-checkbox-base-product"),
	$baseProductCheckBox:		  $(".js-checkbox-base-product"),
	$skuIDCheckbox:				  $(".js-checkbox-sku-id"),

	/*
	* Register all the event handlers.
	*/
	bindAll: function() {
		with (ACC.search) {
			bindToAddProductIds($addProductIdsButton);
			bindToToggleProductIds($enableProductIdsCheckBox);
			bindToRemoveProductId($removeProductIdButton);
			bindToAdvSearchButton($advSearchButton);
			bindToCreateOrderFormButton($createOrderFormButton);
			bindToBaseProductCheckBox($baseProductCheckBox);
			bindToSkuIDCheckBox($skuIDCheckbox);
		}
	},

	/*
	* Event handlers
	*/
	bindToAdvSearchButton: function(advSearchButton) {
		advSearchButton.click(function(event) {
			ACC.search.stripoutInvalidChars();

			if (ACC.search.$enableProductIdsCheckBox.attr("checked") === "checked") {
				if (ACC.search.$productIdsInput.val() != "") {
					ACC.search.$addProductIdsButton.click();
				}
				ACC.search.$productIdsInput.val(ACC.search.$skusHidden.val());
				ACC.search.$skusHidden.val("");
			}
		});
	},
	
	bindToCreateOrderFormButton: function(createOrderFormButton) {
		createOrderFormButton.click(function(event) {
			ACC.search.stripoutInvalidChars();

			ACC.search.$productIdsInput.val(ACC.search.$skusHidden.val());
			$("#isCreateOrderForm").val(true);
			
			var skusIds = [];
			ACC.search.$createOrderFormCheckbox.each(function() {
				
				if (this.checked) {
					skusIds.push(this.value);
				} 
				
			});

			ACC.search.$productIdsInput.val(skusIds.join(","));	
			ACC.search.$selectedProductIdsContainer.empty();
			ACC.search.$skusHidden.val("");
			ACC.search.$enableProductIdsCheckBox.attr("checked",false);
			// hide the add button
			ACC.search.$addProductIdsButton.hide();
			
			ACC.search.$advSearchButton.click();

		});
	},
	
	bindToBaseProductCheckBox: function(baseProductCheckBox){
		baseProductCheckBox.click(function(event) {
			var baseProduct = this;
			$(ACC.search.$skuIDCheckbox).each(function (){
				if ($(this).attr("base-product-code") && $(this).attr("base-product-code") === baseProduct.value){
					$(this).attr("checked",baseProduct.checked);
				}				
			})
		});
	},

	bindToSkuIDCheckBox: function(skuIDCheckbox){
		skuIDCheckbox.click(function(event) {
			var skuID = this;
			var baseProduct = $(skuID).attr("base-product-code");

			var hasChecked = false;
			$(ACC.search.$skuIDCheckbox).each(function (){
				if (baseProduct === $(this).attr("base-product-code") && $(this).attr("checked")){
					hasChecked = true;
				}				
			})
			
			$(".js-checkbox-base-product").each(function (){
				if (baseProduct === this.value){
					$(this).attr("checked",hasChecked);
				}				
			})	
			
		});
	},	
	// Add product id event handler
	bindToAddProductIds: function(addProductIdsButton) {
		addProductIdsButton.click(function(event) {
			if (ACC.search.$enableProductIdsCheckBox.attr("checked") === "checked") {
				event.preventDefault();
				
				// TODO: allow the delimiter being configurable!
				ACC.search.stripoutInvalidChars();
				var productIds = ACC.search.$productIdsInput.val().split(",");
	
				var presentProductIds = ACC.search.$skusHidden;
				
				//merge new ids with the present ones
				if(presentProductIds.val() != undefined && presentProductIds.val() !== ""){
					var persistentIds = presentProductIds.val().split(",");

					for(var i = 0; i < persistentIds.length; i++){
						productIds.push(persistentIds[i]);
					}
				}
				
				//  clean product ids
				productIds = $.map(productIds, function(productId, index){ return ($.trim(productId)); });
				productIds = $.unique(productIds);
				
				// create the tags by using a template
				$.each(productIds, function(index, productId) {
					var $existingProductId = ACC.search.$selectedProductIdsContainer.find("#product-id-" + productId + "-tag");
	
					if (productId !== '' && $existingProductId.length === 0) {
						// Render the product id tag boxes using the template
						ACC.search.$productIdTagBoxTemplate
							.tmpl({productId: productId, index:index})
							.appendTo(ACC.search.$selectedProductIdsContainer);
					}
	
				});
				
				//now write all ids back to one hidden field
				presentProductIds.val(productIds.join(","));
	
				// clear the input field
				ACC.search.$productIdsInput.val('');
				ACC.search.$productIdsInput.focus();
			}
		});
	},

	// Add product ids search enable checkbox handler
	bindToToggleProductIds: function(addProductIdsCheckBox) {
		addProductIdsCheckBox.on("change", function(event) {
			var checked = $(this).attr("checked") === "checked";

			ACC.search.replaceSearchLabel(checked);
			
			if (checked) {
				// show the add product ids button
				ACC.search.$addProductIdsButton.show();
			}
			else {
				// move the added product id tags back into the input
				var joinedProductIds = $.map(
							ACC.search.$selectedProductIdsContainer.find(".product-id-tag-box span"),
							function(index) { return $(index).text() })
						.join(", ");

				if (joinedProductIds !== "") {
					ACC.search.$productIdsInput.val(joinedProductIds);
				}
				// clear product id tags
				ACC.search.$selectedProductIdsContainer.empty();
				ACC.search.$skusHidden.val("");
				// hide the add button
				ACC.search.$addProductIdsButton.hide();
			}
		});

	},

	// Add remove product id event handler
	bindToRemoveProductId: function(removeProductIdButton) {
		removeProductIdButton.live("click", function(event) {
			event.preventDefault();
			var valueToRemove = $('#'.concat($(this).parent().attr("id").concat(' span'))).html();
			ACC.search.cleanupInvalidCommas(valueToRemove);
			$(this).parent().remove();
		});
	},
	
	replaceSearchLabel: function(productIdsChecked) {
		var currentLabel = ACC.search.$searchCurrentLabel.html();
		var searchByIdsLabel = $("#searchByIdsLabel").val();
		var searchByKeywordLabel = $("#searchByKeywordLabel").val();

		if (productIdsChecked) {
			currentLabel = currentLabel.replace(searchByKeywordLabel, searchByIdsLabel);
		} else {
			currentLabel = currentLabel.replace(searchByIdsLabel, searchByKeywordLabel);
		}
		ACC.search.$searchCurrentLabel.html(currentLabel);
	},
	
	stripoutInvalidChars: function() {
		ACC.search.$productIdsInput.val(ACC.search.$productIdsInput.val().replace(/[^a-z0-9 ,.\-_]/ig, ''));
	},
	
	cleanupInvalidCommas: function(valueToRemove) {
		ACC.search.$skusHidden.val(ACC.search.$skusHidden.val().replace(new RegExp("\\b"+valueToRemove+"\\b","gi"), ""));
		ACC.search.$skusHidden.val(ACC.search.$skusHidden.val().replace(new RegExp("\\,,\\b","gi"), ","));
		ACC.search.$skusHidden.val(ACC.search.$skusHidden.val().replace(/(,$)|(^,)/g, ''));
	}
};

$(document).ready(function() {
	// Bind all the event handlers
	ACC.search.bindAll();
	
	var productIdsChecked = (ACC.search.$enableProductIdsCheckBox.attr("checked") === "checked") ;
	if (productIdsChecked) {
		ACC.search.replaceSearchLabel(productIdsChecked);
		ACC.search.$addProductIdsButton.show();
		ACC.search.$addProductIdsButton.click();
	}
	
});
