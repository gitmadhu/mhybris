<%--CHINAACC:NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tab" tagdir="/WEB-INF/tags/desktop/tab" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>

<div class="tabSection1">
	<div class="tabSection_head">
		<h2>${title}</h2>
		<p class="keywords"><strong><spring:theme code="text.tab.container.keywords" /></strong><c:forEach items="${links}" var="link"><cms:component component="${link}" /></c:forEach></p>
		<a class="moreKeys" href="<c:url value="${moreLink.url}" />">${moreLink.linkName}</a>
	</div>
	<div class="clearfix">
		<div class="tabSection1_l"><a href="<c:url value="${banner.urlLink}" />"><img src="${banner.media.url}" alt="" /></a></div>
		<div class="tabSection1_r tab clearfix">
			<tab:tabTitles tabData="${tabs}" maxTabs="5" showTitleImage="true"/>
			<tab:tabInners tabData="${tabs}" maxTabs="5" maxTabItems="3"/>
		</div>
	</div>
</div>
