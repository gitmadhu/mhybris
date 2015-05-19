<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  

<script type="text/javascript">
/*<![CDATA[*/
	jQuery(document).ready(function()
	{
		jQuery('#carousel_modal').jcarousel({
			// Configuration goes here
			vertical: true,
			itemFallbackDimension: 512,
			size: 4
		});
		
		jQuery(".noaction").click(function(e) {
			e.preventDefault(); // preventing the screen from jumping since the hrefs are #
		});
		
	});
/*]]>*/
</script>


<div class="zoom_lightbox resizeableColorbox">
	<div class="span-4">
		<c:if test="${fn:length(galleryImages) gt 0}">
			<div class="scroller modal">
				<div id="thumbs">
					<ul id="carousel_modal" class="jcarousel-skin modal alt galleriffic_slider thumbs noscript">
						<c:forEach items="${galleryImages}" var="container">
							<li>
								<span class="thumb">
									<a href="#" class="noaction">
										<img src="${container.thumbnail.url}" id="${container.zoom.url}" alt="${product.name}" title="${product.name}">
									</a>
								</span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
	</div>
	
	<c:if test="${empty zoomImageUrl}">
		<c:set value="${ycommerce:productImage(product, 'zoom').url}" var="zoomImageUrl"/>
	</c:if>
	
	<c:if test="${not empty requestParams['mediaUrl'][0]}">
		<c:forEach items="${galleryImages}" var="container">
			<c:if test="${container.product.url eq requestParams['mediaUrl'][0]}">
				<c:set var="zoomImageUrl">${container.zoom.url}</c:set>
			</c:if>
		</c:forEach>
	</c:if>
	
	<div class="xl_image span-16 last">
		<c:if test="${not empty zoomImageUrl}">
			<img src="${zoomImageUrl}" id="xl_image_a" alt="${product.name}" title="${product.name}"/>
		</c:if>
	</div>

</div>

<script type="text/javascript">
/*<![CDATA[*/
	$("#carousel_modal img").click(function() {
		$("#xl_image_a").attr("src", $(this).attr("id"));
	});

	// We only want these styles applied when javascript is enabled
	$('div.navigation').css({'width' : '300px', 'float' : 'left'});
	$('div.content').css('display', 'block');

	$(document).ready(function() {
		// Initialize Minimal Galleriffic Gallery
		$('#thumbs').galleriffic({
			imageContainerSel: '#slideshow'
		});
	});
/*]]>*/
</script>
