<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>

<c:url value="/cart/miniCart/${totalDisplay}" var="refreshMiniCartUrl"/>
<c:url value="/cart/rollover/${component.uid}" var="rolloverPopupUrl"/>

<script id="miniCartTemplate" type="text/x-jquery-tmpl">
/*<![CDATA[*/

	<dt>
		<ycommerce:testId code="miniCart_items_label">
			<spring:theme text="items" code="cart.items" arguments="{{= totalItems}}"/>
		</ycommerce:testId>
		 -
	</dt>
	<dd>
		<ycommerce:testId code="miniCart_total_label">
			<c:if test="${totalDisplay == 'TOTAL'}">
				{{= totalPrice.formattedValue}}
			</c:if>
			<c:if test="${totalDisplay == 'SUBTOTAL'}">
				{{= subTotal.formattedValue}}
			</c:if>
			<c:if test="${totalDisplay == 'TOTAL_WITHOUT_DELIVERY'}">
				{{= totalNoDelivery.formattedValue}}
			</c:if>
		</ycommerce:testId>
	</dd>

/*]]>*/
</script>

<script type="text/javascript">
/*<![CDATA[*/
           

$(document).on('click','#addToCartForm button.positive',function(){
	setTimeout(function(){
		$.get('${refreshMiniCartUrl}', function(result) {
			$('#minicart_data').html(result)
		});
	}, 600);
})
      
$(document).ready(function() {
	
	$('#rollover_cart_popup').hide();
	
	$('.cart-quickview').hover(
		    function() { $.data(this, 'hover', true); },
		    function() { $.data(this, 'hover', false); }
	).data('hover', false);
	
	$('#rollover_cart_popup').hover(
		    function() { $.data(this, 'hover', true); },
		    function() { $.data(this, 'hover', false); }
	).data('hover', false);
	
	$('.cart-quickview').mouseenter(function() {
		$('#cart_popup').hide();
		$.get('${rolloverPopupUrl}', function(result){
			$('#rollover_cart_popup').html(result);
			$('#ajax_cart_close').click(function(e) {
				e.preventDefault();
				$('#rollover_cart_popup').hide();
			});
			$('#rollover_cart_popup').fadeIn();
		});
	});
	$('.cart-quickview').mouseleave(function() {
		setTimeout(function() {
			if (!$('.cart-quickview').data('hover') && !$('#rollover_cart_popup').data('hover')) {
				$('#rollover_cart_popup').fadeOut();
			}
		}, 100);
	});
	
	$('#rollover_cart_popup').mouseenter(function() {
		$('#rollover_cart_popup').show();
	});
	$('#rollover_cart_popup').mouseleave(function() {
		setTimeout(function() {
			if(!$('.cart-quickview').data('hover') && !$('#rollover_cart_popup').data('hover')) {
				$('#rollover_cart_popup').fadeOut();
			}
		}, 100);
	});
});
/*]]>*/
</script>


<div id="cart_header">
	<div class="cart-quickview" id="minicart_data">
		<ycommerce:testId code="miniCart_viewCart_link">
			<c:url value="/cart" var="cartUrl"/>
			<a href="${cartUrl}" title="Cart">
				<ycommerce:testId code="miniCart_items_label">
					<spring:theme text="items" code="cart.count" arguments="${totalItems}"/>
				</ycommerce:testId>
			</a>
		</ycommerce:testId>
		<span class="hidden"> products in your cart</span>
	</div>
	<div class="go-to-checkout">
		<ycommerce:testId code="miniCart_checkout_link">
			<c:url value="/cart/checkout" var="checkoutUrl"/>
			<a href="${checkoutUrl}" title="Checkout"><spring:theme text="CHECKOUT" code="cart.checkout"/></a>
		</ycommerce:testId>
	</div>
</div>
<cart:rolloverCartPopup/>