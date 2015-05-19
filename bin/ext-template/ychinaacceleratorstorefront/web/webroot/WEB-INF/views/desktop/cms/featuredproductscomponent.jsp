<%--CHINAACC:NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tab" tagdir="/WEB-INF/tags/desktop/tab" %>

<div class="product_category_inner clearfix">
	<h2>${title}</h2>
	<tab:productsTab products="${productData}" />
</div>