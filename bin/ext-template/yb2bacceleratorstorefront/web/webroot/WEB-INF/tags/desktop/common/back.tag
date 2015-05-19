<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ attribute name="cancelUrl" required="false" type="java.lang.String"%>

<div class="last right">
    <c:choose>
    	<c:when test="${not empty cancelUrl}">
   		    <a class="back_button" href="${cancelUrl}">
    	</c:when>
        <c:when test="${param.page >= 0 or param.show == 'All'}">
            <a class="back_button" href="${savedHeader}">
        </c:when>
        <c:otherwise>
            <a class="back_button" href="${header['referer']}">
            <c:set var="savedHeader" scope="session" value="${header['referer']}"/>
        </c:otherwise>
    </c:choose>
    <button id="backButton" class="form" type="submit"><spring:theme code="text.back" text="Back"/></button></a>
</div>
