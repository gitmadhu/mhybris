<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryMode" required="true" type="de.hybris.platform.commercefacades.order.data.DeliveryModeData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div class="checkout_summary_flow_b complete" id="checkout_summary_deliverymode_div">
	<div class="item_container_holder">
		<ycommerce:testId code="checkout_deliveryModeData_text">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="checkout.summary.deliveryMode.header" htmlEscape="false"/><span></span></h2>
			</div>

			<div class="item_container">
				<ul>
					<li>${deliveryMode.name} (${deliveryMode.code})</li>

					<script type="text/javascript">
						$(document).ready(function() {
							var str = $(".deliverymode-description").text();
							if(str.length > 180){
								str = str.substr(0,180)+'...';
							}
							$(".deliverymode-description").html(str);
						});
					</script>
					<li class="deliverymode-description" title="${deliveryMode.description} - ${deliveryMode.deliveryCost.formattedValue}">${deliveryMode.description} - ${deliveryMode.deliveryCost.formattedValue}</li>
				</ul>
			</div>
		</ycommerce:testId>
	</div>

	<ycommerce:testId code="checkout_changeDeliveryMode_element">
		<a href="<c:url value="/checkout/multi/choose-delivery-method"/>" class="edit_complete change_mode_button"><spring:theme code="checkout.summary.deliveryMode.editDeliveryMethod"/></a>
	</ycommerce:testId>
</div>