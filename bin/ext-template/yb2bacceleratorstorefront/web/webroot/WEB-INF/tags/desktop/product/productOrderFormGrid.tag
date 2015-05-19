<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="showName" required="false" type="java.lang.Boolean"%>
<%@ attribute name="filterSkus" required="false" type="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/desktop/grid" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="categoriesSize" value="${product.categories}" />

<c:if test="${fn:length(categoriesSize) >= 3}">
	<grid:grid3dimensions product="${product}" showName="${showName}" filterSkus="${filterSkus}" />
</c:if>
<c:if test="${fn:length(categoriesSize) == 2}">
	<grid:grid2dimensions product="${product}" showName="${showName}" filterSkus="${filterSkus}" />
</c:if>
<c:if test="${fn:length(categoriesSize) == 1}">
	<grid:grid1dimension product="${product}" />
</c:if>