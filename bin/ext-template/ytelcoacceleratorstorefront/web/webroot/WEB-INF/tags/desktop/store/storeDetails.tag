<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="store" required="true" type="de.hybris.platform.commercefacades.storelocator.data.PointOfServiceData" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store" %>

<div class="store_details">
	<table id="store_details">
		<thead>
			<tr>
				<th><h1><spring:theme code="storeDetails.title" /></h1></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty store.formattedDistance}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.distance" /></td>
					<td>
						<c:choose>
							<c:when test="${not empty locationQuery}">
								<spring:theme code="storeDetails.table.distanceFromSource" argumentSeparator="^" arguments="${store.formattedDistance}^${fn:escapeXml(locationQuery)}"/>
							</c:when>
							<c:otherwise>
								<spring:theme code="storeDetails.table.distanceFromCurrentLocation" argumentSeparator="^" arguments="${store.formattedDistance}"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty store.address.line1 || not empty store.address.line2 ||
						  not empty store.address.town || not empty store.address.country.name ||
						  not empty store.address.postalCode}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.address" /></td>
					<td>
						<ul>
							<li>${store.address.line1}</li>
							<li>${store.address.line2}</li>
							<li>${store.address.town}</li>
							<li>${store.address.postalCode}</li>
							<li>${store.address.country.name}</li>
						</ul>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty store.address.phone}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.telephone" /></td>
					<td>${store.address.phone}</td>
				</tr>
			</c:if>
			<c:if test="${not empty store.address.email}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.email" /></td>
					<td><a href="mailto:${store.address.email}">${store.address.email}</a></td>
				</tr>
			</c:if>
			<c:if test="${not empty store.openingHours}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.opening" /></td>
					<td>
						<store:openingSchedule openingSchedule="${store.openingHours}" />
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty store.openingHours.specialDayOpeningList}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.openingSpecialDays" /></td>
					<td>
						<store:openingSpecialDays openingSchedule="${store.openingHours}" />
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty store.features}">
				<tr>
					<td class="strong"><spring:theme code="storeDetails.table.features" /></td>
					<td>
						<ul>
							<c:forEach items="${store.features}" var="feature">
								<li>${feature.value}</li>
							</c:forEach>
						</ul>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
