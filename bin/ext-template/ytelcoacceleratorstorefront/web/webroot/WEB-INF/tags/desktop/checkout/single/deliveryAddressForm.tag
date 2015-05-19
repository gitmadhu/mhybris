<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:url value="/checkout/single/summary/createUpdateDeliveryAddress.json" var="createUpdateDeliveryAddressUrl" />

<div class="title_holder">
	<div class="title">
		<div class="title-top">
			<span></span>
		</div>
	</div>

	<h2><spring:theme code="checkout.summary.deliveryAddress"/></h2>
</div>

<div class="item_container">
	<p><spring:theme code="checkout.summary.deliveryAddress.useForNewAddress"/></p>

	<p><spring:theme code="address.required"/></p>

	<form:form method="post" commandName="addressForm" action="${createUpdateDeliveryAddressUrl}" class="create_update_address_form" >
		<dl>
			<form:hidden path="addressId" class="create_update_address_id" status="${not empty createUpdateStatus ? createUpdateStatus : ''}"/>
			<formElement:formSelectBox idKey="address.title" labelKey="address.title" path="titleCode" mandatory="true" skipBlank="false" skipBlankMessageKey="address.title.pleaseSelect" items="${titles}"/>
			<formElement:formInputBox idKey="address.firstName" labelKey="address.firstName" path="firstName" inputCSS="text" mandatory="true"/>
			<formElement:formInputBox idKey="address.surname" labelKey="address.surname" path="lastName" inputCSS="text" mandatory="true"/>
			<formElement:formInputBox idKey="address.line1" labelKey="address.line1" path="line1" inputCSS="text" mandatory="true"/>
			<formElement:formInputBox idKey="address.line2" labelKey="address.line2" path="line2" inputCSS="text" mandatory="false"/>
			<formElement:formInputBox idKey="address.townCity" labelKey="address.townCity" path="townCity" inputCSS="text" mandatory="true"/>
			<formElement:formInputBox idKey="address.postcode" labelKey="address.postcode" path="postcode" inputCSS="text" mandatory="true"/>
			<formElement:formSelectBox idKey="address.country" labelKey="address.country" path="countryIso" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectCountry" items="${countries}" itemValue="isocode"/>

			<form:hidden path="shippingAddress"/>
			<form:hidden path="billingAddress"/>
			<c:if test="${!edit}">
				<dt class="left">
					<form:checkbox id="SaveAddress" path="saveInAddressBook"/>
					<label for="SaveAddress"><spring:theme code="checkout.summary.deliveryAddress.saveAddressInMyAddressBook"/></label>
				</dt>
				<dd></dd>
			</c:if>
		</dl>

		<span style="display: block; clear: both;">
			<button class="form"><spring:theme code="${edit ? 'checkout.summary.deliveryAddress.saveAndUseThisAddress' : 'checkout.summary.deliveryAddress.useThisAddress'}"/></button>
		</span>
	</form:form>
</div>
