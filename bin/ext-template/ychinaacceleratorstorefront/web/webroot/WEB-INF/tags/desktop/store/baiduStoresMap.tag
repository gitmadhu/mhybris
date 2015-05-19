<%-- CHINAACC:NEWFILE --%>
<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="citiesData" required="false" type="java.util.List"%>
<%@ attribute name="storesData" required="false" type="java.util.List"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store" %>

	<div class="store_map" id="bmap_canvas"></div>
	
