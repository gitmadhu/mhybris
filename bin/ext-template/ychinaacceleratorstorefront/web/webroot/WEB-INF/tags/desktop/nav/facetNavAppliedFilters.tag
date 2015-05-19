<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="pageData" required="true" type="de.hybris.platform.commerceservices.search.facetdata.ProductSearchPageData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>


<c:if test="${not empty pageData.breadcrumbs}">

	<div class="headline"><spring:theme code="search.nav.appliedFilters"/>	</div>
	<div class="facet product_grid_search_factor clearfix"">
	<div class="facetValues">
		<ul class="facet_block">
			<c:forEach items="${pageData.breadcrumbs}" var="breadcrumb">
				<li class="remove_item_left">
					<c:url value="${breadcrumb.removeQuery.url}" var="removeQueryUrl"/>
					<span class="remove_item_left_name">${breadcrumb.facetValueName}</span>
					<span class="remove"><a href="${removeQueryUrl}" ></a></span>
					<div class="clear"></div>
				</li>
			</c:forEach>
		</ul>
	</div>
	<%--CHINAACC_START --%>
	<div>
		<c:choose >
			<c:when test="${! empty pageData.freeTextSearch}">
			<a href="${pageData.freeTextSearch}"><spring:theme code="text.facet.clearAll" /></a>
			</c:when>
			<c:when test="${! empty pageData.keywordRedirectUrl}">
				<a href="${pageData.keywordRedirectUrl}"><spring:theme code="text.facet.clearAll" /></a>
			</c:when>
			<c:otherwise>
				<a href="${requestScope['javax.servlet.forward.request_uri']}"><spring:theme code="text.facet.clearAll" /></a>
			</c:otherwise>
		</c:choose>
	</div>
	<%--CHINAACC_END --%>
	</div>

</c:if>
