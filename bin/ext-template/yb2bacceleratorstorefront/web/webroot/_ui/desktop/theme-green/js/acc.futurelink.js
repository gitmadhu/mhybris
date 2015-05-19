ACC.futurelink = {
	bindAll: function() {
		this.bindFutureStockLink();
	},
	
	bindFutureStockLink: function() {
		$(document).on("click",".futureStockLink", function(e) {
			e.preventDefault();
			$.colorbox({
				href:       $(this).attr("href"),
				width:      440,
				height:     250,
				onComplete: function() {
					$.colorbox.resize();
				}
			});
		})
	}

};

$(document).ready(function() {
	ACC.futurelink.bindAll();
});
