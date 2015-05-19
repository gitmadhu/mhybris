<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<script type="text/javascript">
/*<![CDATA[*/
	function submitRemove(id){
		var productCode = $('#updateCartForm'+id).get(0).productCode.value;
		var initialCartQuantity = $('#updateCartForm'+id).get(0).initialQuantity.value;
		
		if(window.trackRemoveFromCart) {
			trackRemoveFromCart(productCode, initialCartQuantity);
		}

		$('#updateCartForm'+id+' input[name=quantity]').val(0);
		$('#updateCartForm'+id+' input[name=initialQuantity]').val(0);
		console.log($('#updateCartForm'+id+' input[name=quantity]').val());
		$('#updateCartForm'+id).submit();
	}
	function submitUpdate(id){
		var productCode = $('#updateCartForm'+id).get(0).productCode.value;
		var initialCartQuantity = $('#updateCartForm'+id).get(0).initialQuantity.value;
		var newCartQuantity = $('#updateCartForm'+id).get(0).quantity.value;
		
		if(window.trackUpdateCart) {
			trackUpdateCart(productCode, initialCartQuantity, newCartQuantity);
		}
		
		$('#updateCartForm'+id).get(0).submit();
	}
	function submitBundleRemove(id){
		$('#deleteBundleForm'+id).get(0).submit();
	}
/*]]>*/
</script>

<div class="item_container_holder">
	<div class="title_holder">
		<div class="title">
			<div class="title-top">
				<span></span>
			</div>
		</div>
		<h2><spring:theme code="basket.page.title.yourItems"/></h2>
	</div>
	<div class="item_container">

		<div class="cart_id"><spring:theme code="basket.page.cartId"/>&nbsp;<span class="cart-id-nr">${cartData.code}</span>
			<c:forEach var="invalidMap" items="${cartData.firstIncompleteBundleComponentsMap}"> 

				<div class="small_popup_container">
					<div class="small_popup_headline">
						<div class="small_popup_emark">
							<theme:image code="img.iconCartError" alt="${iconCartError}" title="${iconCartError}"/>
						</div>
						<div class="small_popup_headline_text">
							<spring:theme code="basket.page.notification" text="Notification"/>
						</div>
						<div class="clear"></div>
					</div>
					<div class="small_popup_content">
						<h3><spring:theme code="basket.page.message.edit0" arguments="${invalidMap.value.name},${invalidMap.key}"/></h3>
						<div class="clear"></div>	
						<p><spring:theme code="basket.page.message.info"/></p>
						<div class="invalid-bundle-wizard">
							<a href="<c:url value="/bundle/edit-component/${invalidMap.key}/component/${invalidMap.value.id}"/>" class="invalid-bundle-wizard-editable"><spring:theme code="basket.page.message.return" arguments="${invalidMap.value.name}"/></a>
						</div>		
						<div class="clear"></div>				
					</div>
				</div>
			</c:forEach>
		</div>
		<table id="your_cart" class="your_cart-CartItems">
			<thead>
				<tr>
					<th><span class="skiptocontent">Product</span></th>
					<th><span class="skiptocontent">Product Details</span></th>
					<th><span class="skiptocontent"><spring:theme code="basket.page.quantity"/></span></th>
					<c:forEach items="${cartData.orderPrices}" var="tpentry" varStatus="rowCounter">					 
					      <th><span class="skiptocontent"></span></th>
				    </c:forEach>
				</tr>
			</thead>
			
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
					<tbody title="<c:choose><c:when test='${not empty entry.rootBundleTemplate.name}'>${entry.rootBundleTemplate.name}</c:when><c:otherwise><spring:theme code='basket.standalone.name'/></c:otherwise></c:choose>">
							<tr class="cart-bundle-divider">
					  	 	<td colspan="7">
					  	 		&nbsp;
					  	 	</td>
					   </tr>
					   <tr class="cart-bundle-header">
					    <td class="cart-bundle-package">
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
						<td class="cart-bundle-quantity">
							<spring:theme code="basket.page.quantity"/>
						</td>
					    <c:forEach items="${cartData.orderPrices}" var="tpentry" varStatus="rowCounter">					 
					      <td class="cart-bundle-itemPrice">
					      	${tpentry.billingTime.name}
						  </td>
					    </c:forEach>
					    <td class="cart-bundle-remove <c:if test='${entry.updateable}'>updateable-items</c:if>">
					    	<ycommerce:testId code="cart_product_removeProduct">
												<a href="javascript:submitBundleRemove('${uniqueBundleId}');" title="Remove Bundle">							
													<spring:theme code="text.iconCartRemove" var="iconCartRemove"/>
													<theme:image code="img.iconCartRemove" alt="${iconCartRemove}" title="${iconCartRemove}"/>
												</a>									
									</ycommerce:testId>
					    </td>
					   </tr>
						<c:set var="lastBundleNo" value="${entry.bundleNo }"/>
				</c:if>
					<c:url value="${entry.product.url}" var="productUrl"/>
					<tr class="cart-bundle-content">
				    <td class="cart-bundle-package">
				    	${entry.component.name}
			       <c:if test="${entry.editable}">
			       	<c:if test="${entry.valid}">
			          <a href="<c:url value="/bundle/edit-component/${entry.bundleNo}/component/${entry.component.id}"/>" class="cart-bundle-editable"><spring:theme code="basket.page.edit" text="Edit"/></a>
			       </c:if>
			       </c:if>
			       		<c:if test="${entry.bundleNo == 0}">
			       			<c:set value="${ycommerce:productImage(entry.product, 'thumbnail')}" var="primaryImage"/>
			       			<c:if test="${not empty primaryImage}">	
								<div class="product_image clearfix">
									<a href="${productUrl}">
										<product:productPrimaryImage product="${entry.product}" format="thumbnail"/>
									</a>
								</div>
							</c:if>
			       		</c:if>
				    </td>
						<td class="cart-bundle-product">
							<c:if test="${entry.bundleNo > 0}">
								<c:set value="${ycommerce:productImage(entry.product, 'thumbnail')}" var="primaryImage"/>
								<c:if test="${not empty primaryImage}">							
									<div class="product_image clearfix">
										<a href="${productUrl}">
											<product:productPrimaryImage product="${entry.product}" format="thumbnail"/>
										</a>
									</div>
								</c:if>
							</c:if>
							<ycommerce:testId code="cart_product_name">
								<div class="cart-productname"><a href="${productUrl}">${entry.product.name}</a></div>
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
							<br><br>

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
							
							<c:if test="${not entry.valid}">
								<div class="invalid-cartitem">
								    <spring:theme code="basket.page.bundle.message.missing.option" text="Sorry, there seems to be a missing option."/>
									<c:forEach var="invalidMap" items="#">		 
										<c:if test="${entry.editable}">
						          <a href="<c:url value="/bundle/edit-component/${entry.bundleNo}/component/${entry.component.id}"/>" class="cart-bundle-editable invalid-cartitem-editable"><spring:theme code="basket.page.message.addComponent" text="Please add {0}" arguments="${entry.component.name}"/></a>
						       </c:if>
									</c:forEach>
								</div>
							</c:if>
						</td>
						<c:set value="${entry.product.code}${entry.entryNumber}" var="uniqueFormId"/>
						<td class="cart-bundle-quantity">
							<c:url value="/cart/update" var="cartUpdateFormAction" />
							<c:if test="${entry.product !=null }">
								<form:form id="updateCartForm${uniqueFormId}" action="${cartUpdateFormAction}" method="post" commandName="updateQuantityForm${uniqueFormId}">
								<input type="hidden" name="entryNumber" value="${entry.entryNumber}"/>
								<input type="hidden" name="productCode" value="${entry.product.code}"/>
								<input type="hidden" name="initialQuantity" value="${entry.quantity}"/>	
								
								<c:set var="isSubscriptionProduct" value="false"/>
								<c:if test="${not empty entry.product.subscriptionTerm}">
									<c:set var="isSubscriptionProduct" value="true"/>
								</c:if>
									<c:if test="${entry.updateable and !isSubscriptionProduct}" >
										<ycommerce:testId code="cart_product_updateQuantity">	
											<a href="javascript:submitUpdate('${uniqueFormId}');"><spring:theme code="basket.page.update"/></a>										
										</ycommerce:testId>
									</c:if>						
								<ycommerce:testId code="cart_product_quantity">
									<c:choose>
									  <c:when test="${not entry.updateable or isSubscriptionProduct}">
										<input type="hidden" name="quantity" class="qty" value="${entry.quantity}"/>
									  	<span class="quantity-not-updateable">${entry.quantity}</span>
									  </c:when>
									  <c:otherwise>
									  	<label class="skip"><spring:theme code="basket.page.quantity"/></label>
									    <input type="text" name="quantity" class="qty" size="1" value="${entry.quantity}"/>
									  </c:otherwise>
									</c:choose>						
								</ycommerce:testId>
									
								
							</form:form>
							</c:if>
												
						</td>
						<c:choose>
							<c:when test="${not empty entry.product}">
								<c:forEach items="${entry.orderEntryPrices}" var="orderEntryPrice"> <!-- please ensure that these TDs get rendered always to avoid a uneven number of TDs per Row -->
									<td class="cart-bundle-itemPrice">
									<c:choose>
										<c:when test="${not empty orderEntryPrice.totalPrice}">	
							               	<c:if test="${(orderEntryPrice.basePrice.value - orderEntryPrice.totalPrice.value) > 0}">
							                	<del><format:price priceData="${orderEntryPrice.basePrice}" displayFreeForZero="true"/></del>
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
							     <td class="cart-bundle-itemPrice">
							     &nbsp;
							     </td>
							   </c:forEach>
							</c:otherwise>
						</c:choose>
						<td class="cart-bundle-remove">
							<c:if test="${entry.removeable}" >							
								<ycommerce:testId code="cart_product_removeProduct">										
										<a href="javascript:submitRemove('${uniqueFormId}');">
											<spring:theme code="text.iconCartRemove" var="iconCartRemove"/>
											<theme:image code="img.iconCartRemove" alt="${iconCartRemove}" title="${iconCartRemove}"/>
										</a>									
								</ycommerce:testId>
							</c:if>		
						</td>
					</tr>
					
				</c:forEach>
</tbody>
		</table>					

	</div>
</div>
