<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<%@ attribute name="containerCSS" required="false" type="java.lang.String" %>

<c:if test="${ycommerce:doesAppliedPromotionExistForOrder(order)}">
	<div class="item_container_holder promo">
		<div class="title_holder">
			<div class="title">
				<div class="title-top">
					<span></span>
				</div>
			</div>
			<h2><spring:theme code="text.account.order.receivedPromotions" text="Received Promotions"/></h2>
		</div>
		<div class="item_container">
			<ul>
					<c:forEach items="${order.orderPrices}" var="orderPriceData">
						<c:forEach items="${orderPriceData.appliedOrderPromotions}" var="promotion">
							<li class="cart-promotions-applied">${orderPriceData.billingTime.name}: ${promotion.description}</li>
						</c:forEach>
					</c:forEach>
			</ul>
		</div>
	</div>
</c:if>
