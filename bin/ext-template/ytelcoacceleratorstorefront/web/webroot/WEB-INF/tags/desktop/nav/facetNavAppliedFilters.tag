<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="pageData" required="true" type="de.hybris.platform.commerceservices.search.facetdata.ProductSearchPageData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>


<c:if test="${not empty pageData.breadcrumbs}"> <!-- removed unneccesary search term for telco-->
<div class="nav_column applied-filters"> <!-- changed for telco -->
	<div class="title_holder">
		<div class="title">
			<div class="title-top">
				<span></span>
			</div>
		</div>
		<h2><spring:theme code="search.nav.appliedFilters"/></h2>
	</div>
	<div class="item">
		<ul class="facet_block">
			<li>
				<c:url value="/search?text=${ycommerce:encodeUrl(pageData.freeTextSearch)}" var="freeTextSearchUrl"/>
				<a href="${freeTextSearchUrl}">${pageData.freeTextSearch}</a>
			</li>
			<c:forEach items="${pageData.breadcrumbs}" var="breadcrumb">				
				<li>
					<c:url value="${breadcrumb.removeQuery.url}" var="removeQueryUrl"/>
					<a href="${removeQueryUrl}"><spring:theme code="search.nav.appliedFacet" arguments="${breadcrumb.facetName}^${breadcrumb.facetValueName}" argumentSeparator="^"/></a>
					<span class="remove">					
						<a href="${removeQueryUrl}">						
							<spring:theme code="search.nav.removeAttribute" var="removeFacetAttributeText"/>
							<theme:image code="img.iconSearchFacetDelete" title="${iconCartRemove}"/>
						</a>
					</span>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
</c:if>
