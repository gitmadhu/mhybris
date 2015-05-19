<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="code" required="true" type="java.lang.String" %>
<%@ attribute name="format" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:set value="${ycommerce:productCodeImage(product, code, format)}" var="productImage"/>

<c:choose>
	<c:when test="${not empty productImage}">
		<img src="${productImage.url}" alt="${product.name}" title="${product.name}"/>
	</c:when>
	<c:otherwise>
		<theme:image code="img.missingProductImage.${format}" alt="${product.name}" title="${product.name}"/>
	</c:otherwise>
</c:choose>