<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="company" tagdir="/WEB-INF/tags/desktop/company" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ attribute name="node" required="true"
			  type="de.hybris.platform.b2bacceleratorfacades.company.data.B2BUnitNodeData" %>

<spring:url value="/my-company/organization-management/manage-units/details"
			var="unitDetailUrl">
	<spring:param name="unit" value="${node.id}"/>
</spring:url>
<li>
	<a href="${unitDetailUrl}"  class="${node.active? '' : 'disabled'}">${node.name}</a>

	<c:if test="${fn:length(node.children) > 0}">
		
		<ul>
			<c:forEach var="node" items="${node.children}">
				<company:unitTree node="${node}"/>
			</c:forEach>
		</ul>
	</c:if>
</li>




