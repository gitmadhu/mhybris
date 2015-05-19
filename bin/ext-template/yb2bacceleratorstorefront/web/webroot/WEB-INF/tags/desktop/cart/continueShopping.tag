<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>

<%@ attribute name="continueShoppingUrl" required="true" type="java.lang.String"%>

<form action="#" method="get" class="left">
	<button type="submit" class="form" onclick="window.location = '${continueShoppingUrl}'; return false">
		<spring:theme text="Continue Shopping" code="cart.page.continue"/>
	</button>
</form>