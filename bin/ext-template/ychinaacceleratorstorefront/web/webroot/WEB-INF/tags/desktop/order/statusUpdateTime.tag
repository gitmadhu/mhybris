<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData" %>
<%@ attribute name="orderStatus" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
	<c:when test="${orderStatus eq 'CREATED'}">
		<fmt:formatDate value="${order.created}" dateStyle="long" pattern="yyyy-MM-dd" type="date"/><br/><fmt:formatDate value="${order.created}" type="time"/>
	</c:when>
	<c:otherwise>
		<c:forEach items="${order.statusUpdatedRecords}" var="entry">
			<c:if test="${entry.status == orderStatus}">
				<c:set var="statusCreated" value="${entry.created}" />
			</c:if>
		</c:forEach>
		<fmt:formatDate value="${statusCreated}" dateStyle="long" pattern="yyyy-MM-dd" type="date"/><br/><fmt:formatDate value="${statusCreated}" type="time"/>
	</c:otherwise>
</c:choose>
