<%--CHINAACC:NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tab" tagdir="/WEB-INF/tags/desktop/tab" %>

<div class="adTab tab">
	<tab:tabTitles tabData="${tabs}" maxTabs="4"/>
	<tab:tabInners tabData="${tabs}" maxTabs="4" maxTabItems="5"/>
</div>
                	