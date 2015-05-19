<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:url value="${urlLink}" var="encodedUrl" />

<div class="simple_disp-img">
	<c:choose>
		<c:when test="${empty encodedUrl || encodedUrl eq '#'}">
			<%--<img title="${media.altText}" alt="${media.altText}" src="${media.url}">  --%>
			<c:set value="${ycommerce:lazyLoadOrStandardImageTag('lazy',media.url,media.altText,commonResourcePath.concat('/images/grey.gif'))}" var="img"/>
			${img}
		</c:when>
		<c:otherwise>
			<a href="${encodedUrl}">
			<%--<img title="${media.altText}" alt="${media.altText}" src="${media.url}"> --%>
			<c:set value="${ycommerce:lazyLoadOrStandardImageTag('lazy',media.url,media.altText,commonResourcePath.concat('/images/grey.gif'))}" var="img"/>
			${img}
			</a>
		</c:otherwise>
	</c:choose>
</div>
