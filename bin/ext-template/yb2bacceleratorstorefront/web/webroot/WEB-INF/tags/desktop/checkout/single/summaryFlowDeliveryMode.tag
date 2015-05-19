<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryMode" required="true" type="de.hybris.platform.commercefacades.order.data.DeliveryModeData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:url value="/checkout/single/summary/getDeliveryModes.json" var="getDeliveryModesUrl"/>
<spring:url value="/checkout/single/summary/setDeliveryMode.json" var="setDeliveryModeUrl"/>

<c:set value="${not empty deliveryMode}" var="deliveryModeOk"/>


<div class="summaryDeliveryMode summarySection  ${deliveryModeOk ? 'complete' : ''}"   data-get="${getDeliveryModesUrl}" data-set="${setDeliveryModeUrl}" >
	
	

	
	
	<script id="deliveryModeSummaryTemplate" class="sectionTemplate" type="text/x-jquery-tmpl">
		<div class="headline"><span class="number">4</span><spring:theme code="checkout.summary.deliveryMode.header" htmlEscape="false"/></div>

			<ul id="checkout_summary_deliverymode_ul">
				{{if data.deliveryMode}}
					<li>{{= data.deliveryMode.name}} ({{= data.deliveryMode.code}})</li>
					<li>{{= data.deliveryMode.description}} - {{= data.deliveryMode.deliveryCost.formattedValue}}</li>
				{{else}}
					<li><spring:theme code="checkout.summary.deliveryMode.noneSelected"/></li>
				{{/if}}
			</ul>
		<button type="button" class="positive editButton"><spring:theme code="checkout.summary.deliveryMode.editDeliveryMethod"/></button>

	</script>

	<script id="deliveryModesTemplate" class="colorboxTemplate" type="text/x-jquery-tmpl">

		<div class="headline"><spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethod"/></div>
		<div class="description"><spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethodForOrder"/></div>

		<form>
			<ycommerce:testId code="checkout_deliveryModes">
				<div class="content">
			 		{{if data}}
			 			<ul id="delivery_modes_ul">
			 			{{each data}}
			 				<li>
			 					<label for='{{= code}}'>
								{{if code == selectedCode}}
			 						<input type="radio" name="delivery" value="{{= code}}"  id="{{= code}}" checked="checked" />
								{{else}}
									<input type="radio" name="delivery" value="{{= code}}"  id="{{= code}}" />
								{{/if}}
								
			 					
			 					{{= name}} - {{= description}} - {{= deliveryCost.formattedValue}}</label>
			 				</li>
			 			{{/each}}
			 			</ul>
					{{else}}
						<spring:theme code="text.checkout.noDeliveryModes"/>
			 		{{/if}}
					
				</div>
			</ycommerce:testId>
			<div class="form-actions" id="delivery_modes_button">
				{{if data}}
					<ycommerce:testId code="checkout_chooseSelectedDeliveryMethod">
						<button class="positive saveButton" ><spring:theme code="checkout.summary.deliveryMode.useThisDeliveryMethod"/></button>
					</ycommerce:testId>
				{{/if}}
			</div>
		</form>

		

	</script>
	
	<div class="contentSection"></div>
	
	
	<div style="display:none">
		<div id="summaryDeliveryModeOverlay" class="summaryOverlay ">
			<div class="headline"><spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethod"/></div>
			<div class="description"><spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethodForOrder"/></div>
		
			<form>
				<ycommerce:testId code="checkout_deliveryModes">
					<div class="content">
						<%-- available delivery modes for the cart --%>
					</div>
				</ycommerce:testId>
				<div class="form-actions" id="delivery_modes_button">
					<%-- delivery mode select button --%>
				</div>
			</form>
		
		</div>
	</div>
	
	
	
	
</div>


