<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<spring:theme text="Your Shopping Cart" var="title" code="cart.page.title"/>
<c:url value="/cart/checkout" var="checkoutUrl"/>

<template:page pageTitle="${pageTitle}" >

	<jsp:attribute name="pageScripts">

		<script type="text/javascript">
		$(function(){
			
			/* click plus button to increase number */
			$('.cartpage_order_num .plus').click(function(e){
				if($.inSubmitProgress)
					return;
				
				$.inSubmitProgress=true;
				e.preventDefault();
				
				var val = Number($(this).parents('tr').find('input.qty').val())+1;
				$(this).parents('tr').find('input.qty').val(val);
				$(this).parents('tr').find('.updateQuantityProduct').click();
			});
			
			/* click minus button to decrease number */
			$('.cartpage_order_num .minus').click(function(e){
				if($.inSubmitProgress)
					return;

				$.inSubmitProgress=true;
				e.preventDefault();

				var val = Number($(this).parents('tr').find('input.qty').val())-1;
				if(val<1){
					return;
				}
				$(this).parents('tr').find('input.qty').val(val);
				$(this).parents('tr').find('.updateQuantityProduct').click();
			});
			
			$('.cartpage_order_num input.qty').focus(function(){
				temp = Number($(this).parents('tr').find('input.qty').val());
			});
			/* input quntity directly */
			$('.cartpage_order_num input.qty').change(function(){
				var valStr = $(this).parents('tr').find('input.qty').val()
				var val = Number(valStr);
				if(! /^[0-9]*$/.test(valStr) || val<1 ){
					$(this).parents('tr').find('input.qty').val(temp);
					alert('<spring:theme code="basket.update.wrongnumber"/>');
					return;
				}
				$(this).parents('tr').find('.updateQuantityProduct').click();
			});
		});
		function calc(number,fractionDigits){  
			with(Math){  
				return round(number*pow(10,fractionDigits))/pow(10,fractionDigits);  
			}  
		}  

		</script>
	</jsp:attribute>
	<jsp:body>

<div class="lazyLoadConfig"  data-lazy-load-config='{ "failure_limit" : 0, "threshold" : 0, "skip_invisible" : "false" }' data-timeout='250'></div>


	<spring:theme code="basket.add.to.cart" var="basketAddToCart"/>
	<spring:theme code="cart.page.checkout" var="checkoutText"/>
	<common:globalMessages/>
	<cart:cartRestoration/>
	<cart:cartValidation/>
	<cart:cartPickupValidation/>
	
	<cms:pageSlot position="TopContent" var="feature" element="div" class="span-24">
		<cms:component component="${feature}"/>
	</cms:pageSlot>
	

	<div class="cartpage span-24">
		<div class="step1">shopping cart</div>
		<c:if test="${not empty cartData.entries}">
			<spring:url value="${continueUrl}" var="continueShoppingUrl" htmlEscape="true"/>
			<div class="cartpage_order_btnarea clearfix"><a href="${checkoutUrl}" class="cartpage_order_btnBuy"><spring:theme code="checkout.checkout" /></a></div>
			<cart:accCartItems cartData="${cartData}"/>
			<div class="clearfix">
				<div class="span-16">
					<cart:cartPromotions cartData="${cartData}"/>
					&nbsp;
					<cart:cartPotentialExpressCheckoutInfoBox/>
				</div>
				<div class="span-8 last">
					<cart:accCartTotals cartData="${cartData}" showTaxEstimate="false"/>
				</div>
			</div>
			<div class="cartpage_order_btnarea clearfix">
				<ycommerce:testId code="cart_checkout_button">
				<a href="${checkoutUrl}" class="cartpage_order_btnBuy"><spring:theme code="checkout.checkout" /></a>
				</ycommerce:testId>
				<ycommerce:testId code="cart_continueShopping_button">
				<a href="${continueShoppingUrl}" class="cartpage_order_btnAdd"><spring:theme text="Continue Shopping" code="cart.page.continue"/></a>
				</ycommerce:testId>
			</div>
		</c:if>
	</div>

	<c:if test="${empty cartData.entries}">
		<div class="span-24">
			<div class="span-24 wide-content-slot cms_disp-img_slot">
				<cms:pageSlot position="MiddleContent" var="feature" element="div">
					<cms:component component="${feature}"/>
				</cms:pageSlot>

				<cms:pageSlot position="BottomContent" var="feature" element="div">
					<cms:component component="${feature}"/>
				</cms:pageSlot>
			</div>
		</div>
	</c:if>

	<c:if test="${not empty cartData.entries}">
		<cart:cartPotentialPromotions cartData="${cartData}"/>
	</c:if>
	
		<%--
		<c:if test="${showCheckoutStrategies && not empty cartData.entries}" >
			<div class="span-24">
				<div class="right">
					<input type="hidden" name="flow" id="flow"/>
					<input type="hidden" name="pci" id="pci"/>
					<select id="selectAltCheckoutFlow" class="doFlowSelectedChange">
						<option value="multistep"><spring:theme code="checkout.checkout.flow.select"/></option>
						<option value="multistep"><spring:theme code="checkout.checkout.multi"/></option>
						<option value="multistep-pci"><spring:theme code="checkout.checkout.multi.pci"/></option>
					</select>
					<select id="selectPciOption" style="margin-left: 10px; display: none;">
						<option value=""><spring:theme code="checkout.checkout.multi.pci.select"/></option>
						<c:if test="${!isOmsEnabled}">
							<option value="default"><spring:theme code="checkout.checkout.multi.pci-ws"/></option>
							<option value="hop"><spring:theme code="checkout.checkout.multi.pci-hop"/></option>
						</c:if>
						<option value="sop"><spring:theme code="checkout.checkout.multi.pci-sop" text="PCI-SOP" /></option>
					</select>
				</div>
			</div>
		</c:if>
		 --%>

	<c:if test="${not empty cartData.entries}" >
		<cms:pageSlot position="Suggestions" var="feature" element="div" class="span-24">
			<cms:component component="${feature}"/>
		</cms:pageSlot>
	</c:if>

	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	<cms:pageSlot position="BottomContent" var="feature" element="div" class="span-24">
		<cms:component component="${feature}"/>
	</cms:pageSlot>
	
	</jsp:body>

</template:page>
