<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ attribute name="showPotentialPromotions" required="false" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div class="item_container_holder">
	<div class="title_holder">
		<h2><spring:theme code="basket.page.title.yourItems"/></h2>
	</div>
	<div class="item_container">
		<span class="cart_id"><spring:theme code="basket.page.cartId"/>&nbsp;<span class="cart-id-nr">${cartData.code}</span></span>
		
		<table id="your_cart" class="your_cart-CartItems checkout-CartItems">
			<thead>
				<tr>
					<th id="header1"><span class="hidden">Product</span></th>
					<th id="header2"><span class="hidden">Product Details</span></th>
					<th id="header3"><span class="hidden"><spring:theme code="basket.page.quantity"/></span></th>
					<c:forEach items="${cartData.orderPrices}" var="tpentry" varStatus="rowCounter">					 
					      <th id="header${3 + rowCounter.count}"><span class="hidden"></span></th>
				    </c:forEach>
				</tr>
			</thead>
			<tbody>
			<c:set var="lastBundleNo" value="-9"/> <!-- some illegal value -->
			    <c:set var="firstBundleNo" value="-1"/>
			    <c:set var="displayPackageNo" value="false"/>
			    <c:forEach items="${cartData.entries}" var="entry">
			        <c:if test="${entry.bundleNo > 0 and firstBundleNo < 0}">
			             <c:set var="firstBundleNo" value="${entry.bundleNo}"/>
			        </c:if>
			        <c:if test="${entry.bundleNo > 0 and firstBundleNo > 0 and firstBundleNo != entry.bundleNo}">
			             <c:set var="displayPackageNo" value="true"/>
			        </c:if>
			    </c:forEach>
				<c:forEach items="${cartData.entries}" var="entry">
				<c:if test="${entry.bundleNo != lastBundleNo}">
				<c:set var="uniqueBundleId" value="${entry.rootBundleTemplate.id }${entry.bundleNo}" />
							<tr class="cart-bundle-divider">
					  	 	<td colspan="6">
					  	 		&nbsp;
					  	 	</td>
					   </tr>
					   <tr class="cart-bundle-header">
					    <td headers="header2" class="cart-bundle-package">
					    <c:choose>
								<c:when test="${not empty entry.rootBundleTemplate.name}">
								    <span class="cart-bundle-name">
								    	${entry.rootBundleTemplate.name}
								    	<c:if test="${displayPackageNo == true}">
								    	    <span class="cart-bundle-number">(<spring:theme code="basket.page.bundleNo"/> ${entry.bundleNo})</span>
								    	</c:if>								    
								    </span>
								    <c:url var="bundleDeleteAction" value="/cart/delete" />
								    <form:form id="deleteBundleForm${uniqueBundleId}" action="${bundleDeleteAction}" method="post" commandName="deleteBundleForm${uniqueBundleId}">
								        <input type="hidden" name="bundleNo" value="${entry.bundleNo}"/>	
								    </form:form>
								</c:when>								
								<c:otherwise>
								  <spring:theme code="basket.standalone.name"/>
								</c:otherwise>
						</c:choose>			
						</td>
						<td class="cart-bundle-product">
							<spring:theme code="basket.product.name"/>
						</td>
						<td headers="header3" class="cart-bundle-quantity">
							<spring:theme code="basket.page.quantity"/>
						</td>
					    <c:forEach items="${cartData.orderPrices}" var="tpentry" varStatus="rowCounter">					 
					      <td headers="header${3 + rowCounter.count}" class="cart-bundle-itemPrice">
					      	${tpentry.billingTime.name}
						  </td>
					    </c:forEach>
					   </tr>
						<c:set var="lastBundleNo" value="${entry.bundleNo }"/>
				</c:if>
					<c:url value="${entry.product.url}" var="productUrl"/>
					<tr class="cart-bundle-content">
				    <td class="cart-bundle-package">
				    	${entry.component.name}
							<c:if test="${entry.bundleNo == 0}">
								<c:set value="${ycommerce:productImage(entry.product, 'thumbnail')}" var="primaryImage"/>
								<c:if test="${not empty primaryImage}">							
									<span class="product_image">
										<product:productPrimaryImage product="${entry.product}" format="thumbnail"/>
									</span>
								</c:if>
							</c:if>
				    </td>
						<td headers="header2" class="cart-bundle-product">
							<c:if test="${entry.bundleNo > 0}">
								<c:set value="${ycommerce:productImage(entry.product, 'thumbnail')}" var="primaryImage"/>
								<c:if test="${not empty primaryImage}">							
									<span class="product_image">
										<product:productPrimaryImage product="${entry.product}" format="thumbnail"/>
									</span>
								</c:if>
							</c:if>
							<ycommerce:testId code="cart_product_name">
								<div class="cart-productname">${entry.product.name}</div>
								<c:if test="${not empty entry.entryMessage}">
									<div class="cart-entrymessage">${entry.entryMessage}</div>
								</c:if>
							</ycommerce:testId>
							<c:forEach items="${entry.product.baseOptions}" var="option">
								<c:if test="${not empty option.selected and option.selected.url eq entry.product.url}">
									<c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
										<dl>
											<dt>${selectedOption.name}:</dt>
											<dd>${selectedOption.value}</dd>
										</dl>
									</c:forEach>
								</c:if>
							</c:forEach>
							<c:forEach items="${cartData.orderPrices}" var="orderPrice" varStatus="rowCounter">	
     							<c:if test="${ycommerce:doesAppliedPromotionExistForOrderEntryAndBillingTime(cartData, entry.entryNumber, orderPrice.billingTime)}">
     								${orderPrice.billingTime.name}:
     								<ul class="cart-promotions">
     									<c:forEach items="${orderPrice.appliedProductPromotions}" var="promotion">
     										<c:set var="displayed" value="false"/>
     										<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
     											<c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber}">
     												<c:set var="displayed" value="true"/>
     												<li class="cart-promotions-applied">
     													<ycommerce:testId code="cart_appliedPromotion_label">
     														<span>${promotion.description}</span>
     													</ycommerce:testId>
     												</li>
     											</c:if>
     										</c:forEach>
     									</c:forEach>
     								</ul>
     							</c:if>
 							</c:forEach>

							<c:forEach items="${cartData.orderPrices}" var="orderPrice" varStatus="rowCounter">	
    							<c:if test="${ycommerce:doesPotentialPromotionExistForOrderEntryAndBillingTime(cartData, entry.entryNumber, orderPrice.billingTime)}">
    								<ul class="cart-promotions">
    									<li class="">${orderPrice.billingTime.name}:</li>
    									<c:forEach items="${orderPrice.potentialProductPromotions}" var="promotion">
    										<c:set var="displayed" value="false"/>
    										<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
    											<c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber && not empty promotion.description}">
    												<c:set var="displayed" value="true"/>
    												<li class="cart-promotions-potential">
    													<ycommerce:testId code="cart_potentialPromotion_label">
    														<span>${promotion.description}</span>
    													</ycommerce:testId>
    												</li>
    											</c:if>
    										</c:forEach>
    									</c:forEach>
    								</ul>
    							</c:if>
							</c:forEach>
						</td>
						<c:set value="${entry.product.code}${entry.entryNumber}" var="uniqueFormId"/>
						<td headers="header3" class="cart-bundle-quantity">
							<c:url value="/cart/update" var="cartUpdateFormAction" />
							<c:if test="${entry.product !=null }">
								<ycommerce:testId code="cart_product_quantity">
									<c:choose>
									  <c:when test="${not entry.updateable}">
										<input type="hidden" name="quantity" class="qty" value="${entry.quantity}"/>
									  	<span class="quantity-not-updateable">${entry.quantity}</span>
									  </c:when>
									  <c:otherwise>
									    ${entry.quantity}
									  </c:otherwise>
									</c:choose>						
								</ycommerce:testId>
							</c:if>
						</td>
						<c:choose>
							<c:when test="${not empty entry.product}">
								<c:forEach items="${entry.orderEntryPrices}" var="orderEntryPrice" varStatus="rowCounter"> <!-- please ensure that these TDs get rendered always to avoid a uneven number of TDs per Row -->
									<td headers="header${3 + rowCounter.count}" class="cart-bundle-itemPrice">
									<c:choose>
										<c:when test="${not empty orderEntryPrice.totalPrice}">	
											<c:if test="${(orderEntryPrice.basePrice.value - orderEntryPrice.totalPrice.value) > 0}">
											    <del><format:price priceData="${orderEntryPrice.basePrice}" displayFreeForZero="true"/>
											    </del>
											</c:if>
												<format:price priceData="${orderEntryPrice.totalPrice}" displayFreeForZero="false"/>
								  		</c:when>
										<c:otherwise>
												&nbsp;
								  		</c:otherwise>
							  		</c:choose>	

							  		<c:forEach items="${cartData.orderPrices}" var="orderPrice" varStatus="rowCounter">	
							        	<c:if test="${orderPrice.billingTime.name eq orderEntryPrice.billingTime.name and ycommerce:doesAppliedPromotionExistForOrderEntryAndBillingTime(cartData, entry.entryNumber, orderPrice.billingTime)}">
         									<c:forEach items="${orderPrice.appliedProductPromotions}" var="promotion">
         										<c:set var="displayed" value="false"/>
         										<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
         											<c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber}">
         												<c:set var="displayed" value="true"/>
         												<li class="cart-promotions-applied">
         													<ycommerce:testId code="cart_appliedPromotion_label">
         														<span>${promotion.description}</span>
         													</ycommerce:testId>
         												</li>
         											</c:if>
         										</c:forEach>
         									</c:forEach>
							            </c:if>							  			
							  		</c:forEach>

							  		<c:forEach items="${cartData.orderPrices}" var="orderPrice" varStatus="rowCounter">	
							        	<c:if test="${orderPrice.billingTime.name eq orderEntryPrice.billingTime.name and ycommerce:doesPotentialPromotionExistForOrderEntryAndBillingTime(cartData, entry.entryNumber, orderPrice.billingTime)}">
         									<c:forEach items="${orderPrice.potentialProductPromotions}" var="promotion">
         										<c:set var="displayed" value="false"/>
         										<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
         											<c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber}">
         												<c:set var="displayed" value="true"/>
         												<li class="cart-promotions-potential">
         													<ycommerce:testId code="cart_potentialPromotion_label">
         														<span>${promotion.description}</span>
         													</ycommerce:testId>
         												</li>
         											</c:if>
         										</c:forEach>
         									</c:forEach>
							            </c:if>							  			
							  		</c:forEach>

							  		</td>				  		
								</c:forEach>
							</c:when>
							<c:otherwise>
							   <c:forEach items="${cartData.orderPrices}" varStatus="rowCounter">
							     <td headers="header${3 + rowCounter.count}" class="cart-bundle-itemPrice">
							     &nbsp;
							     </td>
							   </c:forEach>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
