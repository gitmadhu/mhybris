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

<c:url value="/my-account/address-book" var="addressBookUrl"/>
<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="address-book" />
	<div class="span-20 last">
		<div class="item_container_holder addressDetails">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.addressBook.addressDetails" text="Address Details"/></h2>
			</div>
			<div class="item_container">
				<p><spring:theme code="text.account.addressBook.addEditform" text="Please use this form to add/edit a delivery address"/></p>
				<p class=""><spring:theme code="form.required" text="Fields marked * are required"/></p>
				<form:form action="add-address" method="post" commandName="addressForm">
					<dl>
						<form:hidden path="addressId"/>
						<formElement:formSelectBox idKey="address.title" labelKey="address.title" path="titleCode" mandatory="true" skipBlank="false" skipBlankMessageKey="address.title.pleaseSelect" items="${titleData}" selectedValue="${addressForm.titleCode}" />
						<formElement:formInputBox idKey="address.firstName" labelKey="address.firstName" path="firstName" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.surname" labelKey="address.surname" path="lastName" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.line1" labelKey="address.line1" path="line1" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.line2" labelKey="address.line2" path="line2" inputCSS="text" mandatory="false"/>
						<formElement:formInputBox idKey="address.townCity" labelKey="address.townCity" path="townCity" inputCSS="text" mandatory="true"/>
						<formElement:formInputBox idKey="address.postcode" labelKey="address.postcode" path="postcode" inputCSS="text" mandatory="true"/>
						<formElement:formSelectBox idKey="address.country" labelKey="address.country" path="countryIso" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectCountry" items="${countryData}" itemValue="isocode" selectedValue="${addressForm.countryIso}"/>
						<c:if test="${not addressForm.defaultAddress and not firstAddress}">
							<formElement:formCheckbox idKey="address.default" labelKey="address.default" path="defaultAddress" inputCSS="add-address-left-input" labelCSS="add-address-left-label" mandatory="false"/>
						</c:if>
					</dl>
					<span class="form_btns" style="display: block; clear: both;">
	
						<a class="r_action_btn action_btn_add" onclick="window.location='${addressBookUrl}'">
							<spring:theme code="text.account.addressBook.cancel" text="Cancel"/>
						</a>
						
						<ycommerce:testId code="accountEditAddress_SaveAddress_button">
							<button class="positive"><spring:theme code="text.account.addressBook.saveAddress" text="Save New Address"/></button>
						</ycommerce:testId>
					</span>
				</form:form>
			</div>
		</div>
	</div>
</template:page>
