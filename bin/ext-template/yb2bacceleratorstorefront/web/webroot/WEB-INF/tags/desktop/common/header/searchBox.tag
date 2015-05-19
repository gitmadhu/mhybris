<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<div class="search">
	<form name="search_form" method="get" action="<c:url value="/search"/>">
		<spring:theme code="text.search" var="searchText"/>
		<label class="skip" for="search">${searchText}</label>
		<spring:theme code="search.placeholder" var="searchPlaceholder"/>
		<ycommerce:testId code="header_search_input">
			<input id="search" class="text" type="text" name="text" value="" maxlength="100" placeholder="${searchPlaceholder}"/>
		</ycommerce:testId>
		<ycommerce:testId code="header_search_button">
			<spring:theme code="img.searchButton" text="/" var="searchButtonPath"/>
			<c:choose>
				<c:when test="${originalContextPath ne null}">
					<c:url value="${searchButtonPath}" context="${originalContextPath}" var="searchImageUrl"/>
				</c:when>
				<c:otherwise>
					<c:url value="${searchButtonPath}" var="searchImageUrl"/>
				</c:otherwise>
			</c:choose>
			<input class="button" type="image" src="${searchImageUrl}" alt="${searchText}" />
		</ycommerce:testId>
	</form>
</div>
<div class="search-advanced">
	<a href="<c:url value="/search/advanced"/>"><spring:theme code="search.advanced" /></a>
</div>