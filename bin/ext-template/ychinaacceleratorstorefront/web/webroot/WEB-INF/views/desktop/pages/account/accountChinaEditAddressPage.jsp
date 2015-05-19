<%--CHINAACC_NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/desktop/address"%>

<template:page pageTitle="${pageTitle}">
	<jsp:attribute name="pageScripts">

		<c:url value="/my-account/select-address-location?cmd=provinceselected&url=${formActionURL}" var="encodedUrlProvinceSelector" />
		<c:url value="/my-account/select-address-location?cmd=cityselected&url=${formActionURL}" var="encodedUrlCitySelector" />

		<script type="text/javascript">
		$(function(){	
		$(function(){
			var temp;	
			$('.myAddEdit2 input').focus(function(){
				temp = $(this).val();
				if($(this).val()=='请直接填写街道等详细地址,省/市/区不用填写'||$(this).val()=='区号'||$(this).val()=='电话号码'||$(this).val()=='分机'|| $(this).val()=='11位手机号码'){
					$(this).val('');
				}
			});
			$('.myAddEdit2 input').blur(function(e){
				var name = $(e.target).attr('name');
				var val= $(e.target).val();
				if(val==''){
					switch(name){
						case 'address':
							$(e.target).val('请直接填写街道等详细地址,省/市/区不用填写');
							break;
						case 'phone1':
							$(e.target).val('区号');
							break;
						case 'phone2':
							$(e.target).val('电话号码');
							break;
						case 'phone3':
							$(e.target).val('分机');
							break;
						case 'mobile':
							$(e.target).val('11位手机号码');
							break;
					}
				}
			});
			
			});
		});
			$(function(){
				function attachOnChangeFunctionOntoProvinceSelector () {
					$('.myAddEdit2 select[id="address\\.region"]').on("change", function () {
						$('.china_address_form').attr("action","${encodedUrlProvinceSelector}");
						$('.china_address_form').attr("method","POST");
						$('.china_address_form').submit();
					})
				}
				attachOnChangeFunctionOntoProvinceSelector();

				function attachOnChangeFunctionOntoCitySelector () {
					$('.myAddEdit2 select[id="address\\.city"]').on("change", function () {
						$('.china_address_form').attr("action","${encodedUrlCitySelector}");
						$('.china_address_form').attr("method","POST");
						$('.china_address_form').submit();
					})
				}
				attachOnChangeFunctionOntoCitySelector();
	
				function attachOnSubmitHandlerToAddressForm() {
					$('.myAddEdit_sumbit').on("click", function(){
						var $name = $('.myAddEdit2 input[id="address\\.firstName"]');
						var $add = $('.myAddEdit2 input[id="address\\.line1"]');
						var $mobile = $('.myAddEdit2 input[id="address\\.cellPhone"]');
						var $province = $('.myAddEdit2 select[id="address\\.region"]');
						var $city = $('.myAddEdit2 select[id="address\\.city"]');
						var $region = $('.myAddEdit2 select[id="address\\.citydistrict"]');
						var $zip = $('.myAddEdit2 input[id="address\\.postcode"]');
						var $phone_region = $('.myAddEdit2 input[id="address\\.landlinePhonePart1"]');
						var $phone_num = $('.myAddEdit2 input[id="address\\.landlinePhonePart2"]');
						var $phone_other = $('.myAddEdit2 input[id="address\\.landlinePhonePart3"]');
						if($name.val()==''){
							$name.parents('tr').addClass('errorMsg');
							return;	
						}else{
							$name.parents('tr').removeClass('errorMsg');
						}
						if($province.val()=='' || $city.val()=='' || $region.val()==''){
							$province.parents('tr').addClass('errorMsg');
							return;
						}else{
							$province.parents('tr').removeClass('errorMsg');
						}
						if($add.val()==''||$add.val()=='请直接填写街道等详细地址,省/市/区不用填写'){
							$add.parents('tr').addClass('errorMsg');
							return;	
						}else{
							$add.parents('tr').removeClass('errorMsg');
						}
						if($zip.val()!=''){
							if(!/^[1-9]\d{5}$/.test($zip.val())){
								$zip.parents('tr').addClass('errorMsg');
								return;
							}else{
								$zip.parents('tr').removeClass('errorMsg');
								zip = $zip.val();
							}
						}
						if($phone_region.val()!='区号' || $phone_num.val()!='电话号码' || $phone_other.val()!='分机'){
							if($.trim($phone_region.val())!="" && !/^\d{3,4}$/.test($phone_region.val())){
								$phone_num.parents('tr').addClass('errorMsg');
								return;
							}
							if($.trim($phone_num.val())!="" && !/^\d{7,8}$/.test($phone_num.val())){
								$phone_num.parents('tr').addClass('errorMsg');
								return;
							}
							if($.trim($phone_other.val())!="" && !/^\d{1,4}$/.test($phone_other.val())){
								$phone_num.parents('tr').addClass('errorMsg');
								return;
							}else{
								$phone_num.parents('tr').removeClass('errorMsg');
							}
						}else{
							$phone_other.parents('tr').removeClass('errorMsg');
						}
						if(/^[0-9]*$/.test($mobile.val()) && $mobile.val().length==11){
							$mobile.parents('tr').removeClass('errorMsg');
						}else{
							$mobile.parents('tr').addClass('errorMsg');
							return;		
						}
						$('.china_address_form').submit();
					})
				}
				attachOnSubmitHandlerToAddressForm();
			});
		</script>

		
	</jsp:attribute>
	
	<jsp:body>
		<div id="breadcrumb" class="breadcrumb">
			<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
		</div>

		<div id="globalMessages">
			<common:globalMessages/>
		</div>
	
		<nav:accountNav selected="address-book" />
	
		<div class="myAddEdit">
        	<h3><spring:theme code="cnacc.txt.account.address.form.title" text="ZH VALUE TO BE TRANSLATED"/></h3>
            <h4><spring:theme code="cnacc.txt.account.address.form.subtitle" text="ZH VALUE TO BE TRANSLATED"/></h4>  

			<jsp:include page="accountChinaAddressForm.jsp" />  
		</div>
		
	</jsp:body>
</template:page>
