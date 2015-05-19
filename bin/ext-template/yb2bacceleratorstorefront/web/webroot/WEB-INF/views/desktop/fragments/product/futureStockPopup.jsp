<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<div class="zoom_lightbox resizeableColorbox futureStockPopup">
	<product:productDetailsFutureStock product="${product}" futureStocks="${futureStocks}" />
</div>
