<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="format" required="true" type="java.lang.String" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:set value="${ycommerce:productImage(product, format)}" var="primaryImage"/>

<c:choose>
	<c:when test="${not empty primaryImage}">
		<c:choose>
			<c:when test="${not empty primaryImage.altText}">
				<%-- <img src="${primaryImage.url}" alt="${fn:escapeXml(primaryImage.altText)}" title="${fn:escapeXml(primaryImage.altText)}"/> --%>
				<c:set value="${ycommerce:lazyLoadOrStandardImageTag('lazy',primaryImage.url,fn:escapeXml(primaryImage.altText),commonResourcePath.concat('/images/grey.gif'))}" var="img"/>
				${img}
			</c:when>
			<c:otherwise>
				<%-- <img src="${primaryImage.url}" alt="${fn:escapeXml(product.name)}" title="${fn:escapeXml(product.name)}"/> --%>
				<c:set value="${ycommerce:lazyLoadOrStandardImageTag('lazy',primaryImage.url,fn:escapeXml(product.name),commonResourcePath.concat('/images/grey.gif'))}" var="img"/>
				${img}
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<theme:image code="img.missingProductImage.${format}" alt="${fn:escapeXml(product.name)}" title="${fn:escapeXml(product.name)}"/>
	</c:otherwise>
</c:choose>