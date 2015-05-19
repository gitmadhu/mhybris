<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>


<c:if test="${paginationType eq 'infiniteScroll'}">
	<common:spinner/>
</c:if>
