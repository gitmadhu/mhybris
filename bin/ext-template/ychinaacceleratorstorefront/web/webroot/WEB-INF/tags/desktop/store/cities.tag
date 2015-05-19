<%-- CHINAACC:NEWFILE --%>
<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="store" required="false" type="de.hybris.platform.commercefacades.storelocator.data.PointOfServiceData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<div class="mapListBox">
<p class="titleP"><spring:theme code="storelocator.stores.of.country" /></p>
	<div class="mapListInner clearfix">
	<ycommerce:testId code="CitiesList">	
		<p><spring:theme code="storelocator.city.of.store" />:<span id="countryLink" style="cursor:pointer;text-decoration:underline;text-underline-position:auto;"><spring:theme code="storelocator.country.map" /></span></p>
		<div class="mapListInner2 clearfix">
			<div class="mapListInner3">
				<ul class="clearfix">
			<c:if test="${not empty cities}">
				<c:forEach items="${cities}" var="city">
					<li id="${city.cityPK}" cityLng="${city.geoPoint.longitude}" cityLat="${city.geoPoint.latitude}" storeCount="${city.storeCount}" class="city" ><a href="javascript:void(0);">${city.cityName} (${city.storeCount})</a></li>
				</c:forEach>
			</c:if>
				</ul>
			</div>
			<c:if test="${not empty cities and fn:length(cities) gt 14}">
			<div class="btnMore on"><a href="javascript:void(0);"><spring:theme code="storelocator.city.links.more" /></a></div>
			</c:if>
		</div>
	</ycommerce:testId>
	</div>
</div>