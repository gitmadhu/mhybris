<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="showName" required="false" type="java.lang.Boolean"%>
<%@ attribute name="filterSkus" required="false" type="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/desktop/grid" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="loopIndex" value="0"/>
<c:set var="loopIndexColor" value="0"/>

<c:forEach items="${product.variantMatrix}" var="firstVariant">
	<c:if test="${empty(filterSkus) || (!empty(filterSkus) && fn:contains(filterSkus, firstVariant.variantOption.code) ) }">
		<div class="orderForm_grid_group">
			<c:set var="skusId" value="${firstVariant.variantOption.code}"/>
			<grid:coreTableHeader variant="${firstVariant}"
								  loopIndexColor="${loopIndexColor}"
								  product="${product}"
								  skusId="${skusId}"
								  showName="${showName}" />
	
			<c:set var="loopIndexColor" value="${loopIndexColor +1}"/>
			<div class="product-grid-container clear">
				<c:forEach items="${firstVariant.elements}" var="thirdVariant">
					<grid:coreTable variants="${thirdVariant.elements}"
									inputTitle="${thirdVariant.variantValueCategory.name}"
									loopIndex="${loopIndex}" />
					<c:set var="loopIndex" value="${loopIndex + fn:length(thirdVariant.elements)}"/>
				</c:forEach>
			</div>
		</div>
	</c:if>
</c:forEach>
