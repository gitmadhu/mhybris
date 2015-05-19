<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/form" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>

<spring:url value="/checkout/single/summary/createUpdatePaymentDetails.json" var="createUpdatePaymentUrl"/>


<form:form method="post" commandName="paymentDetailsForm" action="${createUpdatePaymentUrl}" class="create_update_payment_form ${not empty createUpdateStatus ? createUpdateStatus : ''}" >
	<common:globalMessages/>
	
		
		<div class="headline"><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.header"/></div>
		
		<div class="required right"><spring:theme code="form.required"/></div>
		<div class="description"></div>
	
		<div style="margin:0 -20px 0 0;clear:both;">

			<form:hidden path="paymentId" class="create_update_payment_id" />
			<formElement:formSelectBox idKey="cardType" labelKey="payment.cardType" path="cardTypeCode" mandatory="true" skipBlank="false" skipBlankMessageKey="payment.cardType.pleaseSelect" items="${cardTypes}" tabindex="1"/>
			<formElement:formInputBox idKey="nameOnCard" labelKey="payment.nameOnCard" path="nameOnCard" inputCSS="text" mandatory="true" tabindex="2"/>
			<formElement:formInputBox idKey="cardNumber" labelKey="payment.cardNumber" path="cardNumber" inputCSS="text" mandatory="true" tabindex="3"/>
			<fieldset id="startDate" class="cardDate">
				<legend><spring:theme code="payment.startDate"/></legend>
				<formElement:formSelectBox idKey="StartMonth" labelKey="payment.month" path="startMonth" mandatory="true" skipBlank="false" skipBlankMessageKey="" items="${months}" tabindex="4"/>
				<formElement:formSelectBox idKey="StartYear" labelKey="payment.year" path="startYear" mandatory="true" skipBlank="false" skipBlankMessageKey="" items="${startYears}" tabindex="5"/>
			</fieldset>
			<fieldset class="cardDate">
				<legend><spring:theme code="payment.expiryDate"/></legend>
				<formElement:formSelectBox idKey="ExpiryMonth" labelKey="payment.month" path="expiryMonth" mandatory="true" skipBlank="false" skipBlankMessageKey="" items="${months}" tabindex="6"/>
				<formElement:formSelectBox idKey="ExpiryYear" labelKey="payment.year" path="expiryYear" mandatory="true" skipBlank="false" skipBlankMessageKey="" items="${expiryYears}" tabindex="7"/>
			</fieldset>
			<div id="issueNum">
			    <formElement:formInputBox idKey="payment.issueNumber" labelKey="payment.issueNumber" path="issueNumber" inputCSS="text" mandatory="false" tabindex="8"/>
			</div>
		</div>
	
<div class="headline clear"><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.billingAddress"/></div>
<div class="required right"><spring:theme code="form.required"/></div>
<div class="description"><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.billingAddressDiffersFromDeliveryAddress"/></div>

		<div>
			
				<form:checkbox id="differentAddress" path="newBillingAddress" tabindex="9"/>
				<label for="differentAddress"><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.enterDifferentBillingAddress"/></label>
			
		</div>


		<div id="newBillingAddressFields"  style="margin:0 -20px 0 0;">
			<form:hidden path="billingAddress.addressId" class="create_update_address_id" data-status="${not empty createUpdateStatus ? createUpdateStatus : ''}"/>
			<formElement:formSelectBox idKey="address.title" labelKey="address.title" path="billingAddress.titleCode" mandatory="true" skipBlank="false" skipBlankMessageKey="address.title.pleaseSelect" items="${titles}" tabindex="10"/>
			<formElement:formInputBox idKey="address.firstName" labelKey="address.firstName" path="billingAddress.firstName" inputCSS="text" mandatory="true" tabindex="11"/>
			<formElement:formInputBox idKey="address.surname" labelKey="address.surname" path="billingAddress.lastName" inputCSS="text" mandatory="true" tabindex="12"/>
			<formElement:formInputBox idKey="address.line1" labelKey="address.line1" path="billingAddress.line1" inputCSS="text" mandatory="true" tabindex="13"/>
			<formElement:formInputBox idKey="address.line2" labelKey="address.line2" path="billingAddress.line2" inputCSS="text" mandatory="false" tabindex="14"/>
			<formElement:formInputBox idKey="address.townCity" labelKey="address.townCity" path="billingAddress.townCity" inputCSS="text" mandatory="true" tabindex="15"/>
			<formElement:formInputBox idKey="address.postcode" labelKey="address.postcode" path="billingAddress.postcode" inputCSS="text" mandatory="true" tabindex="16"/>
			<formElement:formSelectBox idKey="address.country" labelKey="address.country" path="billingAddress.countryIso" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectCountry" items="${billingCountries}" itemValue="isocode" tabindex="17"/>
			<form:hidden path="billingAddress.shippingAddress"/>
			<form:hidden path="billingAddress.billingAddress"/>
		</div>
	
		
			<div>
			
						<form:checkbox id="SaveDetails" path="saveInAccount" tabindex="18"/>
						<label for="SaveDetails"><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.savePaymentDetailsInAccount"/></label>
				
			</div>
		
		
		
		
		
		
      <div class="form-actions">
            <ycommerce:testId code="checkout_useThesePaymentDetails_button">
                <button type="submit" class="positive use_these_payment_details_button" tabindex="19" id="lastInTheForm">
                    <spring:theme code="${edit ? 'checkout.summary.paymentMethod.addEditPaymentDetails.saveAndUseThesePaymentDetails' : 'checkout.summary.paymentMethod.addEditPaymentDetails.useThesePaymentDetails'}"/>
                </button>
            </ycommerce:testId>
       </div>
</form:form> 
<div style="clear:both;">
	<button type="button" class="positive clear" id="summaryOverlayViewSavedPaymentMethods" ><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.useSavedCard"/></button>
	<p><spring:theme code="checkout.summary.paymentMethod.addEditPaymentDetails.useSavedCard.description"/></p>
</div>

