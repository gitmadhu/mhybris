<%-- CHINAACC_NEWFILE --%>

<%@ page contentType="text/html; charset=UTF-8" %>  <!-- missing encoding -->

<%@ taglib prefix="address" tagdir="/WEB-INF/tags/desktop/address"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>


<form:form commandName="addressForm" class="china_address_form" action="${contextPath}/checkout/multi/add-address" method="POST">
	<p><spring:theme code="text.checkout.address.newAddress" text="New Address"/></p>
    <table border="0" cellpadding="0" cellspacing="0">
    	<tr>
        	<th><span>*</span><spring:theme code="text.checkout.address.username" text="Name"/></th>
            <td>
            	<input type="hidden" id="islocalSubmit" name="islocalSubmit" value="2"/>
            	<%--<formElement:formInputBox idKey="address.firstName" labelKey="" path="firstName" inputCSS="text" mandatory="true"/>--%>
	            <form:input id="address.firstName" labelKey="" path="firstName" cssClass="text" mandatory="true"/><span><spring:theme code="cart.step2.deliveryAddress.validation.username.null" text="[ZH VALUE TO BE TRANSLATED]"/></span></td>
		</tr>
        <tr>
        	<th><span>*</span><spring:theme code="text.checkout.address.district" text="District"/></th>
            <td>
				<%--<div id="provinceSelector" >
					<formElement:formSelectBox idKey="address.region" labelKey="" path="regionIso" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectProvince" items="${regions}" itemValue="${useShortRegionIso ? 'isocodeShort' : 'isocode'}" selectedValue="${addressForm.regionIso}"/>
				</div>--%>
				<form:select id="address.region" path="regionIso" cssClass="${selectCSSClass}" tabindex="${tabindex}">
					<option value="" disabled="disabled" ${empty addressForm.regionIso ? 'selected="selected"' : ''}><spring:theme code='text.checkout.address.select' text="[Select something ZH TO BE TRANSLATED]" /></option>
					<form:options items="${regions}" itemValue="${useShortRegionIso ? 'isocodeShort' : 'isocode'}" itemLabel="${not empty itemLabel ? itemLabel :'name'}"/>
				</form:select>

                -
                <%--<div id="citySelector" >
					<formElement:formSelectBox idKey="address.city" labelKey="" path="cityCode" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectCity" items="${cities}" itemValue="${'code'}" selectedValue="${addressForm.cityCode}"/>
				</div>--%>
				<form:select id="address.city" path="cityCode" cssClass="${selectCSSClass}" tabindex="${tabindex}">
					<option value="" disabled="disabled" ${empty addressForm.cityCode ? 'selected="selected"' : ''}><spring:theme code='text.checkout.address.select' text="[Select something ZH TO BE TRANSLATED]" /></option>
					<form:options items="${cities}" itemValue="code" itemLabel="${not empty itemLabel ? itemLabel :'name'}"/>
				</form:select>
				-
                <%--<formElement:formSelectBox idKey="address.citydistrict" labelKey="" path="cityDistrictCode" mandatory="true" skipBlank="false" skipBlankMessageKey="address.selectCityDistrict" items="${cityDistricts}" itemValue="${'code'}" selectedValue="${addressForm.cityDistrictCode}"/> --%>
				<form:select id="address.citydistrict" path="cityDistrictCode" cssClass="${selectCSSClass}" tabindex="${tabindex}">
					<option value="" disabled="disabled" ${empty addressForm.cityDistrictCode ? 'selected="selected"' : ''}><spring:theme code='text.checkout.address.select' text="[Select something ZH TO BE TRANSLATED]" /></option>
					<form:options items="${cityDistricts}" itemValue="code" itemLabel="${not empty itemLabel ? itemLabel :'name'}"/>
				</form:select>
                <strong><spring:theme code="text.checkout.address.district.notice" text="[District Notice ZH TO BE TRANSLATED]"/></strong><span><spring:theme code="cart.step2.deliveryAddress.validation.district.null" text="[ZH VALUE TO BE TRANSLATED]"/></span>
			</td>
		</tr>
        <tr>
        	<th><span>*</span><spring:theme code="text.checkout.address.line" text="Address Line"/></th>
			<td>
				<%--<formElement:formInputBox idKey="address.line1" labelKey="" path="line1" inputCSS="text" mandatory="true"/>--%>
				<form:input id="address.line1" labelKey="" path="line1" cssClass="inputStyle1" mandatory="true"/><span><spring:theme code="cart.step2.deliveryAddress.validation.address.null" text="[ZH VALUE TO BE TRANSLATED]"/></span></td>
		</tr>
        <tr>
        	<th><span>&nbsp;&nbsp;</span><spring:theme code="text.checkout.address.postCode" text="Postal Code"/></th>
            <td>
            	<%--<formElement:formInputBox idKey="address.postcode" labelKey="" path="postcode" inputCSS="text" mandatory="true"/>--%>
            	<form:input id="address.postcode" labelKey="" path="postcode" cssClass="text" mandatory="true"/><span><spring:theme code="cart.step2.deliveryAddress.validation.postcode.invalid" text="[ZH VALUE TO BE TRANSLATED]"/></span>
            </td>
		</tr>
        <tr>
        	<th><span>&nbsp;&nbsp;</span><spring:theme code="text.checkout.address.lineNo" text="Phone"/></th>
			<td>
                <%--<formElement:formInputBox idKey="address.landlinePhonePart1" labelKey="" path="landlinePhonePart1" inputCSS="text" mandatory="true"/>--%>
				<form:input id="address.landlinePhonePart1" labelKey="" path="landlinePhonePart1" cssClass="inputStyle2" mandatory="true"/>
                -
                <%--<formElement:formInputBox idKey="address.landlinePhonePart2" labelKey="" path="landlinePhonePart2" inputCSS="text" mandatory="true"/> --%>
				<form:input id="address.landlinePhonePart2" labelKey="" path="landlinePhonePart2" cssClass="phone_num" mandatory="true"/>
                -
                <%--<formElement:formInputBox idKey="address.landlinePhonePart3" labelKey="" path="landlinePhonePart3" inputCSS="text" mandatory="true"/>--%>
                <form:input id="address.landlinePhonePart3" labelKey="" path="landlinePhonePart3" cssClass="inputStyle2" mandatory="true"/>
				<span><spring:theme code="cart.step2.deliveryAddress.validation.phone.invalid" text="[ZH VALUE TO BE TRANSLATED]"/></span>
			</td>
		</tr>
        <tr>
        	<th><span>*</span><spring:theme code="text.checkout.address.mobileNo" text="Mobile Phone"/></th>
            <td>
            	<%--<formElement:formInputBox idKey="address.cellPhone" labelKey="" path="cellPhone" inputCSS="text" mandatory="true"/>  --%>
            	<form:input id="address.cellPhone" labelKey="" path="cellPhone" cssClass="text" mandatory="true"/>
            	<span><spring:theme code="cart.step2.deliveryAddress.validation.cellphone.invalid" text="[ZH VALUE TO BE TRANSLATED]"/></span>
			</td>
			</tr>
		</table>
		
		<div class="step2address_btnArea clearfix">
        <a class="orderConfirm_addAddress_saveBtn" href="javascript:void(0);"><spring:theme code="text.checkout.address.save" text="Save Address"/></a>
	    <ycommerce:testId code="multicheckout_newaddress_cancel_button">
			<a class="orderConfirm_addAddress_cancelBtn" href="javascript:void(0);"><spring:theme code="cnacc.txt.account.address.form.button.cancel" text="Cancel"/></a>
		</ycommerce:testId>
		</div>
	

<script type="text/javascript">
	$('.orderConfirm_addAddress_saveBtn').click(function(e){
		if($.inAddressSubmitProgress){
			return;
		}	
		e.preventDefault();
		$.inAddressSubmitProgress = true;
		var flag = addAddress_save();
		if(!flag){
			$.inAddressSubmitProgress = false;
		}
	} );
	
	
	function addAddress_save (){

		
		var $name = $('.china_address_form input[id="address\\.firstName"]');
		var $province = $('.china_address_form select[id="address\\.region"]');
		var $city = $('.china_address_form select[id="address\\.city"]');
		var $region = $('.china_address_form select[id="address\\.citydistrict"]');
		var $add = $('.china_address_form input[id="address\\.line1"]');
		var $zip = $('.china_address_form input[id="address\\.postcode"]');
		var $phone_region = $('.china_address_form input[id="address\\.landlinePhonePart1"]');
		var $phone_num = $('.china_address_form input[id="address\\.landlinePhonePart2"]');
		var $phone_other = $('.china_address_form input[id="address\\.landlinePhonePart3"]');
		var $mobile = $('.china_address_form input[id="address\\.cellPhone"]');

		
		var zip,phone_region,phone_num,phone_other,phone;
		if($name.val()==''){
			$name.next().show();
			return false;	
		}else{
			$name.next().hide();	
		}
		if($province.val()=='' || $city.val()=='' || $region.val()==''){
			$province.parents('td').find('span').show();
			return false;
		}else{
			$province.parents('td').find('span').hide();
		}
		if($add.val()==''||$add.val()==''){
			$add.next().show();	
			return false;	
		}else{
			$add.next().hide();	
		}
		if($zip.val()!=''){
			if(!/^[1-9]\d{5}$/.test($zip.val())){
				$zip.next().show();
				return false;
			}else{
				$zip.next().hide();
				zip = $zip.val();
			}
		}else{
			zip = '';
		}
		
		
		if($phone_region.val()!='' || $phone_num.val()!='' || $phone_other.val()!=''){
			if(!/^\d{3,4}$/.test($phone_region.val())){
				$phone_num.parents('td').find('span').show();
				return false;
			}else{
				phone_region = $phone_region.val();
			}
			if(!/^\d{7,8}$/.test($phone_num.val())){
				$phone_num.parents('td').find('span').show();
				return false;
			}else{
				phone_num = $phone_num.val();
			}
			if($phone_other.val()!='' && !/^\d{1,4}$/.test($phone_other.val())){
				$phone_other.parents('td').find('span').show();
				return false;
			}else{
				if($phone_other.val()==''){
					phone = phone_region + '-' + phone_num;
					$phone_other.parents('td').find('span').hide();
				}else{
					phone_other = $phone_other.val();
					phone = phone_region + '-' + phone_num + '-' + phone_other;
					$phone_other.parents('td').find('span').hide();
				}
			}
		}else{
			phone = '';
			$phone_other.parents('td').find('span').hide();
		}
		if(/^[0-9]*$/.test($mobile.val()) && $mobile.val().length==11){
			$mobile.next().hide();	
		}else{
			$mobile.next().show();
			return false;		
		}
		
		$('.china_address_form').submit();
		return true;
	}
	
	$('.orderConfirm_addAddress_cancelBtn').click(function(){
			$('.orderConfirm_addAddress').hide().empty().prev().show();
	});

</script>
</form:form>