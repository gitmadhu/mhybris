<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="searchUrl" required="true" %>
<%@ attribute name="searchPageData" required="true" type="de.hybris.platform.commerceservices.search.pagedata.SearchPageData" %>
<%@ attribute name="top" required="true" type="java.lang.Boolean" %>
<%@ attribute name="supportShowAll" required="true" type="java.lang.Boolean" %>
<%@ attribute name="msgKey" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>




<c:set var="themeMsgKey" value="${not empty msgKey ? msgKey : 'search.page'}"/>

<div class="prod_refine"> <!-- changed for telco -->
	<ycommerce:testId code="searchResults_productsFound_label">
		<div class="prod_refine-box prod_refine-itemcount">
			<spring:theme code="${themeMsgKey}.totalResults" arguments="${searchPageData.pagination.totalNumberOfResults}"/>
		</div>
	</ycommerce:testId>
	<c:if test="${supportShowAll}">
		<div class="prod_refine-box prod_refine-showall">
			<spring:url value="${searchUrl}" var="showAllUrl">
				<spring:param name="show" value="All"/>
			</spring:url>
			<ycommerce:testId code="searchResults_showAll_link">
				<a href="${showAllUrl}"><spring:theme code="${themeMsgKey}.showAllResults"/></a>
			</ycommerce:testId>
		</div>
	</c:if>
	<c:if test="${not empty searchPageData.sorts}">
		<div class="prod_refine-box prod_refine-sort">
			<form id="sort_form${top ? '1' : '2'}" name="sort_form${top ? '1' : '2'}" method="get" action="#">
				<label for="sortOptions${top ? '1' : '2'}"><spring:theme code="${themeMsgKey}.sortTitle"/></label>
				<select id="sortOptions${top ? '1' : '2'}" name="sort" class="sortOptions">
					<c:forEach items="${searchPageData.sorts}" var="sort">
						<option value="${sort.code}" ${sort.selected ? 'selected="selected"' : ''}>
							<c:choose>
								<c:when test="${not empty sort.name}">
									${sort.name}
								</c:when>
								<c:otherwise>
									<spring:theme code="${themeMsgKey}.sort.${sort.code}"/>
								</c:otherwise>
							</c:choose>
						</option>
					</c:forEach>
				</select>
				<c:catch var="errorException">
					<spring:eval expression="searchPageData.currentQuery.query.value" var="dummyVar"/><%-- This will throw an exception is it is not supported --%>
					<input type="hidden" name="q" value="${searchPageData.currentQuery.query.value}"/>
				</c:catch>
			</form>
		</div>
	</c:if>
	<ul class="pager">
		<li class="pager-back">
			<c:set var="hasPreviousPage" value="${searchPageData.pagination.currentPage > 0}"/>
			<c:if test="${hasPreviousPage}">
				<spring:url value="${searchUrl}" var="previousPageUrl">
					<spring:param name="page" value="${searchPageData.pagination.currentPage - 1}"/>
				</spring:url>
				<ycommerce:testId code="searchResults_previousPage_link">
					<a href="${previousPageUrl}" class="pager-back-link" title="<spring:theme code="${themeMsgKey}.linkPreviousPage"/>">
					</a>
				</ycommerce:testId>
			</c:if>
			<c:if test="${not hasPreviousPage}">
				<a href="#" class="hidden" onclick="return false">
					<spring:theme code="${themeMsgKey}.linkPreviousPage"/>
				</a>
			</c:if>
		</li>
		<li class="pager-pages">
			<spring:theme code="${themeMsgKey}.currentPage" arguments="${searchPageData.pagination.currentPage + 1},${searchPageData.pagination.numberOfPages}"/>
		</li>
		<li class="pager-next">
			<c:set var="hasNextPage" value="${(searchPageData.pagination.currentPage + 1) < searchPageData.pagination.numberOfPages}"/>
			<c:if test="${hasNextPage}">
				<spring:url value="${searchUrl}" var="nextPageUrl">
					<spring:param name="page" value="${searchPageData.pagination.currentPage + 1}"/>
				</spring:url>
				<ycommerce:testId code="searchResults_nextPage_link">
					<a href="${nextPageUrl}" class="pager-next-link" title="<spring:theme code="${themeMsgKey}.linkNextPage"/>">
					</a>
				</ycommerce:testId>
			</c:if>
			<c:if test="${not hasNextPage}">
				<a href="#" class="hidden" onclick="return false">
					<spring:theme code="${themeMsgKey}.linkNextPage"/>
				</a>
			</c:if>
		</li>
	</ul>
</div>
