<%--CHINAACC:NEWFILE --%>

<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="tabData" required="true" type="java.util.List"%>
<%@ attribute name="showTitleImage" required="false" type="java.lang.Boolean"%>
<%@ attribute name="maxTabs" required="false" type="java.lang.Integer"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<ul class="clearfix navi">		
<c:if test="${tabData ne null and !empty tabData}">
	<c:forEach items="${tabData}" var="tab" varStatus="status">
		<c:if test="${empty maxTabs or (status.index < maxTabs)}" >
	<li ${status.first ? 'class = "on"' : ''}><a href="javascript:void(0);"><c:if test="${showTitleImage}"><img src="${tab.titleImage.url}" alt="" /></c:if>${tab.title}</a></li>
		</c:if>
	</c:forEach>
</c:if>
</ul>