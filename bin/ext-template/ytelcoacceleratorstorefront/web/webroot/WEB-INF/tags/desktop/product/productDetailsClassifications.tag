<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty product.classifications}">
	<c:forEach items="${product.classifications}" var="classification">
		<div class="featureClass">
		<h4>${classification.name}</h4>
		
		<script>
			$(document).ready(function() {
				$('.feature-class-tablerow').each(function(){
					var splitAt = '.';
					var dataholder = $(this).attr('data-attribute').split(splitAt);
					$(this).addClass(dataholder[dataholder.length-1]);
				});
			});
		</script>
			<table class="feature-class-table">
				<tbody>
					<c:forEach items="${classification.features}" var="feature">
						<tr class="feature-class-tablerow" data-attribute="${feature.code}"> <!-- feature identifier is needed here, without whitespace/blanks -->
							<td class="attrib">${feature.name}</td>
							<td class="attrib-value">
								<c:forEach items="${feature.featureValues}" var="value" varStatus="status">
									${value.value}
									<c:choose>
										<c:when test="${feature.range}">
											${not status.last ? '-' : feature.featureUnit.symbol}
										</c:when>
										<c:otherwise>
											${feature.featureUnit.symbol}
											${not status.last ? '<br/>' : ''}
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:forEach>
</c:if>


