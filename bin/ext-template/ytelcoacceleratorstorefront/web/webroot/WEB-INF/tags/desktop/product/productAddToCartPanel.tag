<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="allowAddToCart" required="true" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".prod_add_to_cart").addClass("js");
		
		$(".tabs").accessibleTabs({
	    	tabhead:'h2',
	    	fx:"show",
	    	fxspeed:null
    	});
		$(".subTabs").accessibleTabs({
			tabhead:'h3',
			tabbody:'.sub-tabbody',
			currentClass: 'sub-current',
			fx:"show",
			fxspeed:null
		});
		$(".prod_add_to_cart td.item-only-add button").click(function(){
    		$("#cart_popup div.title a h3").focus();
		});
		
		$(".delayed-button").click(function(){
	    	/* Onclick Handling for the add to cart button, that is diabled for 1 second after click*/
	    	$('.prod_add_to_cart').delay('50').queue(function () {
	    			$(this).find('button.delayed-button[type=submit]').prop("disabled", true).addClass("disabled").html("Please wait").delay('2000').queue(function() {
		    			$(this).prop("disabled", false).removeClass("disabled").html("Add to cart").dequeue();
		    		});
		    		$(this).dequeue();
			});
		});
	});
</script>    

<div class="prod_add_to_cart">

	<c:url value="/cart/add" var="addToCartUrl"/>

	<c:if test="${product.itemType eq 'Product' or product.itemType eq 'Accessory'}">
		<form:form id="addToCartForm" class="add_to_cart_form" action="${addToCartUrl}" method="post">
		
		<div class="tabbody device-only">
					
		<input type="hidden" name="productCodePost" value="${product.code}"/>
			
			<c:if test="${product.purchasable and product.stock.stockLevel le 0}">
				<td><c:set var="productStockLevel"><spring:theme code="product.variants.out.of.stock"/></c:set></td>
			</c:if>
			<c:if test="${product.stock.stockLevel gt 0}">
				<c:set var="productStockLevel">${product.stock.stockLevel}&nbsp;<spring:theme code="product.variants.in.stock"/></c:set>
			</c:if>
			<c:if test="${product.stock.stockLevelStatus.code eq 'inStock' and product.stock.stockLevel le 0}">
				<td><c:set var="productStockLevel"><spring:theme code="product.variants.available"/></c:set></td>
			</c:if>
	
			<ycommerce:testId code="productDetails_productInStock_label">
				<p class="stock_message">${productStockLevel}</p>
			</ycommerce:testId>
	
			<c:set var="buttonType">button</c:set>
			<c:if test="${allowAddToCart and product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
				<c:set var="buttonType">submit</c:set>
			</c:if>
		</div>

		<table class="item-only-table">
			<tr>
				<td class="item-only-cell-price">
					<p class="big-price">
						<format:fromPrice priceData="${product.price}" />
					</p>
				</td>
				<td class="item-only-cell-quantity">
					<c:if test="${product.purchasable}">
						<label for="qty"><spring:theme code="basket.page.quantity" /></label>
						<input type="text" size="1" id="qty" name="qty" class="qty" value="1">
						<input type="hidden" size="2" id="bundleNo" name="bundleNo" value="0">
					</c:if>
				</td>
				<td class="item-only-cell-add">
					<spring:theme code="text.addToCart" var="addToCartText"/>
					<button type="${buttonType}" class="positive large <c:if test="${fn:contains(buttonType, 'button')}">out-of-stock</c:if>">
						<spring:theme code="text.addToCart" var="addToCartText"/>
						<spring:theme code="basket.add.to.basket" />
					</button>
				</td>
			</tr>
		</table>
		
	</form:form>
</c:if>
	
	 <!--- --> 

	<c:if test="${product.itemType eq 'Device'}">

		<%-- with a plan --%>
		<c:url value="/cart/addBundle" var="addToCartBundle" />
		<div class="tabs">
			<c:forEach items="${product.bundleTabs}" var="bundleTab" varStatus="bundleTabCounter">
				<h2>${bundleTab.parentBundleTemplate.name}</h2>
				<div class="tabbody">
				<!-- HERE SHOULD BE A IF{} FOR THE FOREACH. IF ARRAY.LENGTH GREATER THAN 1, RENDER THIS ELEMENT -->
				<c:if test="${fn:length(bundleTab.frequencyTabs) gt 0}">
					<div class="headline-contract-length-small">
						<spring:theme code="product.subscription.termofservicefrequency" />
					</div>				
				</c:if>
				<div class="subTabs">	
				<!-- - - - - - - - - - - - -->
				<c:forEach items="${bundleTab.frequencyTabs}" var="frequencyTab" varStatus="frequencyTabCounter">
					<h3><c:if test="${frequencyTab.termOfServiceNumber gt 0}">${frequencyTab.termOfServiceNumber} &nbsp;</c:if>${frequencyTab.termOfServiceFrequency.name}</h3>
						<div class="sub-tabbody">
						<table class="sub-tabbody-table">
							<c:if test="${allowAddToCart and product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
							
							</c:if>
							
							<c:forEach items="${frequencyTab.products}" var="plan" varStatus="plansCounter">	
							
							<tr>
									<!-- This contains the popup/hidden content for detail inline calls -->
										<script type="text/javascript">
										/*<![CDATA[*/
											$('a.detail-${bundleTabCounter.count}_${frequencyTabCounter.count}_${plansCounter.count}').colorbox({
												inline: true,
												href:"#detail-${bundleTabCounter.count}_${frequencyTabCounter.count}_${plansCounter.count}",
												width:"500px",
												height:"400px",
												onComplete: function(){
														 	$('#cboxClose').attr('tabindex', -1).focus();
														 	$("#cboxClose").bind('keyup',function(event){
																if(event.keyCode == 13){
																	$("#cboxClose").click();
																}
															});
														 },
												onCleanup:  function(){
																$("#cboxClose").unbind( 'keyup', false )
														 	}
												
											});
											
											$('a.detail-${bundleTabCounter.count}_${frequencyTabCounter.count}_${plansCounter.count}').keypress(function(e) {
									            var keyCode;
									            if (window.event) keyCode = window.event.keyCode;
									            else if(e) keyCode = e.which;
									            else return true;
									            if (keyCode == 13 || keyCode == 32) {
									                $(this).click();
									              	return false;
									            } else return true;
									        });  
									       										           

										/*]]>*/
										</script>

									<td class="sub-tabbody-table-td1">${plan.name} <a class="details detail-${bundleTabCounter.count}_${frequencyTabCounter.count}_${plansCounter.count}" tabindex="0" title="Details"><spring:theme code="product.overview" text="Details"/></a>
										<div style="display:none">
											<div id="detail-${bundleTabCounter.count}_${frequencyTabCounter.count}_${plansCounter.count}">
												<div class="small_popup_container" style="border-top: 0; margin-top: 0; border-bottom: 0;">
													<div class="small_popup_headline">
														<div class="small_popup_emark">
														</div>
														<div class="small_popup_headline_text">
															${plan.name} <spring:theme code="product.overview" text="Details"/>
														</div>
														<div class="clear"></div>
													</div>
													<div class="small_popup_content">
														<c:if test="${plan.subscriptionTerm.termOfServiceNumber gt 0}">${plan.subscriptionTerm.termOfServiceNumber} &nbsp;</c:if>${plan.subscriptionTerm.termOfServiceFrequency.name}, ${plan.subscriptionTerm.termOfServiceRenewal.name}
														<br>
														<c:if test="${not empty plan.price.recurringChargeEntries}">
															<c:set var="recurringChargeCount" value="${fn:length(plan.price.recurringChargeEntries)}"/>
														    <c:forEach items="${plan.price.recurringChargeEntries}" var="recurringPrice" varStatus="recurringPricesCounter">
														    	<c:choose>
														    		<c:when test="${recurringPrice.cycleEnd == '-1'}">
														    			<c:if test="${recurringChargeCount gt 1}">
														    				<spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${recurringPrice.cycleStart}"/>
														    			</c:if>
														    			<format:price priceData="${recurringPrice.price}"/>
														    		</c:when>
														    		<c:otherwise>
														    			<c:if test="${recurringChargeCount gt 1}">
														    				<spring:theme code="product.list.viewplans.price.interval" arguments="${recurringPrice.cycleStart}, ${recurringPrice.cycleEnd}"/>
														    			</c:if>
														        		<format:price priceData="${recurringPrice.price}"/>
														        	</c:otherwise>
														        </c:choose>
														        <br>
														    </c:forEach>
														    <div class="pay">${plan.subscriptionTerm.billingPlan.billingTime.name}</div>
													    </c:if>
													    
													    <c:if test="${not empty plan.price.oneTimeChargeEntries}">
													    	<c:if test="${not empty plan.price.recurringChargeEntries}">
													    		<br>
													    	</c:if>
													    	<c:forEach items="${plan.price.oneTimeChargeEntries}" var="oneTimePrice" varStatus="oneTimePricesCounter">
													    		<c:if test="${not oneTimePricesCounter.first}">
													    			<br/>
													    		</c:if>
													    		<spring:theme code="product.list.viewplans.price.onetime" arguments="${oneTimePrice.name}"/>
													    		<format:price priceData="${oneTimePrice.price}"/>
													    		<spring:theme code="product.details.oneTimePrice.billingTime.suffix" arguments="${oneTimePrice.billingTime.name}"/>
													    		<br>
													    	</c:forEach>
													    </c:if>

														<c:if test="${not empty plan.classifications}">
															<br>
										                    <c:forEach items="${plan.classifications}" var="classification">
											                    <div class="featureClass">
												                    <ul>
													                    <c:forEach items="${classification.features}" var="feature">
														                    <li>${feature.name}:&nbsp
														                    
														                        <c:forEach items="${feature.featureValues}" var="value" varStatus="status">
																		            ${value.value}
																		            <c:choose>
																			            <c:when test="${feature.range}">
																				            ${not status.last ? '-' : feature.featureUnit.symbol}
																			            </c:when>
																			            <c:otherwise>
																				            ${feature.featureUnit.symbol}
																				            ${not status.last ? '<br/>' : ''}
																			            </c:otherwise>
																		            </c:choose>
																	            </c:forEach>
														                    </li>
													                    </c:forEach>
												                    </ul>
											                    </div>
										                   </c:forEach>
									                   </c:if>

														<c:if test="${not empty plan.entitlements}">
															<br>
															<c:forEach items="${plan.entitlements}" var="entitlement">
																	<spring:theme code="product.details.entitlements" arguments="${entitlement.name}"/>															
																	<c:if test="${entitlement['class'].simpleName eq 'NonMeteredEntitlementData'}">
																		<spring:theme code="product.list.viewplans.entitlements.true" text="true"/>
																	</c:if>
																	<c:if test="${entitlement['class'].simpleName eq 'MeteredEntitlementData'}">
																		<c:choose>
																			<c:when test="${entitlement.quantity lt 0}">
																				<spring:theme code="product.list.viewplans.entitlements.unlimited"/>
																			</c:when>
																			<c:when test="${entitlement.quantity eq 1}">
																				<spring:theme code="product.list.viewplans.entitlements.meteredEntitlement" arguments="${entitlement.quantity}^${entitlement.usageUnit.name}" argumentSeparator="^" />
																			</c:when>
																			<c:otherwise>
																				<spring:theme code="product.list.viewplans.entitlements.meteredEntitlement" arguments="${entitlement.quantity}^${entitlement.usageUnit.namePlural}" argumentSeparator="^" />
																			</c:otherwise>
																		</c:choose>
																	</c:if>
																	<br>
															</c:forEach>
														</c:if>
				
														<c:if test="${not empty plan.price and not empty plan.price.usageCharges}">
															<br>
															<c:forEach items="${plan.price.usageCharges}" var="usageCharge">
																<spring:theme code="product.details.usageCharges" arguments="${usageCharge.name}"/>															
				                                                <c:if test="${not empty usageCharge.usageChargeEntries}">
				                                                    <c:forEach items="${usageCharge.usageChargeEntries}" var="usageChargeEntry">
				                                                        <c:if test="${usageChargeEntry['class'].simpleName eq 'TierUsageChargeEntryData'}">
				                                                            <spring:theme code="product.list.viewplans.tierUsageChargeEntry" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}^${usageCharge.usageUnit.name}" argumentSeparator="^"/><br/>
				                                                        </c:if>
				                                                        <c:if test="${usageChargeEntry['class'].simpleName eq 'OverageUsageChargeEntryData'}">
				                                                         	<spring:theme code="product.list.viewplans.overageUsageChargeEntry" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}"/>
				                                                        </c:if>
				                                                    </c:forEach>
					                                            </c:if>
					                                            <br>
															</c:forEach>
														</c:if>
									                   								                   
									                   <br>
									                   ${plan.description}
														
													</div>
												</div>
											</div>
										</div>
										<!-- This ends the popup/hidden content for detail inline calls -->
									</td>
									<td class="sub-tabbody-table-td2"><format:price priceData="${plan.otherBundleProductPrice}"/> <div class="pay"><spring:theme code="product.payNow" text="pay now"/></div> </td>
									<td class="sub-tabbody-table-td3">
										<c:set var="basePrice" value="${null}"/>
										<c:if test="${not empty plan.price.recurringChargeEntries}">
											<c:forEach items="${plan.price.recurringChargeEntries}" var="recurringChargeEntry" varStatus="recurringChargeEntryCounter">
												<c:set var="basePrice" value="${recurringChargeEntry.price}"/>
											</c:forEach>
										</c:if>
										<c:if test="${not empty basePrice and (basePrice.value - plan.thisBundleProductPrice.value) > 0}">
							            	<del><format:price priceData="${basePrice}" displayFreeForZero="true"/></del>
							            </c:if>
									    <format:price priceData="${plan.thisBundleProductPrice}"/> <div class="pay">${plan.subscriptionTerm.billingPlan.billingTime.name}</div> 
									</td>							
									<td class="sub-tabbody-table-td4">
										<form:form class="bundle_add_to_cart_form" id="bundleAddToCartForm${bundleTabCounter.count}_${frequencyTabCounter.count}_${plansCounter.count}" action="${addToCartBundle}" method="post">
										<spring:theme code="text.addToCart" var="addToCartText"/>
										<div id="${plan.code}">
											<c:set var="buttonTypeBundle">button</c:set>
								            <c:if test="${allowAddToCart and product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
									            <c:set var="buttonTypeBundle">submit</c:set>
								            </c:if>
											<button type="${buttonTypeBundle}" class="positive large delayed-button <c:if test="${fn:contains(buttonTypeBundle, 'button')}">out-of-stock</c:if>">
												<spring:theme code="text.addToCart" var="addToCartText"/>
												<spring:theme code="basket.add.to.basket" />
											</button>
										</div>
										<input type="hidden" name="productCode1" value="${product.code}"/>
										<input type="hidden" name="productCode2" value="${plan.code}"/>
										<input type="hidden" name="bundleTemplateId1" value="${bundleTab.sourceComponent.id}"/>
										<input type="hidden" name="bundleTemplateId2" value="${bundleTab.targetComponent.id}"/>	
										</form:form>	
									</td>
										
													
								</tr>
																											
								</c:forEach>
							</table>
							</div>
					</c:forEach>
					<!-- HERE SHOULD BE A IF{} FOR THE FOREACH. IF ARRAY.LENGTH GREATER THAN 1, RENDER THIS ELEMENT -->
					</div>	
					<!-- - - - - - - - - - - - -->
				</div>		
			</c:forEach>
			
			<c:if test="${product.soldIndividually}">
				<h2><spring:theme code="product.deviceOnly" text="Device Only"/></h2>
				<%-- device only --%> 
				<div class="tabbody device-only">
			
        <form:form id="addToCartForm" class="add_to_cart_form" action="${addToCartUrl}" method="post"> 
        	<table class="item-only-table">
		        <tr>
		        	<td class="item-only-price">
		        		<p class="big-price">
								<format:fromPrice priceData="${product.price}" />
								</p>
							</td>
		        	<td class="item-only-quantity">
		        		<c:if test="${product.purchasable}">
			        		<label for="qty"><spring:theme code="basket.page.quantity" /></label>
									<input type="text" size="1" id="qty" name="qty" class="qty" value="1">
									<input type="hidden" id="bundleNo" name="bundleNo" value="0">
								</c:if>
								<input type="hidden" name="productCodePost" value="${product.code}"/>
							</td>
							<c:if test="${product.purchasable and product.stock.stockLevel le 0}">
								<td class="item-only-stck-level">
									<c:set var="productStockLevel"><spring:theme code="product.variants.out.of.stock"/></c:set>
								</td>
							</c:if>
							<c:if test="${product.stock.stockLevel gt 0}">
								<td class="item-only-variants-in-stock">
									<c:set var="productStockLevel">${product.stock.stockLevel}&nbsp;<spring:theme code="product.variants.in.stock"/></c:set>
								</td>
							</c:if>
							<c:if test="${product.stock.stockLevelStatus.code eq 'inStock' and product.stock.stockLevel le 0}">
								<td class="item-only-variants">
									<c:set var="productStockLevel"><spring:theme code="product.variants.available"/></c:set>
								</td>
							</c:if>
							<td class="item-only-stockmessage">
								<ycommerce:testId code="productDetails_productInStock_label">
									<p class="stock_message">${productStockLevel}</p>
								</ycommerce:testId>
							</td>
							<td class="item-only-add">
								<c:set var="buttonType">button</c:set>
								<c:if test="${allowAddToCart and product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
									<c:set var="buttonType">submit</c:set>
								</c:if>
								<spring:theme code="text.addToCart" var="addToCartText"/>
								<button type="${buttonType}" class="positive large delayed-button <c:if test="${fn:contains(buttonType, 'button')}">out-of-stock</c:if>">
									<spring:theme code="text.addToCart" var="addToCartText"/>
									<spring:theme code="basket.add.to.basket" />
								</button>
							</td>
						</tr>
					</table>
				</form:form>

			</c:if>

			</div>

		</div>

	</c:if>
		
</div>
