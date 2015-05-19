<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url value="p/${product.code}/zoomImages?galleryPosition=POSITION" var="zoomImageUrlTemplate"/>

<script  type="text/javascript">
/*<![CDATA[*/

function initWriteReviewAction() {
	$('#write_review_action_main').click(function(e){
		e.preventDefault();
		$.scrollTo('#prod_tabs', 300, {axis: 'y'});
		$('#reviews').hide();
		$('#write_reviews').show();
		$( "#prod_tabs" ).tabs( "option", "selected", $('#tab_strip').children().size() - 1 );
		$('#reviewForm input[name=headline]').focus();
	});
}

function initBasedOnReviewsAction() {
	$('#based_on_reviews').click( function(e) {
		e.preventDefault();
		$.scrollTo('#prod_tabs', 300, {axis: 'y'});
		$( "#prod_tabs" ).tabs( "option", "selected", $('#tab_strip').children().size() - 1 );
		$('#write_reviews').hide();
		$('#reviews').show();
		$('#read_reviews_action').click();
		
	});
}

function initPageEvents() {
	$(".modal").colorbox();
	$("#carousel_alternate img").click(function() {
		$("#primary_image .modal img").attr("src", $(this).attr("data-primaryimagesrc"));
		$("#zoomLink").attr("href", "${zoomImageUrlTemplate}".replace("POSITION", $(this).attr("data-galleryposition")));
		$("#imageLink").attr("href", "${zoomImageUrlTemplate}".replace("POSITION", $(this).attr("data-galleryposition")));
	});

	initWriteReviewAction();
	initBasedOnReviewsAction();
	initializeConfirmQtysEvents();


	$("#Size").change(function () {
		var url = "";
		var selectedIndex = 0;
		$("#Size option:selected").each(function () {
			url = $(this).attr('value');
			selectedIndex = $(this).attr("index");
		});
		if (selectedIndex != 0) {
			window.location.href=url;
		}
	});
	
	$(".selectPriority").change(function () {
		var url = "";
		var selectedIndex = 0;

		url = $(this).attr('value');
		selectedIndex = $(this).attr("index");

		if (selectedIndex != 0) {
			window.location.href=url;
		}
	});
	

	$("#variant").change(function () {
		var url = "";
		var selectedIndex = 0;
		
		$("#variant option:selected").each(function () {
			url = $(this).attr('value');
			selectedIndex = $(this).attr("index");
		});
		if (selectedIndex != 0) {
			window.location.href=url;
		}
	});

	$('#addToCartBtn').click(function() {
		window.onbeforeunload = null;
		$('#AddToCartOrderForm').die();

		$.ajax({
			url:         $('#AddToCartOrderForm').attr("action"),
			type:        'POST',
			dataType:    'json',
			contentType: 'application/json',
			data:        ACC.productorderform.toJSON($('#AddToCartOrderForm'), true),
			async:       false,
			success: function (response) {
				ACC.product.displayAddToCartPopup(response);
				ACC.productorderform.cleanValues();
				$('.sku-quantity, .qty').die('keyup');
				initializeConfirmQtysEvents();
			},
			error: function(jqXHR, textStatus, errorThrown) {
				// log the error to the console
				console.log("The following error occured: " + textStatus, errorThrown);
			}
		});

	});

}

function initializeConfirmQtysEvents(){
	var gridOrderChanged = false,
		$qtyInput = $('.sku-quantity, .qty'),
		$window   = $(window);

	$qtyInput.die();
	$qtyInput.keyup(function() {
		gridOrderChanged = true;

		if (/\D/g.test(this.value)) {
			// Filter non-digits from input value.
			this.value = this.value.replace(/\D/g, '');
		}

	});

	$window.unbind('beforeunload');
	$window.bind('beforeunload', function() {
		if(gridOrderChanged) {
			return $('#AddToCartOrderForm').attr('data-grid-confirm-message');
		}
	});
}


$(document).ready(function() {
	
	initPageEvents();
	
	setTimeout(function() {
		if($.query.get('tab') == 'writereview') {
			$('#write_review_action_main').click();
		}
		if($.query.get('tab') == 'readreviews') {
			$('#based_on_reviews').click();
		}
	}, 100);
	
});


/*]]>*/
</script>