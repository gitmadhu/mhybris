<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="isOrderForm" required="false" type="java.lang.Boolean" %>
<%@ attribute name="table" required="false" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>


<c:choose>
	<c:when test="${not table}">
		<div class="big-price right">
			<format:fromPrice priceData="${product.price}" />
		</div>
	</c:when>
	<c:otherwise>
		<c:if test="${not empty product.volumePrices}">
			<table class="volume-prices" cellpadding="0" cellspacing="0" border="0">
				<thead>
					<tr>
						<th class="volume-prices-quantity"><spring:theme code="product.volumePrices.column.qa"/></th>
						<th class="volume-price-amount"><spring:theme code="product.volumePrices.column.price"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="volPrice" items="${product.volumePrices}">
						<tr>
							<td class="volume-price-quantity">
								<c:choose>
									<c:when test="${empty volPrice.maxQuantity}">
										${volPrice.minQuantity}+
									</c:when>
									<c:otherwise>
										${volPrice.minQuantity}-${volPrice.maxQuantity}
									</c:otherwise>
								</c:choose>
							</td>
							<td class="volume-price-amount">${volPrice.formattedValue}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</c:otherwise>
</c:choose>
