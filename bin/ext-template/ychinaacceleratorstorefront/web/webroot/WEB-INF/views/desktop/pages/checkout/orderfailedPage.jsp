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
			$('.orderFail5_right a').click(function(){
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
		<div class="orderFail">
					<div class="step4"><spring:theme code="order.submit.successfully" /></div>
                    <div class="orderFail2">
                    	<p class="orderFailTxt"><spring:theme code="order.payment.notsucceed.remark" /></p>
                        <div class="orderFail3">
                        	<div class="orderFail4 clearfix">
                            	<div class="orderFail4_left"><spring:theme code="order.submit.order.code" /><strong><spring:theme code="text.account.order.orderNumber" text="Order number is {0}" arguments="${orderData.code}"/></strong></div>
                                <div class="orderFail4_right"><spring:theme code="order.submit.due.payment" /><strong><format:price priceData="${orderData.totalPrice}"/></strong></div>
                            </div>
                            <div class="orderFail5 clearfix">
                            	<div class="orderFail5_left"><spring:theme code="order.submit.selected.payment.method" /></div>
                                <div class="orderFail5_mid"><img src="${contextPath}/_ui/desktop/common/images/submit/pay1.jpg" alt="" /></div>
                                <div class="orderFail5_right">
									<a href="${contextPath}/alipay/requestController/${orderData.code}" target="_blank"><spring:theme code="order.submit.payment.immediately" /></a>
								</div>
                            </div>
                            <p><spring:theme code="order.submit.receptioniste" /></p>
                        </div>
                    </div>
          </div>
	</div>

	<div class="mask"></div>
    <div class="payPop">
    	<p><spring:theme code="order.payment.remark" /></p>
        <div class="payPopBtn clearfix">
        	<a href="${contextPath}/checkout/finalpaymentcheck/${orderData.code}"  class="payPopBtn_left"><spring:theme code="order.payment.successfully" /></a>
            <a href="${contextPath}/checkout/finalpaymentcheck/${orderData.code}" class="payPopBtn_right"><spring:theme code="order.payment.rencontre.problem" /></a>
        </div>	
    </div>


	<cms:pageSlot position="BottomContent" var="feature" element="div" class="span-24">
		<cms:component component="${feature}"/>
	</cms:pageSlot>
	
	</jsp:body>

</template:page>
