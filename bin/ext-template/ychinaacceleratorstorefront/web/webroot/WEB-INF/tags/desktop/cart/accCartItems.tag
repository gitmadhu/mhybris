<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/desktop/storepickup" %>


<div id="cartItems" class="cartpage_order clear">
	<div class="headline">
		<spring:theme code="basket.page.title.yourItems"/>
		<span class="cartId">
			<spring:theme code="basket.page.cartId"/>&nbsp;<span class="cartIdNr">${cartData.code}</span>
		</span>
	</div>
	
	
	
	
	<table border="0" cellpadding="0" cellspacing="0" class="cart">
		<thead>
			<tr>
				<th id="header2" width="40%" colspan="2"><spring:theme code="basket.page.title"/></th>
				<th id="header3" width="15%"><spring:theme code="basket.page.itemPrice"/></th>
				<th id="header4" width="15%"><spring:theme code="basket.page.quantity"/></th>
				<th id="header5" width="15%"><spring:theme code="basket.page.total"/></th>
				<th id="header6"><spring:theme code="text.actions"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${cartData.entries}" var="entry">
				<c:url value="${entry.product.url}" var="productUrl"/>
				<tr class="cartItem">
					
					<td headers="header2" class="thumb">
						<div class="cartpage_order_product clearfix"><a href="${productUrl}"><product:productPrimaryImage product="${entry.product}" format="thumbnail"/></a></div>
					</td>
					
					<td headers="header2" class="details">
						<ycommerce:testId code="cart_product_name">
							<div class="itemName"><a href="${productUrl}">${entry.product.name}</a></div>
						</ycommerce:testId>
						
						<c:set var="entryStock" value="${entry.product.stock.stockLevelStatus.code}"/>
						
						<c:forEach items="${entry.product.baseOptions}" var="option">
							<c:if test="${not empty option.selected and option.selected.url eq entry.product.url}">
								<c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
									<div>
										<strong>${selectedOption.name}:</strong>
										<span>${selectedOption.value}</span>
									</div>
									<c:set var="entryStock" value="${option.selected.stock.stockLevelStatus.code}"/>
									<div class="clear"></div>
								</c:forEach>
							</c:if>
						</c:forEach>
						
						<c:if test="${ycommerce:doesPotentialPromotionExistForOrderEntry(cartData, entry.entryNumber)}">
							<ul class="potentialPromotions">
								<c:forEach items="${cartData.potentialProductPromotions}" var="promotion">
									<c:set var="displayed" value="false"/>
									<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
										<c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber && not empty promotion.description}">
											<c:set var="displayed" value="true"/>
											<li>
												<ycommerce:testId code="cart_potentialPromotion_label">
													${promotion.description}
												</ycommerce:testId>
											</li>
										</c:if>
									</c:forEach>
								</c:forEach>
							</ul>
						</c:if>
								
						<c:if test="${ycommerce:doesAppliedPromotionExistForOrderEntry(cartData, entry.entryNumber)}">
							<ul class="appliedPromotions">
								<c:forEach items="${cartData.appliedProductPromotions}" var="promotion">
									<c:set var="displayed" value="false"/>
									<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
										<c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber}">
											<c:set var="displayed" value="true"/>
											<li>
												<ycommerce:testId code="cart_appliedPromotion_label">
													${promotion.description}
												</ycommerce:testId>
											</li>
										</c:if>
									</c:forEach>
								</c:forEach>
							</ul>
						</c:if>
					</td>
					
					<td headers="header3" class="itemPrice">
						<strong class="unit"><format:price priceData="${entry.basePrice}" displayFreeForZero="true"/></strong>
					</td>
					
					<td headers="header4" class="quantity">
						<c:url value="/cart/update" var="cartUpdateFormAction" />
						<form:form id="updateCartForm${entry.entryNumber}" action="${cartUpdateFormAction}" method="post" commandName="updateQuantityForm${entry.entryNumber}">
							<input type="hidden" name="entryNumber" value="${entry.entryNumber}"/>
							<input type="hidden" name="productCode" value="${entry.product.code}"/>
							<input type="hidden" name="initialQuantity" value="${entry.quantity}"/>
							
							<div class="cartpage_order_num clearfix">
							<c:if test="${entry.updateable}" >
								<ycommerce:testId code="cart_product_updateQuantity">
									<a href="javascript:void(0);" class="minus">-</a>
									<%--
									<a href="#" id="QuantityProduct_${entry.entryNumber}" class="updateQuantityProduct"><spring:theme code="basket.page.update"/></a>
									 --%>
								</ycommerce:testId>
							</c:if>
							<ycommerce:testId code="cart_product_quantity">
								<form:label cssClass="skip" path="quantity" for="quantity${entry.entryNumber}"><spring:theme code="basket.page.quantity"/></form:label>
								<form:input disabled="${not entry.updateable}" type="text" size="1" id="quantity${entry.entryNumber}" class="qty" path="quantity" />
							</ycommerce:testId>
							<c:if test="${entry.updateable}" >
								<ycommerce:testId code="cart_product_updateQuantity">
									<a href="javascript:void(0);" class="plus">+</a>
								</ycommerce:testId>
							</c:if>
							</div>
							<span id="QuantityProduct_${entry.entryNumber}" class="updateQuantityProduct" style="display:none;"></span>
						</form:form>
					</td>

					 <td headers="header5" >
						 <ycommerce:testId code="cart_totalProductPrice_label">
							 <strong class="unit"><format:price priceData="${entry.totalPrice}" displayFreeForZero="true"/></strong>
						 </ycommerce:testId>
					 </td>
					 <td headers="header6" >
						<c:if test="${entry.updateable}" >
							<ycommerce:testId code="cart_product_removeProduct">
								<spring:theme code="text.iconCartRemove" var="iconCartRemove"/>
								<a href="#" id="RemoveProduct_${entry.entryNumber}" class="submitRemoveProduct cartpage_order_btnDel">${iconCartRemove}</a>
							</ycommerce:testId>
						</c:if>
					 </td>
					 
				 </tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	
</div>
<storepickup:pickupStorePopup />
