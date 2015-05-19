<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>

<%@ attribute name="spinnerId" required="false" type="java.lang.String"%>

<spring:theme code="img.spinner" text="/" var="spinnerPath" />
<c:choose>
	<c:when test="${originalContextPath ne null}">
		<c:url value="${spinnerPath}" context="${originalContextPath}" var="spinnerUrl" />
	</c:when>
	<c:otherwise>
		<c:url value="${spinnerPath}" var="spinnerUrl" />
	</c:otherwise>
</c:choose>

<c:if test="${empty spinnerId}">
	<c:set var="spinnerId" value="spinner"></c:set>
</c:if>

<div id="${spinnerId}" class="spinner" style="display:none;">
	<span id="spinnerMessage">${message}</span>
	<img src="${spinnerUrl}" />
</div>
