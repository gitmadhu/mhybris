<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Debug footer. Not for production. Outputs in an HTML comment --%>

<c:if test="${showStorefrontDebugInfo}">
<!-- TODO: Remove From Production
DEBUG INFO

cmsPage=${cmsPage.name}
site=${cmsSite.uid}
secure=${request.secure}
context=${request.contextPath}
requestURI=${request.requestURI}

Jalo Session details

${storefrontDebugJaloSessionAttributes}

	-->
</c:if>
