ACC.productlisting = {

	infiniteScrollingConfig: {offset: '100%'},
	currentPage:             0,
	numberOfPages:           Number.MAX_VALUE,
	showMoreResultsArea:    $('#footer'),
	baseQuery:               $("#resultsList").attr("data-current-query")   || "",
	isOrderForm:             $("#resultsList").attr("data-isOrderForm")      || false,
	isOnlyProductIds:        $("#resultsList").attr("data-isOnlyProductIds") || false,
	searchPath:			 	 $("#resultsList").attr("data-current-path"),
	isCreateOrderForm:		 $("#isCreateOrderForm").val() || false,
	lastDataHtml:			 "",

	triggerLoadMoreResults: function() {
		if (ACC.productlisting.currentPage < ACC.productlisting.numberOfPages) {
			// show the page loader
			ACC.common.showSpinnerById('spinner');
			ACC.productlisting.loadMoreResults(parseInt(ACC.productlisting.currentPage) + 1);
		}
	},

	scrollingHandler: function(event, direction) {
		if (direction === "down") {
			ACC.productlisting.triggerLoadMoreResults();
		}
	},

	loadMoreResults: function(page) {
		skuIndex = "0";

		if ($("#skuIndexSavedValue").attr("data-sku-index") !== undefined) {
			skuIndex = $("#skuIndexSavedValue").attr("data-sku-index");
		}
		
		searchResultType = $("[name='searchResultType']:radio:checked").val() || "";

		$.ajax({
			url: ACC.productlisting.searchPath + "/results?q=" + ACC.productlisting.baseQuery + "&page=" + page + "&isOnlyProductIds=" + ACC.productlisting.isOnlyProductIds +
				"&isOrderForm=" + ACC.productlisting.isOrderForm + "&skuIndex=" + skuIndex + "&isCreateOrderForm=" + ACC.productlisting.isCreateOrderForm + "&searchResultType=" + searchResultType,
			success: function (data) {
				if (data.pagination !== undefined) {

					if ($("#resultsList").length > 0 && ACC.productlisting.lastDataHtml !== data.productListerHtml) { //Product List Page
						ACC.productlisting.lastDataHtml = data.productListerHtml;
						$("#resultsList").append(data.productListerHtml);
						// rebind the add-to-cart ajaxForms
						ACC.product.bindToAddToCartForm({enforce: true});
						if ($("#skuIndexSavedValue").attr("data-sku-index") !== undefined){
							$("#skuIndexSavedValue").attr("data-sku-index", data.skuIndex);
						}
					}

					ACC.productlisting.updatePaginationInfos(data.pagination);
					ACC.common.hideSpinnerById('spinner');
					ACC.productlisting.showMoreResultsArea.waypoint(ACC.productlisting.infiniteScrollingConfig); // reconfigure waypoint eventhandler
				}
				else {
					ACC.common.hideSpinner();
				}
			},
			error: function (request, status, error) {
				alert(error);
			}
		});
	},

	updatePaginationInfos: function(paginationInfo) {
		ACC.productlisting.currentPage   = parseInt(paginationInfo.currentPage);
		ACC.productlisting.numberOfPages = parseInt(paginationInfo.numberOfPages);
	},

	bindShowMoreResults: function(showMoreResultsArea) {
		showMoreResultsArea.live("click", function() {
			ACC.productlisting.triggerLoadMoreResults();
		});

		showMoreResultsArea.waypoint(ACC.productlisting.scrollingHandler,
									 ACC.productlisting.infiniteScrollingConfig);
	},

	bindSortingSelector: function() {
		$('#sort_form1, #sort_form2').change(function() {
			this.submit();
		});
	},

	initialize: function() {
		with(ACC.productlisting) {
			bindShowMoreResults(showMoreResultsArea);
			bindSortingSelector();
		}
	}
};

$(document).ready(function() {
	ACC.productlisting.initialize();
});