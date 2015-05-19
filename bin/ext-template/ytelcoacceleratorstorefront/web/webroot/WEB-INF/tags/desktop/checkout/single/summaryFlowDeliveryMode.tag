<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryMode" required="true" type="de.hybris.platform.commercefacades.order.data.DeliveryModeData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<spring:url value="/checkout/single/summary/getDeliveryModes.json" var="getDeliveryModesUrl" />
<spring:url value="/checkout/single/summary/setDeliveryMode.json" var="setDeliveryModeUrl" />

<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function() {
		bindEditDeliveryMethodButton();
	});

	function bindEditDeliveryMethodButton()
	{
		$('div.checkout_summary_flow_b .change_mode_button').click(function() {

			$.ajax({
				url: '${getDeliveryModesUrl}',
				type: 'POST',
				dataType: 'json',
				success: function(data) {
					// Fill the available delivery addresses and select button
					$('#delivery_modes_dl').html($('#deliveryModesTemplate').tmpl({deliveryModes: data}));
					$('#delivery_modes_button').html($('#deliveryModeButton').tmpl({deliveryModes: data}));
					

					// Show the delivery modes popup
					$.colorbox({inline:true, href:"#popup_checkout_delivery_modes", height: false, overlayClose: false});
					
					bindUseThisDeliveryMode();
				},
				error: function(xht, textStatus, ex) {
					alert("Failed to get delivery modes. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				}
			});
			return false;
		});
	}

	function bindUseThisDeliveryMode()
	{
		$('#use_this_delivery_method').click(function() {
			var selectedCode = $('input:radio[name=delivery]:checked').val();
			if(selectedCode)
			{
				$.ajax({
					url: '${setDeliveryModeUrl}',
					type: 'POST',
					dataType: 'json',
					data: {modeCode: selectedCode},
					success: function(data) {
						if(data != null)
						{
							//alert("delivery mode set successfully");
							refreshPage(data);
							parent.$.colorbox.close();
						}
						else
						{
							alert("Failed to set delivery mode");
						}
					},
					error: function(xht, textStatus, ex) {
						alert("Ajax call failed while trying to set delivery mode. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
					}
				});
			}
			return false;
		});
	}

	function refreshDeliveryMethodSection(data)
	{
		$('#checkout_summary_deliverymode_div').replaceWith($('#deliveryModeSummaryTemplate').tmpl(data));
		bindEditDeliveryMethodButton();
	}
/*]]>*/
</script>

<script id="deliveryModeSummaryTemplate" type="text/x-jquery-tmpl">

	<div class="checkout_summary_flow_b {{if deliveryMode}}complete{{/if}}" id="checkout_summary_deliverymode_div">
		<div class="item_container_holder">
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
					{{if deliveryMode}}
						<li>{{= deliveryMode.name}} ({{= deliveryMode.code}})</li>
						<li>{{= deliveryMode.description}} - {{= deliveryMode.deliveryCost.formattedValue}}</li>
					{{else}}
						<li><spring:theme code="checkout.summary.deliveryMode.noneSelected"/></li>
					{{/if}}
				</ul>
			</div>
		</div>
		{{if deliveryMode}}
		<ycommerce:testId code="checkout_changeDeliveryMode_element">
		<a href="#" class="edit_complete change_mode_button"><spring:theme code="checkout.summary.deliveryMode.editDeliveryMethod"/></a>
		</ycommerce:testId>
		{{else}}
		<ycommerce:testId code="checkout_changeDeliveryMode_element">
		<button class="form change_mode_button"><spring:theme code="checkout.summary.deliveryMode.editDeliveryMethod"/></button>
		</ycommerce:testId>
		{{/if}}
	</div>

</script>

<script id="deliveryModesTemplate" type="text/x-jquery-tmpl">

	{{if !deliveryModes.length}}
		<spring:theme code="text.checkout.noDeliveryModes"/>
	{{/if}}
	{{if deliveryModes.length}}
		{{each deliveryModes}}
			<dt class="left">
				{{if $index == 0}}
					<input type="radio" name="delivery" value="{{= $value.code}}" checked="checked"/>
				{{else}}
					<input type="radio" name="delivery" value="{{= $value.code}}" />
				{{/if}}
				<label for='{{= $value.code}}'>{{= $value.name}} - {{= $value.description}} - {{= $value.deliveryCost.formattedValue}}</label>
			</dt>
			<dd></dd>
		{{/each}}
	{{/if}}

</script>

<script id="deliveryModeButton" type="text/x-jquery-tmpl">
	{{if deliveryModes.length}}
		<ycommerce:testId code="checkout_chooseSelectedDeliveryMethod">
			<button class="form" id="use_this_delivery_method"><spring:theme code="checkout.summary.deliveryMode.useThisDeliveryMethod"/></button>
		</ycommerce:testId>
	{{/if}}
</script>


<c:set value="${not empty deliveryMode}" var="deliveryModeOk"/>

<div class="checkout_summary_flow_b ${deliveryModeOk ? 'complete' : ''}" id="checkout_summary_deliverymode_div">
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
					<c:choose>
						<c:when test="${deliveryModeOk}">
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
						</c:when>
						<c:otherwise>
							<li><spring:theme code="checkout.summary.deliveryMode.noneSelected"/></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</ycommerce:testId>
	</div>

	<ycommerce:testId code="checkout_changeDeliveryMode_element">
		<c:choose>
			<c:when test="${deliveryModeOk}">
				<a href="#" class="edit_complete change_mode_button"><spring:theme code="checkout.summary.deliveryMode.editDeliveryMethod"/></a>
			</c:when>
			<c:otherwise>
				<button class="form change_mode_button"><spring:theme code="checkout.summary.deliveryMode.editDeliveryMethod"/></button>
			</c:otherwise>
		</c:choose>
	</ycommerce:testId>
</div>

<div style="display:none">
	<div id="popup_checkout_delivery_modes">

		<div class="span-20 last">
			<div class="item_container_holder">
				<div class="title_holder">
					<div class="title">
						<div class="title-top">
							<span></span>
						</div>
					</div>
					<h2><spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethod"/></h2>
				</div>
				<div class="item_container">
				<p><spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethodForOrder"/></p>
				<form>
					<ycommerce:testId code="checkout_deliveryModes">
						<dl id="delivery_modes_dl">
							<%-- available delivery modes for the cart --%>
						</dl>
					</ycommerce:testId>
					<span style="display: block; clear: both;" id="delivery_modes_button">
						<%-- delivery mode select button --%>
					</span>
				</form>
				</div>
			</div>
		</div>

	</div>
</div>