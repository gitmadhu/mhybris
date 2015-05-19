<%-- CHINAACC:NEWFILE --%>

<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="products" required="true" type="java.util.List"%>
<%@ attribute name="showTitleImage" required="false" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>


<c:if test="${products ne null and !empty products}">
	<c:forEach items="${products}" var="product" varStatus="status">
		<c:if test="${empty cms_tab_maxTabItems or (status.index < cms_tab_maxTabItems)}" >
	<div class="productBox">
		<a href="${contextPath}${product.url}" title="${product.name}" alt="${product.name}"><product:productPrimaryImage product="${product}" format="thumbnail"/></a>
		<p class="productName"><a href="${contextPath}${product.url}" title="${product.name}" alt="${product.name}">${product.name}</a></p>
		<p class="productPrice"><spring:theme code="text.product.price_in_mall" /><strong><format:fromPrice priceData="${product.price}"/></strong></p>
		<a href="${contextPath}${product.url}" class="btnBuyNow"><spring:theme code="text.product.buy_now" /></a>
	</div>
		</c:if>
	</c:forEach>
</c:if>
