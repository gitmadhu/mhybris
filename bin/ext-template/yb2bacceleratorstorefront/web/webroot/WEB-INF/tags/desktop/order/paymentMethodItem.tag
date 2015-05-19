<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order" %>

<div class="orderBox payment">
	<div class="headline"><spring:theme code="text.paymentMethod" text="Payment Method" /></div>
	<c:if test="${order.paymentType.code eq 'CARD'}">
		<order:paymentMethodItemOnCreditCard order="${order}"/>
	</c:if>
	<c:if test="${order.paymentType.code eq 'ACCOUNT'}">
		<order:paymentMethodItemOnAccount order="${order}"/>
	</c:if>
</div>




