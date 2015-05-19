<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="bundleNo" required="true" type="java.lang.Integer" %>
<%@ attribute name="componentId" required="true" type="java.lang.String" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:theme code="text.addToCart" var="addToCartText"/>
<c:url value="${product.url}" var="productUrl"/>
<c:url value="/bundle/addEntry" var="addToCartBundle" />

<ycommerce:testId code="product_wholeProduct">


<c:if test="${fn:contains(product.url, 'Add-Ons')}"><div class="productlist-addon"></c:if>

	<div class="prod_list <c:if test="${product.disabled}">prod_list-disabled</c:if>">
		
		<div class="thumb">
			<a><product:productPrimaryImage product="${product}" format="thumbnail"/></a>
		</div>
		

		<c:if test="${product.disabled}">
			<span class="product-disabled-message">
				<spring:theme code="product.list.cannotPurchaseReason" text="Product cannot be purchased because of: {0}" arguments="${product.disabledMessage}" argumentSeparator="!!!!"/>				
			</span>
		</c:if>
		
		<div class="grid-product-name">
			<ycommerce:testId code="product_productName">
				<a>${product.name}</a>
			</ycommerce:testId>
		</div>
		
		<div class="grid-product-summary"> 
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
				<c:if test="${product.thisBundleProductPrice.value ne null and product.thisBundleProductPrice.value lt product.price.value}">
					<del><format:price priceData="${product.price}"/></del>
					<p class="price"><format:price priceData="${product.thisBundleProductPrice}" displayFreeForZero="true"/></p>					
				</c:if>
				<c:if test="${product.thisBundleProductPrice.value eq null or product.thisBundleProductPrice.value ge product.price.value}">
					<p class="price"><format:price priceData="${product.price}" displayFreeForZero="true"/></p>					
				</c:if>
						
				<p class="price-frequency"> ${product.subscriptionTerm.billingPlan.billingTime.name} </p>		
			</ycommerce:testId>
			<c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">
				<c:set var="buttonType">button</c:set>
				<spring:theme code="text.addToCart.outOfStock" var="addToCartText"/>
			</c:if>
		</div>
		
		
		<c:if test="${!product.disabled}">									
			<form:form id="bundleAddToCartForm${product.code}" action="${addToCartBundle}" method="post">
				<div id="${product.code}" class="select-device">
					<button type="submit" class="positive small delayed-button" title="<spring:theme code="guidedselling.select.device.select.button" />">
						<spring:theme code="guidedselling.select.device.select.button" />
					</button>
				</div>
				<input type="hidden" name="productCodePost" value="${product.code}"/>
				<input type="hidden" name="quantity" value="1"/>
				<input type="hidden" name="bundleNo" value="${bundleNo}"/>
				<input type="hidden" name="bundleTemplateId" value="${componentId}"/>	
				<input type="hidden" name="removeCurrentProducts" value="true"/>	
				<input type="hidden" name="navigation" value="NEXT"/>					
			</form:form>
		</c:if>
	</div>

<c:if test="${fn:contains(product.url, 'Add-Ons')}"></div></c:if>		
</ycommerce:testId>
