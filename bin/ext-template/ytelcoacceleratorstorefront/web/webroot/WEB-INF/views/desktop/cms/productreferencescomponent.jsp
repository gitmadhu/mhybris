<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<c:if test="${not empty productReferences}">
	<c:if test="${component.maximumNumberProducts > 0}">
	
		<div class="scroller vertical">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2>${component.title}</h2>
			</div>
			<ul class="carousel jcarousel-skin jcarousel-horizontal">
				<c:forEach end="${component.maximumNumberProducts}" items="${productReferences}" var="productReference">
					<c:url value="${productReference.target.url}/quickView" var="productQuickViewUrl"/>
					<li>
						<span>
							<a href="${productQuickViewUrl}">
								<product:productPrimaryImage product="${productReference.target}" format="thumbnail"/>
							</a>
						</span>
						<c:if test="${component.displayProductTitles}">
							<h3><a href="${productQuickViewUrl}">${productReference.target.name}</a></h3>
						</c:if>
						<c:if test="${component.displayProductPrices}">
							<p>
								<a href="${productQuickViewUrl}">
									<format:fromPrice priceData="${productReference.target.price}"/>
								</a>
							</p>
						</c:if>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
</c:if>