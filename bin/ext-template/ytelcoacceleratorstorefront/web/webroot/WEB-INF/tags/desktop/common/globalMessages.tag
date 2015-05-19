<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>

<%-- Information (confirmation) messages --%>
<c:if test="${not empty accConfMsgs}">
	<div class="span-24">
		<c:forEach items="${accConfMsgs}" var="confMsg">
			<div class="information_message positive">
				<span class="single"></span>
				<p><spring:theme code="${confMsg}"/></p>
			</div>
		</c:forEach>
	</div>
</c:if>

<%-- Warning messages --%>
<c:if test="${not empty accInfoMsgs}">
	<div class="span-24">
		<c:forEach items="${accInfoMsgs}" var="infoMsg">
			<div class="information_message neutral">
				<span class="single"></span>
				<p><spring:theme code="${infoMsg}"/></p>
			</div>
		</c:forEach>
	</div>
</c:if>

<%-- Error messages (includes spring validation messages)--%>
<c:if test="${not empty accErrorMsgs}">
	<div class="span-24">
		<c:forEach items="${accErrorMsgs}" var="errorMsg">
			<div class="information_message negative">
				<span class="single"></span>
				<p><spring:theme code="${errorMsg}"/></p>
			</div>
		</c:forEach>
	</div>
</c:if>