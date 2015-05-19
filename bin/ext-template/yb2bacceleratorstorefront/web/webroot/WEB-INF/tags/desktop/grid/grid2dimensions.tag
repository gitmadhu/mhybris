<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="showName" required="false" type="java.lang.Boolean"%>
<%@ attribute name="filterSkus" required="false" type="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/desktop/grid" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="loopIndex" value="0"/>
<c:set var="loopIndexColor" value="0"/>

<c:set var="titleQuantityText"><spring:theme code="product.grid.quantityText" /></c:set>

<c:forEach items="${product.variantMatrix}" var="headVariant">
	<c:if test="${empty(filterSkus) || (!empty(filterSkus) && fn:contains(filterSkus, firstVariant.variantOption.code) ) }">
		<div class="orderForm_grid_group   ffffffffffff">
			<c:set var="skusId" value="${headVariant.variantOption.code}"/>
			<grid:coreTableHeader variant="${headVariant}"
								  loopIndexColor="${loopIndexColor}"
								  product="${product}"
								  skusId="${skusId}"
								  showName="${showName}" />
	
			<c:set var="loopIndexColor" value="${loopIndexColor +1}"/>
			<div class="product-grid-container clear">
				<grid:coreTable variants="${headVariant.elements}"
								inputTitle="${titleQuantityText}"
								loopIndex="${loopIndex}" />
				<c:set var="loopIndex" value="${loopIndex + fn:length(headVariant.elements)}" />
			</div>
		</div>
	</c:if>
</c:forEach>