<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="checkout" tagdir="/WEB-INF/tags/desktop/checkout/single" %>

<spring:url value="/checkout/single/summary/getSavedCards.json" var="getSavedCardsUrl" />
<spring:url value="/checkout/single/summary/setPaymentDetails.json" var="setPaymentDetailsUrl"/>
<spring:url value="/checkout/single/summary/getPaymentDetailsForm.json" var="getPaymentDetailsFormUrl"/>

<script type="text/javascript">
	var getSavedCardsUrl = '${getSavedCardsUrl}';
		setPaymentDetailsUrl = '${setPaymentDetailsUrl}';
		getPaymentDetailsFormUrl = '${getPaymentDetailsFormUrl}';
</script>





<c:set value="${not empty paymentInfo}" var="paymentInfoOk"/>
<c:set value="${not empty paymentInfo and not empty paymentInfo.billingAddress}" var="billingAddressOk"/>





<div class="summaryPayment summarySection " 
	data-datatype="text"  
	data-security-what-text="<spring:theme code='checkout.summary.paymentMethod.securityCode.whatIsThis.description'/>" data-get="${getPaymentDetailsUrl}"  
	data-get-saved-cards-url='${getSavedCardsUrl}'>
	
	<script id="paymentSummaryTemplate" class="sectionTemplate" type="text/x-jquery-tmpl">
		<div class="summaryPayment clearfix"  data-security-what-text="${securityWhatText}">
			<div class="headline"><span class="number">3</span><spring:theme code="checkout.summary.paymentMethod.header" htmlEscape="false"/></div>
	             <div class="column">
	 				
				
				
					<ul>
						{{if data.paymentInfo}}
							<li>{{= data.paymentInfo.cardNumber}}</li>
							<li>{{= data.paymentInfo.cardType}}</li>
							<li><spring:theme code="checkout.summary.paymentMethod.paymentDetails.expires" arguments="{{= data.paymentInfo.expiryMonth}},{{= data.paymentInfo.expiryYear}}"/></li>
						{{else}}
							<li><spring:theme code="checkout.summary.paymentMethod.paymentDetails.noneSelected"/></li>
						{{/if}}
					</ul>
 				

	 				{{if data.paymentInfo}}
	 					<form>
	 						<div class="control-group security">
	 							<label for="SecurityCodePayment"><spring:theme code="checkout.summary.paymentMethod.securityCode"/>*</label>
	 							<div class="controls">
	 								<input type="text" class="text security" id="SecurityCodePayment"/>
	 								<a href="#" class="security_code_what"><spring:theme code="checkout.summary.paymentMethod.securityCode.whatIsThis"/></a>
	 							</div>
	 						</div>
	 					</form>
	 				{{/if}}
				
				
	             </div>
		
	             <div class="column">
	 					{{if data.paymentInfo}}
	 					<strong><spring:theme code="checkout.summary.paymentMethod.billingAddress.header"/></strong>
						<ul>
							{{if data.paymentInfo.billingAddress}}
								<li>{{= data.paymentInfo.billingAddress.title}} {{= data.paymentInfo.billingAddress.firstName}} {{= data.paymentInfo.billingAddress.lastName}}</li>
								<li>{{= data.paymentInfo.billingAddress.line1}}</li>
								<li>{{= data.paymentInfo.billingAddress.line2}}</li>
								<li>{{= data.paymentInfo.billingAddress.town}}</li>
								<li>{{= data.paymentInfo.billingAddress.postalCode}}</li>
								<li>{{= data.paymentInfo.billingAddress.country.name}}</li>
							{{/if}}
						</ul>
	 				{{/if}}
	             </div>

  
			
				<ycommerce:testId code="checkout_changePayment_element">
				<button type="button" class="positive editButton" ><spring:theme code="checkout.summary.paymentMethod.editPaymentMethod"/></button>
				</ycommerce:testId>
		
 
	 </div>



	</script>

	<script id="savedCardsTemplate" class="colorboxTemplate"  type="text/x-jquery-tmpl">
		<div class="headline"><spring:theme code="checkout.summary.paymentMethod.savedCards.header"/></div>
		<div class="description"><spring:theme code="checkout.summary.paymentMethod.savedCards.selectSavedCardOrEnterNew"/></div>
		<button type="submit" class="enterNewPayment"><spring:theme code="checkout.summary.paymentMethod.savedCards.enterNewPaymentDetails"/></button>
	
	
	
	
			<form id="savedPaymentList" style="clear:both;">
				<ycommerce:testId code="paymentAddress_addressesTable_table">
			
		{{if !savedCards.length}}
			
			<spring:theme code="checkout.summary.paymentMethod.savedCards.noExistingSavedCards"/>
				
		{{/if}}
		{{if savedCards.length}}
		<div class="paymentList">
			{{each savedCards}}
			<div class="paymentEntry">
					
					
						<ul>
							<li>{{= $value.cardNumber}}</li>
							<li>{{= $value.cardType}}</li>
							<li><spring:theme code="checkout.summary.paymentMethod.paymentDetails.expires" arguments="{{= $value.expiryMonth}},{{= $value.expiryYear}}"/></li>
						</ul>
						<ul>
							<li>{{= $value.billingAddress.title}} {{= $value.billingAddress.firstName}} {{= $value.billingAddress.lastName}}</li>
							<li>{{= $value.billingAddress.line1}}</li>
							<li>{{= $value.billingAddress.line2}}</li>
							<li>{{= $value.billingAddress.town}}</li>
							<li>{{= $value.billingAddress.postalCode}}</li>
							<li>{{= $value.billingAddress.country.name}}</li>
						</ul>
						<button class="positive useCard" data-payment='{{= $value.id}}'><spring:theme code="checkout.summary.paymentMethod.savedCards.UseThisSavedCard"/></button>
					
				</div>
			{{/each}}
			<div>
		{{/if}}
				</ycommerce:testId>
			</form>
		</div>

	</script>
	
	
	
	
	
	
	
	
   <ycommerce:testId code="checkout_paymentDetails_text">
          <div class="contentSection"></div>
   </ycommerce:testId>
   
	<ycommerce:testId code="checkout_changePayment_element">
	</ycommerce:testId>
	
	<div style="display:none">
		<div class="summaryOverlay clearfix summaryPaymentOverlay" id="summaryPaymentOverlay"></div>
		<div class="summaryOverlay clearfix summaryPaymentOverlay" id="summaryPaymentOverlayEnterNew"><checkout:paymentDetailsForm/></div>

		<div id="summaryPaymentOverlayContainer"></div>
	</div>
</div>


