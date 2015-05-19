<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/cart" var="cartUrl"/>
<a href="${cartUrl}">
	<ycommerce:testId code="miniCart_items_label">
		<spring:theme text="items" code="cart.count" arguments="${totalItems}"/>
	</ycommerce:testId>
</a>
	