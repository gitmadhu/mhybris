<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<c:if test="${ycommerce:doesPotentialPromotionExistForOrder(cartData)}">
	<div class="item_container_holder promo">
		<div class="title_holder">
			<div class="title">
				<div class="title-top">
					<span></span>
				</div>
			</div>
			<h2><spring:theme code="basket.potential.promotions" /></h2>
		</div>
		<div class="item_container">
			<ycommerce:testId code="potentialPromotions_promotions_labels">
				<ul>
					<c:forEach items="${cartData.orderPrices}" var="orderPriceData">
						<c:forEach items="${orderPriceData.potentialOrderPromotions}" var="promotion">
							<li class="cart-promotions-potential">${orderPriceData.billingTime.name}: ${promotion.description}</li>
						</c:forEach>
					</c:forEach>
				</ul>
			</ycommerce:testId>
		</div>
	</div>
</c:if>
