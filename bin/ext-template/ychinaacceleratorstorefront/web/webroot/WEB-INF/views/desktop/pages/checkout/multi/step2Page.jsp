<%-- CHINAACC_NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/desktop/checkout/multi" %>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/desktop/address" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %> 

<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">
<jsp:attribute name="pageScripts">
<script type="text/javascript">
$(function(){
	var data = ${invoiceInfo};
	if("1"==data.requireInvoice){
		showInvoiceInfo(data);
	}else{
		showInvoiceNUll();
	}
});

function getInvoiceNullForm(){
	$('.invoiceBlock1').show();
	$('.invoiceBlock1 li').eq(1).find('input').val("");
	$('.invoiceBlock1 li').eq(1).find('#invoiceTitle').find("option[id='CORPS']").attr("selected",true);
	$('.invoiceBlock1 #invoiceInfo').find("option").eq(0).attr("selected",true);
	$('.btnSaveInvoice,.btnNoInvoice').show();
	$('.btnModifyInvoice').hide();
	$('.invoiceBlock2').hide().prev().show();
	$('.invoiceBlock3').hide();
}

function getInvoiceForm(data){
	$('.invoiceBlock1').show();
	$('.invoiceBlock1 li').eq(1).find('input').val(data.invoiceName);
	$('.invoiceBlock1 #invoiceTitle').find("option[id='"+data.invoicedTitle+"']").attr("selected",true);
	$('#'+data.invoicedCategory).attr("selected","true");
	$('.btnSaveInvoice,.btnNoInvoice').show();
	$('.btnModifyInvoice').hide();
	$('.invoiceBlock2').hide().prev().show();
	$('.invoiceBlock3').hide();
}

function showInvoiceInfo(data){
	var val = data.invoiceName;
	if(val!=''){
		var invoiceName =  $('.invoiceBlock1 #invoiceTitle').find("option[id='"+data.invoicedTitle+"']").val()+','+val;
	}else{
		var invoiceName =  $('.invoiceBlock1 #invoiceTitle').find("option[id='"+data.invoicedTitle+"']").val();
	}
	var invoiceType = $('.invoiceBlock1 li').eq(0).find('input:radio[name="invoiceType"]:checked').val();
	var invoiceInfo =$('.invoiceBlock1 #invoiceInfo').find("option[id='"+data.invoicedCategory+"']").val();
	$('.invoiceBlock2 li').eq(0).find('span').html(invoiceType);
	$('.invoiceBlock2 li').eq(1).find('span').html(invoiceName);
	$('.invoiceBlock2 li').eq(2).find('span').html(invoiceInfo);
	$('.invoiceBlock1').hide();
	$('.btnSaveInvoice').hide();
	$('.btnModifyInvoice').show();
	$('.invoiceBlock2').show();
}

function showInvoiceNUll(){
	$('.invoiceBlock3').show().prev().hide().prev().hide();	
	$('.btnSaveInvoice,.btnNoInvoice').hide();
	$('.btnModifyInvoice').show();
	$('#requireInvoice').val("0");
}

$('.btnSaveInvoice').on('click',saveInvoice);
function saveInvoice(){
	$('.invoiceBlock1 li').eq(1).find('.invoicMsg_span').hide();
	var title = $('.invoiceBlock1 li').eq(1).find('select option:selected').attr("id");
	var category = $('.invoiceBlock1 li').eq(2).find('select option:selected').attr("id");
	 $('.invoiceBlock1 #_invoiceTitle').val(title);
	 $('.invoiceBlock1 #_invoiceCategory').val(category);
	 
	 var invoicMsg = $('.invoiceBlock1 li').eq(1).find('#invoicMsg').val();
	 if(  "CORPS"==title && (invoicMsg==null || $.trim(invoicMsg)=="") ){
		$('.invoiceBlock1 li').eq(1).find('.invoicMsg_span').show();
		return;
	 }
	$.ajax({
        type: "GET",
        url: '${contextPath}/checkout/multi/saveInvoice',
        data:$('#invoceForm').serialize(),
        async:false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	showInvoiceInfo(data);
        }
    });
}

$('.btnModifyInvoice').on('click',modifyInvoice);
function modifyInvoice(){
	$.ajax({
        type: "GET",
        url: '${contextPath}/checkout/multi/getCurrentInvoice',
        data:"",
        async:false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	if("1"==data.requireInvoice){
        		getInvoiceForm(data);
        	}else{
        		getInvoiceNullForm();
        	}
        }
    });
}

/* Fapiao function */
$('.btnNoInvoice').on('click',noInvoice);
function noInvoice(){
	$.ajax({
        type: "GET",
        url: '${contextPath}/checkout/multi/cancelInvoice',
        data:"",
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	showInvoiceNUll();
        }
    });
}

$(function(){
		var temp;	
		var check;	
		
		/* input */
		$('input').focus(function(){
			temp = $(this).val();
			if($(this).val()==''||$(this).val()==''||$(this).val()==''||$(this).val()==''|| $(this).val()==''){
				$(this).val('');
			}
			$(this).addClass('highLight');
		});
		$('input').blur(function(e){
			$(this).removeClass('highLight');
			var name = $(e.target).attr('name');
			var val= $(e.target).val();
			if(val==''){
				switch(name){
					case 'address':
						$(e.target).val('');
						break;
					case 'phone_region':
						$(e.target).val('');
						break;
					case 'phone_num':
						$(e.target).val('');
						break;
					case 'phone_other':
						$(e.target).val('');
						break;
					case 'mobile':
						$(e.target).val('');
						break;
				}
			}
		});
		
		/* */
		$('.btnDefault').on('click',setDefalut);
		function setDefalut(e){
			$(e.currentTarget).parents('.orderConfirm_userMsg').find('input[type="radio"]').attr("checked",true);
		}
		
		/*  */
		$('.btnAddNewAd').on('click',addNewAd);
		function addNewAd(){
			$(this).hide().next().show();
			$('.orderConfirm_modifyAddress').hide();
		
			var options = {
				url: '${contextPath}/checkout/multi/editAddress',
				data: {addressId: ACC.address.addressID, 
					createUpdateStatus: '',
					cmd: 'initialaddressform'},
				type: 'GET',
				success: function (data)
				{
					$('.orderConfirm_addAddress').html(data);
					attachOnChangeFunctionOntoProvinceSelector();
					ACC.address.bindChinaUpdateAddressForm(); 
				}
			};
			$.ajax(options);
		}
		
		$('#deliveryAddress input[name=cartAddress]').change(function(){
			//ajax set delivery address for cart
			var options = {
				url: '${contextPath}/checkout/multi/select-delivery-address-ajax',
				data: {
					addressCode: $(this).val() ,
				},
				type: 'GET',
				success: function (data)
				{
					if(data != 'OK')
						window.location.reload();
				}
			};
			$.ajax(options);
		});

		function attachOnChangeFunctionOntoProvinceSelector ()
		{
			$('#address\\.region').on("change", function ()
			{
				var options = {
						url: '${contextPath}/checkout/multi/editAddress',
						data: {provinceIsoCode: $(this).val() ,
							addressPersonName: $("#address\\.firstName").val(),
							//addressPersonName: $("#addressForm.china_address_form #address\\.firstName").val(), // reference via form commandname + class
							//addressCityCode: $("#address\\.city").val(),
							//addressCityDistrictCode: $("#address\\.citydistrict").val(),
							addressLine1: $("#address\\.line1").val(),
							addressPostalCode: $("#address\\.postcode").val(),
							addressLandlinePhonePart1: $("#address\\.landlinePhonePart1").val(),
							addressLandlinePhonePart2: $("#address\\.landlinePhonePart2").val(),
							addressLandlinePhonePart3: $("#address\\.landlinePhonePart3").val(),
							addressCellPhone: $("#address\\.cellPhone").val()
							},
						type: 'GET',
						success: function (data)
						{
							//$('.orderConfirm_addAddress').hide(); // only for test
							$('.orderConfirm_addAddress').html(data);
							attachOnChangeFunctionOntoCitySelector();
							attachOnChangeFunctionOntoProvinceSelector();
							ACC.address.bindChinaUpdateAddressForm();
						}
					};
					$.ajax(options);
			})
		}

		function attachOnChangeFunctionOntoCitySelector ()
		{
			$('#address\\.city').on("change", function ()
			{
				var options = {
						url: '${contextPath}/checkout/multi/editAddress',
						data: {
							   provinceIsoCode: $('#address\\.region').val(),
							   cityCode: $(this).val(),
							addressPersonName: $("#address\\.firstName").val(),
							addressLine1: $("#address\\.line1").val(),
							addressPostalCode: $("#address\\.postcode").val(),
							addressLandlinePhonePart1: $("#address\\.landlinePhonePart1").val(),
							addressLandlinePhonePart2: $("#address\\.landlinePhonePart2").val(),
							addressLandlinePhonePart3: $("#address\\.landlinePhonePart3").val(),
							addressCellPhone: $("#address\\.cellPhone").val()
						},
						type: 'GET',
						success: function (data)
						{
							//$('.orderConfirm_addAddress').hide(); // only for test
							$('.orderConfirm_addAddress').html(data);
							attachOnChangeFunctionOntoProvinceSelector();
							attachOnChangeFunctionOntoCitySelector();
							ACC.address.bindChinaUpdateAddressForm();
						}
					};
					$.ajax(options);
			})
		}

		function attachOnChangeFunctionOntoModifyProvinceSelector ()
		{
			$('#address\\.region').on("change", function ()
			{
				var options = {
						url: '${contextPath}/checkout/multi/editAddress',
						data: {provinceIsoCode: $(this).val() ,
							addressPersonName: $("#address\\.firstName").val(),
							//addressPersonName: $("#addressForm.china_address_form #address\\.firstName").val(), // reference via form commandname + class
							//addressCityCode: $("#address\\.city").val(),
							//addressCityDistrictCode: $("#address\\.citydistrict").val(),
							addressLine1: $("#address\\.line1").val(),
							addressPostalCode: $("#address\\.postcode").val(),
							addressLandlinePhonePart1: $("#address\\.landlinePhonePart1").val(),
							addressLandlinePhonePart2: $("#address\\.landlinePhonePart2").val(),
							addressLandlinePhonePart3: $("#address\\.landlinePhonePart3").val(),
							addressCellPhone: $("#address\\.cellPhone").val(),
							addressId: $("#address\\.addressId").val(),
							cmd: 'MODIFYADDRESS'
							},
						type: 'GET',
						success: function (data)
						{
							//$('.orderConfirm_addAddress').hide(); // only for test
							$('.orderConfirm_modifyAddress').html(data);
							attachOnChangeFunctionOntoModifyCitySelector();
							attachOnChangeFunctionOntoModifyProvinceSelector();
							ACC.address.bindChinaUpdateAddressForm();
						}
					};
					$.ajax(options);
			})
		}

		function attachOnChangeFunctionOntoModifyCitySelector ()
		{
			$('#address\\.city').on("change", function ()
			{
				var options = {
						url: '${contextPath}/checkout/multi/editAddress',
						data: {
							   provinceIsoCode: $('#address\\.region').val(),
							   cityCode: $(this).val(),
							addressPersonName: $("#address\\.firstName").val(),
							addressLine1: $("#address\\.line1").val(),
							addressPostalCode: $("#address\\.postcode").val(),
							addressLandlinePhonePart1: $("#address\\.landlinePhonePart1").val(),
							addressLandlinePhonePart2: $("#address\\.landlinePhonePart2").val(),
							addressLandlinePhonePart3: $("#address\\.landlinePhonePart3").val(),
							addressCellPhone: $("#address\\.cellPhone").val(),
							addressId: $("#address\\.addressId").val(),
							cmd: 'MODIFYADDRESS'
						},
						type: 'GET',
						success: function (data)
						{
							//$('.orderConfirm_addAddress').hide(); // only for test
							$('.orderConfirm_modifyAddress').html(data);
							attachOnChangeFunctionOntoModifyProvinceSelector();
							attachOnChangeFunctionOntoModifyCitySelector();
							ACC.address.bindChinaUpdateAddressForm();
						}
					};
					$.ajax(options);
			})
		}
		
		/*  */
		$('.btnModify').on('click',modifyAd);
		function modifyAd(){
			var addressid = $(this).attr('data-address-id');
			
			var phone_region,phone_num,phone_other;
			check = $(this).parents('.orderConfirm_userMsg').index();
			$('.orderConfirm_modifyAddress').show();
			$('.orderConfirm_addAddress').hide().prev().show();
			
			var options = {
				url: '${contextPath}/checkout/multi/edit-address',
				data: {addressCode: addressid, 
					cmd: ''},
				type: 'GET',
				success: function (data)
				{
					$('.orderConfirm_modifyAddress').html(data);
					attachOnChangeFunctionOntoModifyProvinceSelector();
					ACC.address.bindChinaUpdateAddressForm(); // to 
				}
			};
			$.ajax(options);
			
			
			var name = $(this).parents('.orderConfirm_userMsg').find('.nameMsg').html();
			var province = $(this).parents('.orderConfirm_userMsg').find('.provinceMsg').html();
			var city = $(this).parents('.orderConfirm_userMsg').find('.cityMsg').html();
			var region = $(this).parents('.orderConfirm_userMsg').find('.regionMsg').html();
			var address = $(this).parents('.orderConfirm_userMsg').find('.addressMsg').html();
			var zip = $(this).parents('.orderConfirm_userMsg').find('.zipMsg').html();
			if(zip==''){
				zip='';
			}
			var mobile = $(this).parents('.orderConfirm_userMsg').find('.mobileMsg').html();
			$('.orderConfirm_modifyAddress input[name="userName"]').val(name);
			$('.orderConfirm_modifyAddress input[name="address"]').val(address);
			$('.orderConfirm_modifyAddress input[name="zipCode"]').val(zip);
			$('.orderConfirm_modifyAddress input[name="mobile"]').val(mobile);
			/* */
			$('.orderConfirm_modifyAddress select[name="province"] option').filter(function() {
				return $(this).text() == province; 
			}).prop('selected', true);
			$('.orderConfirm_modifyAddress select[name="city"] option').filter(function() {
				return $(this).text() == city; 
			}).prop('selected', true);
			$('.orderConfirm_modifyAddress select[name="region"] option').filter(function() {
				return $(this).text() == region; 
			}).prop('selected', true);
			var phone = $(this).parents('.orderConfirm_userMsg').find('.phoneMsg').html();
			phone = phone.split('-');
			if(phone.length==3){
				phone_region = phone[0];
				phone_num = phone[1];
				phone_other = phone[2];
			}else if(phone.length==2){
				phone_region = phone[0];
				phone_num = phone[1];
				phone_other = ''	;
			}else{
				phone_region = '';
				phone_num = '';
				phone_other = '';
			}
			
			
			/*  */
			$('.orderConfirm_modifyAddress input[name="phone_region"]').val(phone_region);	
			$('.orderConfirm_modifyAddress input[name="phone_num"]').val(phone_num);
			$('.orderConfirm_modifyAddress input[name="phone_other"]').val(phone_other);	
		}
		
		/* Payment Mode */
		$('.orderConfirm_sendPay input[name="paymentModeDto\\.name"]').change(function(){
			//ajax set payment mode for cart
			var options = {
					url: '${contextPath}/checkout/multi/select-payment-mode-ajax',
					data: {
						paymentMode: $(this).val() ,
					},
					type: 'GET',
					success: function (data)
					{
						if(data != 'OK')
							window.location.reload();
					}
				};
				$.ajax(options);
		});
		
		/* Delivery Time */
		$('.orderConfirm_sendPay input[name="time"]').change(function(){
			//ajax set delivery time slot for cart
			//alert($(this).val());
			var options = {
					url: '${contextPath}/checkout/multi/select-delivery-timeslot-ajax',
					data: {
						timeslot: $(this).val() ,
					},
					type: 'GET',
					success: function (data)
					{
						if(data != 'OK')
							window.location.reload();
					}
				};
				$.ajax(options);
		});
		
		/*  */
		$('.useBtn').on('click',useBtn);
		function useBtn(){
			var coupon = $('.couponBlock1').find('input[name="coupon"]').val();
			if(coupon != ''){
				$('.couponBlock2').find('input[name="coupon"]').val(coupon);
				$('.couponBlock1').hide().next().show();
				$('.couponBlock1 span').hide();
			}else{
				$('.couponBlock1 span').show();
			}
		}
		
		/*  */
		$('.cancelBtn').on('click',cancelBtn);
		function cancelBtn(){
			$('.couponBlock1').show().next().hide();
		}
		
		$('.goBuyBtn').on('click', function(e){
			if($.inPlaceOrderSubmitProgress)
				return;
			
			$.inPlaceOrderSubmitProgress=true;
			e.preventDefault();
		});
}); 
</script>
</jsp:attribute>

<jsp:body>
<!-- 
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
 -->
	<div id="globalMessages">
		<common:globalMessages/>
	</div>

<!-- 	<div class="orderConfirm span-24">
		<div class="step2">shopping cart</div>
	</div> -->

	<!--  multi-checkout:checkoutProgressBar steps="${checkoutSteps}" currentStep="1" stepName="deliveryAddress"/> --> <!-- stepname step2? -->
	
	<!-- CHINAACC_START -->
	<div id="wrapper">
		<div id="page">
			<div id="content">
				<div class="orderConfirm">
					<div class="step2"><spring:theme code="text.checkout.orderConfirmation" text="[ZH VALUE TO BE TRANSLATED]"/></div>
					<div class="orderConfirm_area">
						<div class="orderConfirm_area_section clearfix">
							<div class="orderConfirm_sectionL"><spring:theme code="text.account.order.recieverInfo" text="Delivery Address"/></div>
							<div class="orderConfirm_sectionR">
<%-- ************************************************************************************************************************************************** --%>
<%-- (DELIVERY) ADDRESS SECTION --%> 
<%-- ************************************************************************************************************************************************** --%>
								<div id="deliveryAddress" class="orderConfirm_userMsg_Area">
								<c:choose>
									<c:when test="${not empty addressDataFromAddressBook}">
										<c:forEach items="${addressDataFromAddressBook}" var="addressDto">
									   		<div class="orderConfirm_userMsg clearfix">
												<div class="orderConfirm_userMsg_check">
													<c:set var="isDefaultAddress" value="${not addressDto.defaultAddress  ? '' : 'checked=\"checked\"'}"/>
													<input type="radio" name="cartAddress" value="${addressDto.id}" ${isDefaultAddress} />
												</div>
												<p class="clearfix">
													<span class="nameMsg">${fn:escapeXml(addressDto.firstName)}</span>
													<span class="provinceMsg">${fn:escapeXml(addressDto.region.name)}</span>
													<span class="cityMsg">${fn:escapeXml(addressDto.city)}</span> 
													<span class="regionMsg">${fn:escapeXml(addressDto.cityDistrict)}</span>
													<span class="addressMsg">${fn:escapeXml(addressDto.line1)}</span>
													<span class="zipMsg">${fn:escapeXml(addressDto.postalCode)}</span>
													<span class="phoneMsg">${fn:escapeXml(addressDto.phone)}</span>
													<span class="mobileMsg">${fn:escapeXml(addressDto.cellphone)}</span>
												</p>
												<ycommerce:testId code="addressBook_editAddress_button">
													<a class="btnModify" href="javascript:void(0);" data-address-id="${addressDto.id}"><spring:theme code="text.checkout.address.edit" text="Edit"/></a>
													<!-- edit-address/${addressDto.id} -->
												</ycommerce:testId>
												<!-- if default only show txt, else link to change it -->
												<c:choose>
													<c:when test="${addressDto.defaultAddress}"><spring:theme code="text.checkout.address.isDefault" text="default"/></c:when>
													<c:otherwise>
														<a class="btnDefault" href="set-default-address/${addressDto.id}"><spring:theme code="text.checkout.address.setDefault" text="Set as default"/></a>
													</c:otherwise>
												</c:choose>
											</div>
										</c:forEach>
									</c:when>
								</c:choose>
								<a href="javascript:void(0);" class="btnAddNewAd"><spring:theme code="text.checkout.address.newAddress" text="New Address"/></a>
								
								<!-- ADD NEW ADDRESS -->
								<div class="orderConfirm_addAddress clearfix">
								</div>


								<!-- EDIT EXISTING ADDRESS -->
								<div class="orderConfirm_modifyAddress clearfix">
								</div>
						  </div>
						</div>
					</div>
<%-- ************************************************************************************************************************************************** --%>
<%-- PAYMENT MODE ALIPAY START --%> 
<%-- ************************************************************************************************************************************************** --%>
						<div class="orderConfirm_area_section clearfix">
						   	<div class="orderConfirm_sectionL"><spring:theme code="cart.step2.address.mathod" text=""/></div>
							<div class="orderConfirm_sectionR">
								<div class="orderConfirm_sendPay">
									<dl>
										<dt><spring:theme code="cart.step2.payment.mathod" text=""/></dt>
										<dd>
											<p><spring:theme code="cart.step2.payemnt.aimable.tip" text=""/> </p>
										   <%-- <p><input type="radio" checked="checked" value="" name="pay">支付宝</p>  --%>
											<%-- check if it should be selected automatically if only one exits. <c:set var="hasOnlyOnePaymentMode" value="${fn:length(paymentModes) == 1 ? 'checked=\"checked\"' : '' }"/>  --%>
											 <c:choose>
												<c:when test="${not empty paymentModes}">
													<c:forEach items="${paymentModes}" var="paymentModeDto" >
														<p><input type="radio" ${hasOnlyOnePaymentMode} value="${paymentModeDto.code}" name="paymentModeDto.name" <c:if test="${cartData.paymentMode.code == paymentModeDto.code}">checked</c:if> >
														<spring:theme code="text.alipay" text=""/> (${paymentModeDto.name})</p>
													</c:forEach>
												</c:when>
											</c:choose>
											 
										</dd>
									</dl>
									<dl>
										<dt><spring:theme code="cnacc.txt.checkout.orderconfirmation.deliverymethod.title" text="Delivery Method"/></dt>
										<dd>
											<p><spring:theme code="cnacc.txt.checkout.orderconfirmation.deliverymethod.hint" text="The delivery method is chosen for you."/></p>
										</dd>
									</dl>
									<dl>
										<dt><spring:theme code="cart.step2.delivery.time" text=""/></dt>
										<dd>
											<c:forEach var="deliveryTimeSlot" items="${deliveryTimeSlots}">
											<p><input type="radio" value="${deliveryTimeSlot}" name="time" <c:if test="${cartData.deliveryTimeslot == deliveryTimeSlot}">checked</c:if>><spring:theme code="text.checkout.deliveryTimeSlot.${deliveryTimeSlot}" text=""/></p>
											</c:forEach>
										</dd>
									</dl>
								</div>
						   	</div>
						</div>

<%-- ************************************************************************************************************************************************** --%>
<%-- ORDER DETAILS --%> 
<%-- ************************************************************************************************************************************************** --%>
						<div class="orderConfirm_area_section clearfix">
							<div class="orderConfirm_sectionL"><spring:theme code="cart.step2.shopping.list" text=""/></div>
							<div class="orderConfirm_sectionR">
								<div class="orderConfirm_table_area">
									<multi-checkout:accCheckoutOrderDetails cartData="${cartData}" />
								</div>
							</div>
						</div>

<%-- ************************************************************************************************************************************************** --%>
<%-- ORDER FAPIAO AND SUMMARY --%> 
<%-- ************************************************************************************************************************************************** --%>
						<div class="orderConfirm_area_section clearfix">
							<div class="orderConfirm_sectionL"><spring:theme code="cart.step2.order.calculation" text=""/></div>
							<div class="orderConfirm_sectionR">
                            	<div class="orderSettlement clearfix">
                            	<form id="invoceForm" >
                                	<div class="orderSettlement_L">
                                		<%-- TODO USE Coupon --%>
                                        <div class="invoice">
                                        	<p class="invoiceTitle"><spring:theme code="checkout.order.settle.requireFacture" text=""/></p>
                                            <ul class="invoiceBlock1">
                                            	<li><label><spring:theme code="checkout.order.settle.factureCategory" text=""/></label>
                                            	<input type="radio" id="invoiceType" name="invoiceType" checked="checked" value="normal" /><spring:theme code="checkout.order.settle.commonFacture" text=""/></li>
                                                <li><label><spring:theme code="checkout.order.settle.factureTitle" text=""/></label>
                                                <input type="hidden" name="_invoiceTitle" id="_invoiceTitle" value="" />
                                                <select name="invoiceTitle" id="invoiceTitle">
                                                <option id="CORPS"><spring:theme code="checkout.order.settle.facture.corps" text=""/></option>
                                                <option id="INDIVIDUAL"><spring:theme code="checkout.order.settle.facture.individual" text=""/></option>
                                                </select>
                                                <input type="text" name="invoicMsg" id="invoicMsg" value="" /><span class="invoicMsg_span"><spring:theme code="checkout.order.settle.facture.msg.null" text=""/></span></li>
                                                <li><label><spring:theme code="checkout.order.settle.factureContent" text=""/></label>
                                                 <input type="hidden" name="_invoiceCategory" id="_invoiceCategory" value="" />
                                                <select name="invoiceInfo" id="invoiceInfo">
	                                                <option id="FASHION"><spring:theme code="checkout.order.settle.costume" text=""/></option>
	                                                <option id="ELECTRONICS"><spring:theme code="checkout.order.settle.electromenage" text=""/></option>
	                                                <option id="FOOD"><spring:theme code="checkout.order.settle.alimentaire" text=""/></option>
                                                </select>
                                                </li>
                                            </ul>
                                            <ul class="invoiceBlock2">
                                            	<li><label><spring:theme code="checkout.order.settle.factureCategory" text=""/></label><span></span></li>
                                                <li><label><spring:theme code="checkout.order.settle.factureTitle" text=""/></label><span></span></li>
                                                <li><label><spring:theme code="checkout.order.settle.factureContent" text=""/></label><span></span></li>
                                            </ul>
                                            <p class="invoiceBlock3"><spring:theme code="checkout.order.settle.not.require.facture" text=""/></p>
                                            <div class="invoiceBtn">
                                            	<a href="javascript:void(0);" class="btnSaveInvoice"><spring:theme code="checkout.order.settle.conserve.facture.info" text=""/></a>
                                            	<a href="javascript:void(0);" class="btnModifyInvoice"><spring:theme code="checkout.order.settle.not.need.facture.modify" text=""/></a>
                                                <a href="javascript:void(0);" class="btnNoInvoice"><spring:theme code="checkout.order.settle.not.need.facture.temp" text=""/></a>
                                            </div>
                                        </div>
                                    </div>
                                    </form>
                                    <div class="orderSettlement_R">
                                    	<p class="orderSettlement_R_title"><spring:theme code="checkout.order.settle.ultimate.money" text=""/></p>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                        	<tr>
                                            	<th><spring:theme code="checkout.order.settle.products.money" text=""/></th>
                                                <td>
                                                	<ycommerce:testId code="Order_Totals_Subtotal">
														<format:price priceData="${cartData.subTotal}"/>
													</ycommerce:testId>
												</td>
                                            </tr>
                                            <tr>
                                            	<th><spring:theme code="checkout.order.settle.freight" text=""/></th>
                                                <td><format:price priceData="${cartData.deliveryCost}" displayFreeForZero="TRUE"/></td>
                                            </tr>
                                            <tr>
                                            	<th><spring:theme code="checkout.order.settle.vouche" text=""/></th>
                                                <td><format:price priceData="${cartData.totalDiscounts}"/></td>
                                            </tr>
                                        </table>
                                        <p class="orderTotal clearfix"><spring:theme code="checkout.order.settle.should.pay.amount" text=""/>
	                                        <span>
													<format:price priceData="${cartData.totalPrice}"/>
											</span>
										</p>
										<spring:url value="/checkout/multi/placeOrderOneStep" var="placeOrderUrl" />
										<form:form action="${placeOrderUrl}" id="placeOrderForm1" commandName="placeOrderForm">
											<c:if test="${requestSecurityCode}">
												<form:input type="hidden" class="securityCodeClass" path="securityCode"/>
												<button type="submit" class="placeOrderWithSecurityCode goBuyBtn">
													<spring:theme code="checkout.summary.placeOrder"/>
												</button>
											</c:if>
											
											<c:if test="${not requestSecurityCode}">
												<button type="submit" class="goBuyBtn">
													<spring:theme code="checkout.summary.placeOrder"/>
												</button>
											</c:if>
										</form:form>
                                    </div>
                                </div>
							</div>
						</div>
						<!-- ORDER FAPIAO and SUMMARY END -->

					
					</div>
				</div>
			</div>	
		</div>
	</div>
	<!-- CHINAACC_END -->
	
	<cms:pageSlot position="SideContent" var="feature" element="div" class="span-24 side-content-slot cms_disp-img_slot">
		<cms:component component="${feature}"/>
	</cms:pageSlot>

</jsp:body>
</template:page>
