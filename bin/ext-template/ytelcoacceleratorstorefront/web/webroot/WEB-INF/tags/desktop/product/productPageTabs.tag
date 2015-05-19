<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div id="prod_tabs">
	<ycommerce:testId code="productOptions_tabs">
		<ul class="tab_strip" id="tab_strip">
			<li id="tab_01">
				<h2>
					<a href="#tab-details" class="tab_01" title="<spring:theme code="product.product.details" />"><spring:theme code="product.product.details" /></a>
				</h2>
			</li>
			<li>
				<h2>
					<a href="#tab-reviews" class="tab_03" title="<spring:theme code="review.reviews" />"><spring:theme code="review.reviews" /></a>
				</h2>
			</li>
		</ul>
	</ycommerce:testId>
	<div class="prod_content" id="tab-details">
		<product:productDetailsTab product="${product}"/>
	</div>
	<div class="prod_content" id="tab-reviews">
		<h3><spring:theme code="review.reviews" /></h3>
		<product:productPageReviewsTab product="${product}"/>
	</div>
</div>

<cms:slot var="tabs" contentSlot="${slots.Tabs}">
	<cms:component component="${tabs}"/>
</cms:slot>
<c:if test="${showReviewForm}">
	<script>
	/*<![CDATA[*/
		$(function() {
			$("#prod_tabs").tabs( {selected: $('#tab_strip').children().size() - 1});
		});
	/*]]>*/
	</script>
</c:if>
<c:if test="${!showReviewForm}">
	<script>
	/*<![CDATA[*/
		$(function() {
			$( "#prod_tabs" ).tabs({ selected: 0 });
		});
	/*]]>*/
	</script>
</c:if>