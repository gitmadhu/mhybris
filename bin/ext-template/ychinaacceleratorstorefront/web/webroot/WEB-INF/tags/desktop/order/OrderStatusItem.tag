<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="status" required="true" type="String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<c:if test="${not empty status}">
<spring:theme code="text.accout.order.status.${status}" text=""/>
</c:if>
<c:if test="${empty status}">
<spring:theme code="text.accout.order.status.AWAITING_PAYMENT" text=""/>
</c:if>







	

