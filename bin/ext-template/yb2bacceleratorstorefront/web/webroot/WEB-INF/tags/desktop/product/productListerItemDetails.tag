<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="skipSummary" required="false" type="java.lang.Boolean" %>

<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:url var="productUrl" value="${product.multidimensional and not empty product.firstVariantUrl ? product.firstVariantUrl : product.url}" />

<a href="${productUrl}" title="<c:out value='${product.name}' />" class="productMainLink clearfix">
	<div class="thumb">
		<c:if test="${not empty product.averageRating}">
				<span class="stars large" style="display: inherit;">
				<span style="width: <fmt:formatNumber maxFractionDigits="0" value="${product.averageRating * 24}" />px;"></span>
			</span>
		</c:if>

		<product:productPrimaryImage product="${product}" format="thumbnail"/>
		<c:if test="${not empty product.potentialPromotions and not empty product.potentialPromotions[0].productBanner}">
			<img class="promo" src="${product.potentialPromotions[0].productBanner.url}" alt="${product.potentialPromotions[0].description}" title="${product.potentialPromotions[0].description}"/>
		</c:if>
	</div>
	
	
	
	<div class="price"><product:productListerItemPrice product="${product}" /></div>

	<ycommerce:testId code="searchPage_productName_link_${product.code}">
		<div class="head">${product.name}</div>
	</ycommerce:testId>
		
		

	<div class="details">
		<product:productListerClassifications product="${product}"/>
	</div>

</a>