ACC.futurelink = {
	$futureStockLink: $(".futureStockLink"),

	bindAll: function() {
		ACC.futurelink.bindFutureStockLink();
	},
	
	bindFutureStockLink: function() {
		ACC.futurelink.$futureStockLink.on("click", function(e) {
			e.preventDefault();

			$.colorbox({
				href:       $(this).attr("href"),
				width:      440,
				height:     200,
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
