<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="variants" required="true" type="java.util.List"%>
<%@ attribute name="inputTitle" required="true" type="java.lang.String"%>
<%@ attribute name="loopIndex" required="true" type="java.lang.Integer"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/desktop/grid" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<c:if test="${not empty sessionScope.skuIndex}">
	<c:set var="loopIndex" value="${sessionScope.skuIndex}"/>
</c:if>

<div class="single_grid_three_dimensions">
<table class="grid_three_dimensions clear">
	<tr>
		<th>${variants[0].parentVariantCategory.name}</th>
		<c:forEach items="${variants}" var="variant">
			<th>${variant.variantValueCategory.name}</th>
		</c:forEach>
	</tr>
	<tr>
		<td><spring:theme code="product.grid.yourPrice" /></td>
		<c:set var="loopIndexPrice" value="${loopIndex}"/>
		<c:forEach items="${variants}" var="variant">
			<td>
				<format:price priceData="${variant.variantOption.priceData}"/>
				<input type=hidden id="productPrice[${loopIndexPrice}]" value="${variant.variantOption.priceData.value}" />
			</td>
			<c:set var="loopIndexPrice" value="${loopIndexPrice +1}"/>
		</c:forEach>
	</tr>
	<tr>
		<td>${inputTitle}</td>
		<c:forEach items="${variants}" var="variant">
			<c:set var="inputType" value="textbox" />
			<c:if test="${variant.variantOption.stock.stockLevel == 0}">
				<c:set var="inputType" value="hidden" />
			</c:if>
			<td>
				<input type="hidden" class="${skusId} sku"  name="cartEntries[${loopIndex}].sku" id="cartEntries[${loopIndex}].sku" value="${variant.variantOption.code}" />
				<input type="${inputType}" class="sku-quantity" name="cartEntries[${loopIndex}].quantity" id="cartEntries[${loopIndex}].quantity" value="0" />
			</td>
			<c:set var="loopIndex" value="${loopIndex +1}"/>
			<c:set var="skuIndex" scope="session" value="${sessionScope.skuIndex + 1}"/>
		</c:forEach>
	</tr>
	<grid:coreTableStockRow variants="${variants}" />
</table>
</div>
