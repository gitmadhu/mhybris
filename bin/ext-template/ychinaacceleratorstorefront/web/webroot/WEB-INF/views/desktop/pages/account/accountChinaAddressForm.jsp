<%--CHINAACC_NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/desktop/address"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>


<c:url value="/my-account/${formActionURL}" var="encodedUrl" />

<div class="myAddEdit2">
<form:form commandName="addressForm" class="china_address_form" action="${encodedUrl}" method="POST">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
    	<tr>
        	<th><span class="account_address_span">*</span><spring:theme code="cnacc.txt.account.address.form.name" text="Name"/></th>
            <td>
            	<form:input id="address.firstName" labelKey="" path="firstName" mandatory="true"/><span><spring:theme code="cnacc.txt.account.address.form.name.validation.message" text="ZH VALUE TO BE TRANSLATED"/></span>
                <form:hidden path="addressId" id="addressIdentifier"/>
			</td>
		</tr>
		<tr>
        	<th><span class="account_address_span">*</span><spring:theme code="cnacc.txt.account.address.form.location" text="ZH VALUE TO BE TRANSLATED"/></th>
            <td>
				<form:select id="address.region" labelKey="" path="regionIso" mandatory="true" >
				<option value="" disabled="disabled" ${empty addressForm.regionIso ? 'selected="selected"' : ''}><spring:theme code='text.checkout.address.select' text="[Select something ZH TO BE TRANSLATED]" /></option>
					<form:options items="${regions}" itemValue="${useShortRegionIso ? 'isocodeShort' : 'isocode'}" itemLabel="${not empty itemLabel ? itemLabel :'name'}"/>
				</form:select>
				<form:select id="address.city" path="cityCode">
					<option value="" disabled="disabled" ${empty addressForm.cityCode ? 'selected="selected"' : ''}><spring:theme code='text.checkout.address.select' text="[Select something ZH TO BE TRANSLATED]" /></option>
					<form:options items="${cities}" itemValue="code" itemLabel="${not empty itemLabel ? itemLabel :'name'}"/>
				</form:select>
                <form:select id="address.citydistrict" path="cityDistrictCode">
					<option value="" disabled="disabled" ${empty addressForm.cityDistrictCode ? 'selected="selected"' : ''}><spring:theme code='text.checkout.address.select' text="[Select something ZH TO BE TRANSLATED]" /></option>
					<form:options items="${cityDistricts}" itemValue="code" itemLabel="${not empty itemLabel ? itemLabel :'name'}"/>
				</form:select> 
                <span><spring:theme code="cnacc.txt.account.address.form.location.validation.message" text="ZH VALUE TO BE TRANSLATED"/></span>
			</td>
		</tr>
        <tr>
        	<th><span class="account_address_span">*</span><spring:theme code="cnacc.txt.account.address.form.street" text="Street"/></th>
            	<td>
                	<form:input id="address.line1" labelKey="" path="line1" mandatory="true" />
					<span><spring:theme code="cnacc.txt.account.address.form.street.validation.message" text="ZH VALUE TO BE TRANSLATED"/></span>
				</td>
		</tr>
		<tr>
        	<th><span class="account_address_span">&nbsp;&nbsp;</span><spring:theme code="cnacc.txt.account.address.form.postalcode" text="Postal Code"/></th>
            	<td>
                <form:input id="address.postcode" labelKey="" path="postcode" mandatory="true"/>
                <span><spring:theme code="cnacc.txt.account.address.form.postalcode.validation.message" text="ZH VALUE TO BE TRANSLATED"/></span>
                </td>
		</tr>
        <tr>
        	<th><span class="account_address_span">&nbsp;&nbsp;</span><spring:theme code="cnacc.txt.account.address.form.landlinephone" text="Phone"/></th>
            <td>
               	<form:input id="address.landlinePhonePart1" labelKey="" path="landlinePhonePart1" mandatory="true" cssStyle="width:70px" />
               	-
               	<form:input id="address.landlinePhonePart2" labelKey="" path="landlinePhonePart2"  mandatory="true" cssStyle="width:100px" />
                -
                <form:input id="address.landlinePhonePart3" labelKey="" path="landlinePhonePart3"  mandatory="true" cssStyle="width:70px" />
                <span><spring:theme code="cnacc.txt.account.address.form.landlinephone.validation.message" text="ZH VALUE TO BE TRANSLATED"/></span>
			</td>
		</tr>
		<tr>
        	<th><span class="account_address_span">*</span><spring:theme code="cnacc.txt.account.address.form.mobilephone" text="Mobile Phone"/></th>
            <td>
            	<form:input id="address.cellPhone" labelKey="" path="cellPhone" mandatory="true" />
            	<span><spring:theme code="cnacc.txt.account.address.form.mobilephone.validation.message" text="ZH VALUE TO BE TRANSLATED"/></span>
			</td>
		</tr>
	</table>
    <a class="myAddEdit_sumbit" href="javascript:void(0);"><spring:theme code="cnacc.txt.account.address.form.button.saveaddress" text="Save Address"/></a>
    <ycommerce:testId code="multicheckout_cancel_button">
		<c:url value="/my-account/address-book" var="encodedCancelUrl"/>
		<a href="${encodedCancelUrl}" class="add_cancelBtn"><spring:theme code="cnacc.txt.account.address.form.button.cancel" text="Cancel"/></a>
	</ycommerce:testId>
</form:form>
</div>


<script type="text/javascript">



</script>

