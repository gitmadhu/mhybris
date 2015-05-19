<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<c:if test="${not empty productAccessories}">
	<c:if test="${component.maximumNumberProducts > 0}">
	
	<div class="productreferences-container two-column-grid">
			<h2>${component.title}</h2>
			<ul class="jcarousel-skin jcarousel-horizontal">
			<c:forEach end="${component.maximumNumberProducts}" items="${productAccessories}" var="compatibleProduct">
			<li>
				<div class="prod_list">
				<c:url value="${compatibleProduct.url}" var="productUrl"/>
					<div class="thumb">
						<a href="${productUrl}">
							<product:productPrimaryImage product="${compatibleProduct}" format="thumbnail"/>
						</a>
					</div>
					<c:if test="${component.displayProductPrices}">
						<p class="prod-list price-below">
							<a href="${productUrl}">
								<format:fromPrice priceData="${compatibleProduct.price}"/>
							</a>
						</p>
					</c:if>
					<c:if test="${component.displayProductTitles}">
						<h3><a href="${productUrl}">${compatibleProduct.name}</a></h3>
					</c:if>
				</div>
				</li>
			</c:forEach>
			</ul>
		</div>
	</c:if>
</c:if>