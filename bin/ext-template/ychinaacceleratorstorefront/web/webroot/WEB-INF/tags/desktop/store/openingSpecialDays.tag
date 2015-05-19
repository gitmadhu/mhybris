<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>

<%@ attribute name="openingSchedule" required="true" type="de.hybris.platform.commercefacades.storelocator.data.OpeningScheduleData" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store"%>

<%-- CHINAACC_START --%>
<%@ attribute name="jsCR" required="false" type="java.lang.String" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- CHINAACC_END --%>

<%-- CHINAACC_START:DELETED --%>
<%--
<c:if test="${not empty openingSchedule}">
	<ycommerce:testId code="storeDetails_table_openingSchedule_label">
		<table class="store-openings specialday_openings">
			<tbody>
				<c:forEach items="${openingSchedule.specialDayOpeningList}" var="specialDay">
					<tr>
						<td class="specialday_openings_date">${specialDay.formattedDate}</td>
						<td class="specialday_openings_name">${specialDay.name}</td>
						<td class="specialday_openings_times">
							<c:choose>
								<c:when test="${specialDay.closed}" >
										<spring:theme code="storeDetails.table.opening.closed" />
								</c:when>
								<c:otherwise>
									${specialDay.openingTime.formattedHour} - ${specialDay.closingTime.formattedHour}
								</c:otherwise>
							</c:choose>
						</td>
						<td class="specialday_openings_comment">${specialDay.comment}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</ycommerce:testId>
</c:if>
--%>
<%-- CHINAACC_START:DELETED --%>

<%-- CHINAACC_START --%>
<c:if test="${not empty openingSchedule}">
	<ycommerce:testId code="storeDetails_table_openingSchedule_label">
		<table class="store-openings specialday_openings">${jsCR}
			<tbody>${jsCR}
				<c:forEach items="${openingSchedule.specialDayOpeningList}" var="specialDay">
					<tr>${jsCR}
						<td class="specialday_openings_date">${specialDay.formattedDate}</td>${jsCR}
						<td class="specialday_openings_name">${fn:replace(specialDay.name, "\'", "&#39;")}</td>${jsCR}
						<td class="specialday_openings_times">${jsCR}
							<c:choose>
								<c:when test="${specialDay.closed}" >
										<spring:theme code="storeDetails.table.opening.closed" />${jsCR}
								</c:when>
								<c:otherwise>
									${specialDay.openingTime.formattedHour} - ${specialDay.closingTime.formattedHour}${jsCR}
								</c:otherwise>
							</c:choose>
						</td>${jsCR}
						<td class="specialday_openings_comment">${fn:replace(specialDay.comment, "\'", "&#39;")}</td>${jsCR}
					</tr>${jsCR}
				</c:forEach>
			</tbody>${jsCR}
		</table>${jsCR}
	</ycommerce:testId>
</c:if>
<%-- CHINAACC_END --%>
