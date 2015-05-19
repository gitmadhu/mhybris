<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<c:url value="${product.url}" var="productUrl"/>

<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function() {
	ACC.product.bindToAddToCartForm();
});
/*]]>*/
</script>

<div id="quickview_lightbox" class="resizeableColorbox">
	<div class="span-8">
		<div class="prod_image">
			<a class="modal" href="${productUrl}">
				<product:productPrimaryImage product="${product}" format="product"/>
			</a>
			<c:url value="${product.url}/zoomImages" var="productZoomImagesUrl"/>
			<a class="modal" href="${productZoomImagesUrl}" target="_blank"><span class="details"></span></a>
		</div>
	</div>
	<div class="span-9 last">
		<div class="prod">
		
			<a href="${productUrl}">
				<h1>${product.name}</h1>
			</a>
			<p class="big-price">
				<format:fromPrice priceData="${product.price}"/>
			</p>
			<p>${product.summary}</p>
			<div class="bundle">
				<c:if test="${not empty product.potentialPromotions}">
					<p>${product.potentialPromotions[0].description}</p>
				</c:if>
			</div>
			
			<div class="prod_review">
				<c:if test="${not empty product.reviews}">
					<span class="stars large" style="display: inherit;">
						<span style="width: <fmt:formatNumber maxFractionDigits="0" value="${product.averageRating * 24}" />px;"></span>
					</span>
					<p><fmt:formatNumber maxFractionDigits="1" value="${product.averageRating}" />/5</p>
				</c:if>
				<p class="prod_review-info">
					<c:if test="${not empty product.reviews}">
						<c:url value="${product.url}?tab=readreviews" var="productReadReviewsUrl"/>
						<a href="${productReadReviewsUrl}"><spring:theme code="review.based.on" arguments="${fn:length(product.reviews)}"/></a>
					</c:if>
				</p>
				<p class="prod_review-new">
					<c:url value="${product.url}?tab=writereview" var="productWriteReviewsUrl"/>
					<a href="${productWriteReviewsUrl}" title="<spring:theme code="review.write.title" />"><spring:theme code="review.write.title" /></a>
				</p>
			</div>

			<product:productAddToCartPanel product="${product}" allowAddToCart="${true}"/>

			<div class="quickview_lightbox-goto-product">
				<a href="${productUrl}"><spring:theme code="product.product.details.more"/></a>
			</div>
			
		</div>
	</div>
</div>