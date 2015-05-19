<%--CHINAACC:NEWFILE --%>

<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="tabData" required="true" type="java.util.List"%>
<%@ attribute name="maxTabs" required="false" type="java.lang.Integer"%>
<%@ attribute name="maxTabItems" required="false" type="java.lang.Integer"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>

<c:if test="${maxTabItems ne null}">
	<c:set var="cms_tab_maxTabItems" value="${maxTabItems}" scope="request" />
</c:if>
<ul class="tabInner">
<c:if test="${tabData ne null and !empty tabData}">
	<c:forEach items="${tabData}" var="tab" varStatus="status">
		<c:if test="${empty maxTabs or (status.index < maxTabs)}" >
		<li class="clearfix"><cms:component component="${tab}" /></li>
		</c:if>
	</c:forEach>
</c:if>
</ul>
<c:if test="${maxTabItems ne null}">
	<c:remove var="cms_tab_maxTabItems" scope="request" />
</c:if>
