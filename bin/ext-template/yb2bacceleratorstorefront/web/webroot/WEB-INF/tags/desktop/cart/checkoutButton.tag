<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>

<%@ attribute name="checkoutUrl" required="true" type="java.lang.String"%>
<%@ attribute name="basketAddToCart" required="true" type="java.lang.String"%>

<a href="${checkoutUrl}" class="positive right">
	<theme:image code="img.addToCartIcon" alt="${basketAddToCart}" title="${basketAddToCart}"/>
	<spring:theme code="checkout.checkout" />
</a>