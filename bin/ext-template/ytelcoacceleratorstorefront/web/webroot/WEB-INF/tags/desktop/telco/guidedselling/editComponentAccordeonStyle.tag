<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="bundleTemplateData" required="true" type="de.hybris.platform.configurablebundlefacades.data.BundleTemplateData" %>
<%@ attribute name="bundleNo" required="true" type="java.lang.Integer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<input type="hidden" id="refreshed" value="no">

<script type="text/javascript">
$(document).ready(function(){ 
    var e=document.getElementById("refreshed");
    if(e.value=="no") {
    	e.value="yes";
    }
    else {
    	e.value="no";
    	location.reload();
    };
	if ($("#globalMessages div.span-24 div").hasClass("negative")) {
		 $(document).scrollTop(0).focus();
	} 
	else {		
		
		$(document).scrollTop( $("#box_expanded").focus().offset().top ); 
	};
});
</script>

<div class="prod_add_to_cart">
		<%-- with a plan --%>
        
<c:url value="/bundle/addEntry" var="addToCart" />
<c:url value="/bundle/removeEntry" var="cartUpdateFormAction" />

	<c:forEach items="${bundleTemplateData.bundleBoxes}" var="bundleBox" varStatus="bundleBoxCounter">
    <div class="prod_add_to_cart_box" <c:if test="${bundleBox.expanded}">id="box_expanded" tabindex="0"</c:if>>
			<h2>${bundleBox.component.name}
				<c:if test="${bundleBox.reviewButton}">
					<a class="review_area" href="<c:url value="/bundle/edit-component/${bundleNo}/component/${bundleBox.component.id}"/>"><spring:theme code="extras.review.button"/></a>
				</c:if>
			</h2>
			<c:if test="${bundleBox.expanded}">
	      <p class="description"><spring:theme code="extras.package.message"/></p>
	     </c:if>
			<table class="prod_add_bundle-table">

				<c:set var="buttonType">submit</c:set>
					<c:forEach items="${bundleBox.bundleBoxEntries}" var="bundleBoxEntry" varStatus="bundleBoxEntryCounter">
						<tr class="add_on <c:if test='${not bundleBoxEntry.selected and not bundleBoxEntry.disabled}'>remove_selected</c:if> <c:if test='${bundleBoxEntry.selected}'>selected</c:if>">
						  	<form:form id="bundleAddToCartForm${bundleBoxEntryCounter.count}" action="${addToCart}" method="post">
							<td class="prod_add_to_cart-table-td1">
								<h3>${bundleBoxEntry.product.name}</h3>
								<p>${bundleBoxEntry.product.description}</p>
               </td>
              <td class="prod_add_to_cart-table-td2">
              	<c:if test="${not bundleBoxEntry.selected}">
									<p class="expand_price"><format:price priceData="${bundleBoxEntry.product.thisBundleProductPrice}"/></p> 

									<c:set var="lastRecurringCharge" value="${bundleBoxEntry.product.price}"/>
									<c:if test="${bundleBoxEntry.product.price['class'].simpleName eq 'SubscriptionPricePlanData' and not empty bundleBoxEntry.product.price.recurringChargeEntries}">
										<c:forEach items="${bundleBoxEntry.product.price.recurringChargeEntries}" var="curRecurringCharge" varStatus="rowCounterRecurringCharge">
											<c:set var="lastRecurringCharge" value="${curRecurringCharge}"/>
										</c:forEach>
									</c:if>
									<p>
										<c:if test="${(lastRecurringCharge.price.value - bundleBoxEntry.product.thisBundleProductPrice.value) > 0}">
											<del><format:price priceData="${lastRecurringCharge.price}" displayFreeForZero="true"/></del>
										</c:if>
									</p>
								</c:if>
								<c:if test="${bundleBoxEntry.selected}">									
							        <c:forEach items="${bundleBoxEntry.orderEntry.orderEntryPrices}" var="orderEntryPrice">
							        	<c:if test="${orderEntryPrice.defaultPrice}">
							        		<p class="expand_price"><format:price priceData="${orderEntryPrice.totalPrice}"/></p>
											<p>
												<c:if test="${(orderEntryPrice.basePrice.value - orderEntryPrice.totalPrice.value) > 0}"> 
												    <del><format:price priceData="${orderEntryPrice.basePrice}" displayFreeForZero="true"/></del>
												</c:if>
											</p>
							        	</c:if>
							        </c:forEach>
									
								</c:if>
									
                <div class="frequency">/ ${bundleBoxEntry.product.subscriptionTerm.billingPlan.billingTime.name}</div>
                
								<input type="hidden" name="quantity" value="1"/>
								<input type="hidden" name="productCodePost" value="${bundleBoxEntry.product.code}"/>
								<input type="hidden" name="bundleNo" value="${bundleNo}"/>
								<input type="hidden" name="bundleTemplateId" value="${bundleBox.component.id}"/>
								<input type="hidden" name="navigation" value="CURRENT"/>									
							</td>
							<td class="prod_add_to_cart-table-td3">
								<c:if test="${not bundleBoxEntry.selected and not bundleBoxEntry.disabled}">
									<spring:theme code="text.addToCart" var="addToCartText"/>
									<button type="${buttonType}" class="positive small" title="<spring:theme code="basket.add.to.basket" />">
										<spring:theme code="text.addToCart" var="addToCartText"/>
										<spring:theme code="basket.add.to.basket" />
									</button>							
								 </c:if>
								 <c:if test="${not bundleBoxEntry.selected and bundleBoxEntry.disabled}">
								 	<div class="telco-tooltip-container">
									 	<button type="${buttonType}" class="positive small disabled" disabled="disabled">
											<spring:theme code="text.addToCart" var="addToCartText"/>
											<spring:theme code="basket.add.to.basket" />
										</button>	
										<div class="telco-tooltip">
											${bundleBoxEntry.disabledMessage}
										</div>
									</div>
								 </c:if>
							  </form:form>
								 <c:if test="${bundleBoxEntry.selected and bundleBoxEntry.removable}"> 								 	
								   		<form:form id="updateCartForm${uniqueFormId}" action="${cartUpdateFormAction}" method="post">
											<input type="hidden" name="entryNumber" value="${bundleBoxEntry.orderEntry.entryNumber}"/>
											<input type="hidden" name="productCode" value="${bundleBoxEntry.orderEntry.product.code}"/>
											<input type="hidden" name="initialQuantity" value="${bundleBoxEntry.orderEntry.quantity}"/>								
											<input type="hidden" name="bundleNo" value="${bundleNo}"/>
											<input type="hidden" name="componentId" value="${bundleBox.component.id}"/>												
											<input type="hidden" name="quantity" value="0"/>
											<!-- 
												TODO: evaluate ytelcoacceleratorstorefront.testIds.enable 
												property and do not show id for production 
											-->
											<button type="${buttonType}" class="negative small" id="REMOVE_${bundleBoxEntry.orderEntry.product.code}" title="<spring:theme code="basket.icon.cart.remove" />">
												<spring:theme code="text.iconCartRemove" var="iconCartRemove"/>
												<spring:theme code="basket.icon.cart.remove" />						
											</button>
										</form:form>   
								</c:if>	
								<c:if test="${bundleBoxEntry.selected and not bundleBoxEntry.removable}"> 
								        <div class="telco-tooltip-container">
											<button type="${buttonType}" class="positive small disabled" disabled="disabled" id="REMOVE_${bundleBoxEntry.orderEntry.product.code}">
												<spring:theme code="text.iconCartRemove" var="iconCartRemove"/>
												<spring:theme code="basket.icon.cart.remove" />					
											</button>
											<div class="telco-tooltip">
											    ${bundleBoxEntry.disabledMessage}
										    </div>	
										</div>
								</c:if>
							</td>					  					
						</tr>
				</c:forEach>							
			</table>
     </div>
       
		
		
			<c:if test="${bundleBox.expanded}">
 				 <div class="prod_add_to_cart_box_buttons">
                 	<p><a class="end_step" href="<c:url value="/bundle/edit-component/${bundleNo}/nextcomponent/${bundleBox.component.id}"/>"><spring:theme code="extras.continue.button"/></a></p>
                    <div class="prod_add_to_cart_box_buttons_clear"></div>
                  </div>
 			</c:if>
 		
 		
 			
 		
 		
	</c:forEach>
	<p class="imdone_step-container"><a class="imdone_step" href="<c:url value="/cart"/>"><spring:theme code="extras.done.button"/></a></p>
</div>
