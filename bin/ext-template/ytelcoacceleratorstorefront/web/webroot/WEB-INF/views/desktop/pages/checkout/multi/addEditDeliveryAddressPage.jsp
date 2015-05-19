<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/desktop/checkout/multi" %>

<c:url value="/checkout/multi/choose-delivery-address" var="chooseDeliveryAddressUrl"/>
<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>

<div class="telco-checkout checkout-delivery-address"> <!-- telco change -->
	
	<multi-checkout:checkoutProgressBar steps="${checkoutSteps}" currentStep="1" stepName="deliveryAddress"/>
	<div class="span-24 multicheckout">
		<div class="item_container_holder">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="checkout.multi.addressDetails" text="Address Details"/></h2>
			</div>
			<div class="item_container">
				<p><spring:theme code="checkout.multi.addEditform" text="Please use this form to add/edit an address."/></p>
				<p class="required"><spring:theme code="form.required" text="Fields marked * are required"/></p>
				<form:form method="post" commandName="addressForm">
					<dl>
						<form:hidden path="addressId"/>
						<formElement:formSelectBox idKey="address.title" labelKey="address.title" path="titleCode" mandatory="true" skipBlank="false" skipBlankMessageKey="address.title.pleaseSelect" items="${titles}" selectedValue="${addressForm.titleCode}"/>
						<formElement:formInputBox idKey="address.firstName" labelKey="address.firstName" path="firstName" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.surname" labelKey="address.surname" path="lastName" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.line1" labelKey="address.line1" path="line1" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.line2" labelKey="address.line2" path="line2" inputCSS="text" mandatory="false"/>
						<formElement:formInputBox idKey="address.townCity" labelKey="address.townCity" path="townCity" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.postcode" labelKey="address.postcode" path="postcode" inputCSS="text" mandatory="true"/>
						<formElement:formSelectBox idKey="address.country" labelKey="address.country" path="countryIso" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectCountry" items="${countries}" itemValue="isocode" selectedValue="${addressForm.countryIso}"/>
						<c:if test="${not addressForm.defaultAddress and not firstAddress}">
							<formElement:formCheckbox idKey="address.default" labelKey="address.default" path="defaultAddress" inputCSS="add-address-left-input" labelCSS="add-address-left-label" mandatory="false"/>
						</c:if>
					</dl>
					<span class="form_btns" style="display: block; clear: both;">
						<c:if test="${not noAddress}">
							<ycommerce:testId code="multicheckout_cancel_button">
								<a href="${chooseDeliveryAddressUrl}">
									<button class="r_action_btn" type="button"><spring:theme code="checkout.multi.cancel" text="Cancel"/></button>
								</a>
							</ycommerce:testId>
						</c:if>
						<ycommerce:testId code="multicheckout_saveAddress_button">
							<button class="positive"><spring:theme code="checkout.multi.saveAddress" text="Save address"/></button>
						</ycommerce:testId>
					</span>
				</form:form>
			</div>
		</div>
	</div>
	
	<!-- telco changes -->
	<!-- <cms:slot var="feature" contentSlot="${slots.SideContent}"><cms:component component="${feature}"/></cms:slot> -->
	
</div>
</template:page>
