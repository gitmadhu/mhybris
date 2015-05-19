<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:theme text="Your Shopping Cart" var="title" code="cart.page.title"/>
<c:url value="/cart/checkout" var="checkoutUrl"/>

<template:page pageTitle="${pageTitle}">

	<script type="text/javascript">
	/*<![CDATA[*/
		<%-- Handler method for the checkout buttons on the cart page --%>
		function doCheckout()
		{
			window.location = '${checkoutUrl}';
			return false;
		}
	/*]]>*/
	</script>


	<c:if test="${showCheckoutStrategies && not empty cartData.entries}" >

	<script type="text/javascript">
	/*<![CDATA[*/
		<%-- Alternative checkout flows options --%>
		function doFlowSelected()
		{
			if('multistep-pci' == $('#selectAltCheckoutFlow').attr('value'))
			{
				$('#selectPciOption').css('display', '');
			}
			else
			{
				$('#selectPciOption').css('display', 'none');
			}
		}

		<%-- Alternative checkout flows version of the doCheckout method to handle the checkout buttons on the cart page. --%>
		function doCheckout()
		{
			var flow = $('#selectAltCheckoutFlow').attr('value');
			if ('' == flow)
			{
				// No alternate flow specified, fallback to default behaviour
				window.location = '${checkoutUrl}';
			}
			else
			{
				// Fix multistep-pci flow
				if ('multistep-pci' == flow)
				{
					flow = 'multistep';
				}
				var pci = $('#selectPciOption').attr('value');

				// Build up the redirect URL
				var redirectUrl = '${checkoutUrl}' + '/select-flow?flow=' + flow + '&amp;pci=' + pci;
				window.location = redirectUrl;
			}
			return false;
		}
	/*]]>*/
	</script>

	</c:if>
	
	<spring:message code="basket.add.to.cart" var="basketAddToCart"/>
	<spring:theme code="cart.page.checkout" var="checkoutText"/>
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<div class="span-24 cart-page"> <!-- telco changes -->

			<div class="span-24 disp-img">
				<cms:slot var="feature" contentSlot="${slots['TopContent']}">
					<cms:component component="${feature}"/>
				</cms:slot>
			</div>
			
			<c:if test="${not empty cartData.entries}">
				<c:url value="${continueUrl}" var="continueShoppingUrl"/>

					
					<div class="span-24 cart-entries-container">
						<c:if test="${not empty message}">
							<span class="errors">
								<spring:theme code="${message}"/>
							</span>
						</c:if>
						<div class="cart-entries-data">
							<cart:cartItems cartData="${cartData}"/>
						</div>
						<div class="cart-entries-totals">
							<cart:cartTotals cartData="${cartData}"/>
						</div>
						<div class="cart-entries-promo">
							<cart:cartPromotions cartData="${cartData}"/>
						</div>
						<div class="cart-entries-promo">
							<cart:cartPotentialPromotions cartData="${cartData}"/>
						</div>

					</div>
					
					<div class="span-24 cart-actions last">
						<form action="#" method="get">
							<button type="submit" class="form left" onclick="window.location = '${continueShoppingUrl}'; return false">
								<spring:theme text="Continue Shopping" code="cart.page.continue"/>
							</button>
						</form>
						<button id="checkoutButtonBottom" class="positive right <c:if test="${cartData.cartInvalidMessage != null}">cart-invalid-button</c:if>" <c:if test="${cartData.cartInvalidMessage == null}">onclick="doCheckout()"</c:if>>
							<spring:theme code="checkout.checkout" />
						</button>
						
					</div>
			</c:if>

					
			<c:if test="${empty cartData.entries}">
				<div class="span-24 disp-img">
					<cms:slot var="feature" contentSlot="${slots['MiddleContent']}">
						<cms:component component="${feature}"/>
					</cms:slot>
					<cms:slot var="feature" contentSlot="${slots['BottomContent']}">
						<cms:component component="${feature}"/>
					</cms:slot>
				</div>
			</c:if>
		
		<!-- telco changes -->
		<!-- <c:if test="${not empty cartData.entries}"><cart:cartPotentialPromotions cartData="${cartData}"/></c:if>
				<cms:slot var="feature" contentSlot="${slots['SideContent']}"><cms:component component="${feature}"/></cms:slot> -->
				
		<c:if test="${showCheckoutStrategies && not empty cartData.entries}" >
			<div class="span-24">
				<div class="right">
					<input type="hidden" name="flow" id="flow"/>
					<input type="hidden" name="pci" id="pci"/>
					<select id="selectAltCheckoutFlow" onchange="doFlowSelected()" >
						<option value=""><spring:message code="checkout.checkout.flow.select"/></option>
						<option value="single"><spring:message code="checkout.checkout.single"/></option>
						<option value="multistep"><spring:message code="checkout.checkout.multi"/></option>
						<option value="multistep-pci"><spring:message code="checkout.checkout.multi.pci"/></option>
					</select>
					<select id="selectPciOption" style="margin-left: 10px; display: none;">
						<option value=""><spring:message code="checkout.checkout.multi.pci.select"/></option>
						<option value="default"><spring:message code="checkout.checkout.multi.pci-ws"/></option>
						<option value="hop"><spring:message code="checkout.checkout.multi.pci-hop"/></option>
					</select>
				</div>
			</div>
		</c:if>
		
	</div>
		<script type="text/javascript">
		/*<![CDATA[*/
			$('.cart-invalid-button').colorbox({
				inline: true,
				href:"#cart_error_pop",
				width:"500px",
				height:"400px"
			});
		/*]]>*/
		</script>
	
		<!-- This contains the hidden content for inline calls -->
		<div style="display:none">
			<div id="cart_error_pop">
				<div class="small_popup_container" style="border-top: 0; margin-top: 0; border-bottom: 0;">
					<div class="small_popup_headline">
						<div class="small_popup_emark">

						</div>
						<div class="small_popup_headline_text">
							Notification
						</div>
						<div class="clear"></div>
					</div>
					<div class="small_popup_content">
						<div class="clear"></div>	
						<p>
							<c:if test="${cartData.cartInvalidMessage != null}">
							  ${cartData.cartInvalidMessage}
							</c:if>
						</p>
						<h3><spring:theme code="basket.page.message.howProceed"/></h3>
						<div class="invalid-bundle-wizard">
							<c:forEach var="invalidMap" items="${cartData.firstIncompleteBundleComponentsMap}"> 
	 							<a href="<c:url value="/bundle/edit-component/${invalidMap.key}/component/${invalidMap.value.id}"/>" class="invalid-bundle-wizard-editable">
									<spring:theme code="basket.page.message.return" arguments="${invalidMap.value.name}"/>
								</a>
							</c:forEach>
						</div>
						<div class="invalid-bundle-returntocart" onclick="jQuery.colorbox.close();">
							<spring:theme code="basket.page.message.returnCheckout"/>
						</div>		
						<div class="clear"></div>				
					</div>
				</div>
			</div>
		</div>
		
</template:page>