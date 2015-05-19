<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="breadcrumbs" required="true" type="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:url value="/" var="homeUrl"/>
<ul>
	<li>
		<a href="${homeUrl}"><spring:message code="breadcrumb.home"/></a>
	</li>

	<c:forEach items="${breadcrumbs}" var="breadcrumb">
		<li class="${breadcrumb.linkClass}">

			<c:choose>

				<c:when test="${breadcrumb.url eq '#'}">
					<a href="#" onclick="return false;">&#062; ${breadcrumb.name}</a>
				</c:when>

				<c:otherwise>
					<c:url value="${breadcrumb.url}" var="breadcrumbUrl"/>
					<a href="${breadcrumbUrl}">&#062; ${breadcrumb.name}</a>
				</c:otherwise>

			</c:choose>
		</li>
	</c:forEach>
</ul>