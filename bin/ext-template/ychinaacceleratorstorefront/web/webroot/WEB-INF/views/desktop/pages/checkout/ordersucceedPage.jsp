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

<template:page pageTitle="${pageTitle}">
	<jsp:attribute name="pageScripts">
		<script type="text/javascript">
		$(function(){
			/*å®ä¹é®ç½©çé«åº¦*/
			if($('#wrapper').height()<=$(document).height()){
				$('.mask').css('height',$(document).height());
				var top = ($(document).height() - $('.payPop').height())/2;
				$('.payPop').css('top',top);
			}else{
				$('.mask').css('height',$('#wrapper').height());
				var top = ($('#wrapper').height() - $('.payPop').height())/2;
				$('.payPop').css('top',top);
			}
			/*ç¹å»ç«å³æ¯ä»æé®ï¼æ¾ç¤ºpop*/
			$('.submitOrder5_right a').click(function(){
				$('.mask,.payPop').fadeIn(300);
			});

		});
		</script>
	</jsp:attribute>
	<jsp:body>


	<spring:theme code="basket.add.to.cart" var="basketAddToCart"/>
	<spring:theme code="cart.page.checkout" var="checkoutText"/>
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<common:globalMessages/>

	
	<cms:pageSlot position="TopContent" var="feature" element="div" class="span-24">
		<cms:component component="${feature}"/>
	</cms:pageSlot>
	

	<div class="cartpage span-24">
		<div class="orderSuccess">
					<div class="step4"><spring:theme code="order.payment.succeed.txt" /></div>
                    <div class="orderSuccess2">
                    	<p class="orderSuccessTxt"><spring:theme code="order.payment.succeed.congratulation" /></p>
                        <div class="orderSuccess3">
                        	<p><spring:theme code="order.payment.succeed.delivraision.1" /><strong>1-3</strong>
                        	<spring:theme code="order.payment.succeed.delivraision.2" /></p>
                            <div class="orderSuccess3_inner clearfix">
                            	<div class="orderSuccess3_order"><spring:theme code="order.payment.succeed.nextstep" />
                            		<a href="${request.contextPath}/my-account/order/${orderCode}"><spring:theme code="order.payment.succeed.nextstep.checkorder" /></a>
                            	</div>
                                <a href="${request.contextPath}" class="orderSuccess3_buy"><spring:theme code="order.payment.succeed.nextstep.shop" /></a>
                            </div>
                            <p><spring:theme code="order.submit.receptioniste" /></p>
                        </div>
                    </div>
          </div>
	</div>

	<cms:pageSlot position="BottomContent" var="feature" element="div" class="span-24">
		<cms:component component="${feature}"/>
	</cms:pageSlot>
	
	</jsp:body>

</template:page>
