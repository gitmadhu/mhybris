<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<spring:theme code="text.addToCart" var="addToCartText"/>
<c:url value="${product.url}" var="productUrl"/>

<ycommerce:testId code="product_wholeProduct">

<c:if test="${fn:contains(product.url, 'Add-Ons')}"><div class="productlist-addon"></c:if>

	<div class="prod_list">
	
		<div class="thumb">
			<a href="${productUrl}" title="${product.name}">
				<product:productPrimaryImage product="${product}" format="thumbnail"/>
			</a>
		</div>
		
		<div class="grid-product-name"> <!-- telco change -->
			<ycommerce:testId code="product_productName">
				<a href="${productUrl}" title="${product.name}">
					${product.name}
				</a>
			</ycommerce:testId>
		</div>
		
		<div class="grid-product-summary"> <!-- telco change -->
			${product.summary}
		</div>
			
		<c:if test="${not empty product.classifications}">
			<div class="grid-product-features">
				<c:forEach items="${product.classifications}" var="classification">
					<div class="featureClass">
						<table>
							<tbody>
								<c:forEach items="${classification.features}" var="feature">
									<tr>
										<td headers="header1" class="attrib">${feature.name}</td>
			
										<td headers="header1">
											<c:forEach items="${feature.featureValues}" var="value" varStatus="status">
												${value.value}
												<c:choose>
													<c:when test="${feature.range}">
														${not status.last ? '-' : feature.featureUnit.symbol}
													</c:when>
													<c:otherwise>
														${feature.featureUnit.symbol}
														${not status.last ? '<br/>' : ''}
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:forEach>
			</div>
		</c:if>				
		
		<c:if test="${not empty product.averageRating}">
			<div class="grid-product-rating">
				<span class="stars large" style="display: inherit;">
					<span style="width: <fmt:formatNumber maxFractionDigits="0" value="${product.averageRating * 24}" />px;"></span>
				</span>
				<p><fmt:formatNumber maxFractionDigits="1" value="${product.averageRating}" />/5</p>
				<p class="prod_review-info">							
					<c:choose>
							<c:when test="${(product.numberOfReviews) > 1}">
								<a href="#" id="based_on_reviews"><spring:theme code="review.based.on" arguments="${product.numberOfReviews}"/></a>
							</c:when>
							<c:otherwise>
								<a href="#" id="based_on_reviews"><spring:theme code="review.based.on.one" arguments="${product.numberOfReviews}"/></a>
							</c:otherwise>
					</c:choose>
				</p>
			</div>
		</c:if>
		
		<div class="grid-product-price">
			<ycommerce:testId code="product_productPrice">
				<spring:theme code="text.withinPackage" var="withinPackage"/>
				<c:if test="${product.lowestBundlePrice ne null and product.lowestBundlePrice.value < product.price.value}">
					<p class="price"><span class="price-label">${withinPackage}</span><format:price priceData="${product.lowestBundlePrice}"/></p>
					<del><format:price priceData="${product.price}"/></del>					
				</c:if>
				<c:if test="${product.lowestBundlePrice eq null or (product.lowestBundlePrice ne null and product.lowestBundlePrice.value >= product.price.value)}">
					<p class="price"><format:price priceData="${product.price}" displayFreeForZero="true"/></p>					
				</c:if>	
				<c:if test="${fn:contains(product.url, 'Add-Ons')}"><p class="price-frequency">${product.subscriptionTerm.billingPlan.billingTime.name}</p></c:if>	
				<c:if test="${fn:contains(product.url, 'Plans')}"><p class="price-frequency">${product.subscriptionTerm.billingPlan.billingTime.name}</p></c:if>	
			</ycommerce:testId>
			<c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">
				<c:set var="buttonType">button</c:set>
				<spring:theme code="text.addToCart.outOfStock" var="addToCartText"/>
			</c:if>
		</div>
		
	</div>

<c:if test="${fn:contains(product.url, 'Add-Ons')}"></div></c:if>		
</ycommerce:testId>
