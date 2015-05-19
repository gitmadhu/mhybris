<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- CHINAACC_START:DELETED --%>
<%-- 
{"miniCartCount": ${totalItems}, "miniCartPrice": "<ycommerce:testId code="miniCart_total_label"><c:if test="${totalDisplay == 'TOTAL'}"><format:price priceData="${totalPrice}"/></c:if><c:if test="${totalDisplay == 'SUBTOTAL'}"><format:price priceData="${subTotal}"/></c:if><c:if test="${totalDisplay == 'TOTAL_WITHOUT_DELIVERY'}"><format:price priceData="${totalNoDelivery}"/></c:if></ycommerce:testId>"}
--%>
<%-- CHINAACC_END:DELETED --%>


<%-- CHINAACC_START --%>
{"miniCartCount": ${totalItems}, "miniCartPrice": ""}
<%-- CHINAACC_END --%>
