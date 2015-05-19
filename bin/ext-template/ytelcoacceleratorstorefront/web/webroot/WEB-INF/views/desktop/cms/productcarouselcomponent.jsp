<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<c:if test="${not empty productData}">

<div class="scroller vertical">
	<div class="title_holder">
		<h2>${title}</h2>
	</div>
	<ul class="carousel jcarousel-skin jcarousel-horizontal">
		<c:forEach items="${productData}" var="product">

			<c:url value="${product.url}" var="productUrl"/>
			<li>
				<a href="${productUrl}" title="${product.name} - <format:fromPrice priceData="${product.price}"/>">
					<span>
						<product:productPrimaryImage product="${product}" format="thumbnail"/>
					</span>
					<h3>
							${product.name}
					</h3>
					<p>
						<format:fromPrice priceData="${product.price}"/>
					</p>
				</a>
			</li>
		</c:forEach>
	</ul>
</div>
</c:if>
