<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:theme code="text.addToCart" var="addToCartText"/>
<c:url value="${product.url}" var="productUrl"/>

<ycommerce:testId code="product_wholeProduct">
<c:url value="/sbgproducts/oneclickbuy" var="oneClickBuy"/>
<form:form id="oneClickBuyForm" action="${oneClickBuy}" method="post">
<input type="hidden" name="productCodePost" value="${product.code}"/>
<c:if test="${fn:contains(product.url, 'Add-Ons')}"><div class="productlist-addon"></c:if>

	<div class="sbgProductHeaderThumb">
		<div class="thumb">
			<a href="${productUrl}" title="${product.name}">
				<product:productPrimaryImage product="${product}" format="product"/>
			</a>
		</div>
	</div>

	<div class="sbgProductHeader" data-row="1">
				
		<div class="name"> <!-- telco change -->
			<ycommerce:testId code="product_productName">
				<a href="${productUrl}" title="${product.name}">
					${product.name}
				</a>
			</ycommerce:testId>
		</div>
		
		<div class="summary"> <!-- telco change -->
			${product.summary}
		</div>
			
		<c:if test="${not empty product.classifications}">
			<div class="grid-product-features">
				<c:forEach items="${product.classifications}" var="classification">
					<div class="featureClass">
						<table>
							<tbody>
								<c:forEach items="${classification.features}" var="feature">
									<tr>
										<td headers="header1" class="attrib">${feature.name}</td>
			
										<td headers="header1">
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
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:forEach>
			</div>
		</c:if>				
		
		<c:if test="${not empty product.averageRating}">
			<div class="grid-product-rating">
				<span class="stars large" style="display: inherit;">
					<span style="width: <fmt:formatNumber maxFractionDigits="0" value="${product.averageRating * 24}" />px;"></span>
				</span>
				<p><fmt:formatNumber maxFractionDigits="1" value="${product.averageRating}" />/5</p>
				<p class="prod_review-info">							
					<c:choose>
							<c:when test="${(product.numberOfReviews) > 1}">
								<a href="#" id="based_on_reviews"><spring:theme code="review.based.on" arguments="${product.numberOfReviews}"/></a>
							</c:when>
							<c:otherwise>
								<a href="#" id="based_on_reviews"><spring:theme code="review.based.on.one" arguments="${product.numberOfReviews}"/></a>
							</c:otherwise>
					</c:choose>
				</p>
			</div>
		</c:if>
		
		
		<%--
		<div class="grid-product-price">
			<ycommerce:testId code="product_productPrice">
				<spring:theme code="text.withinPackage" var="withinPackage"/>
				<c:if test="${product.lowestBundlePrice ne null and product.lowestBundlePrice.value < product.price.value}">
					<p class="price"><span class="price-label">${withinPackage}</span><format:price priceData="${product.lowestBundlePrice}"/></p>
					<del><format:price priceData="${product.price}"/></del>					
				</c:if>
				<c:if test="${product.lowestBundlePrice eq null or (product.lowestBundlePrice ne null and product.lowestBundlePrice.value >= product.price.value)}">
					<p class="price"><format:price priceData="${product.price}" displayFreeForZero="true"/></p>					
				</c:if>	
				<c:if test="${fn:contains(product.url, 'Add-Ons')}"><p class="price-frequency">${product.subscriptionTerm.billingPlan.billingTime.name}</p></c:if>	
				<c:if test="${fn:contains(product.url, 'Plans')}"><p class="price-frequency">${product.subscriptionTerm.billingPlan.billingTime.name}</p></c:if>	
			</ycommerce:testId>
			<c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">
				<c:set var="buttonType">button</c:set>
				<spring:theme code="text.addToCart.outOfStock" var="addToCartText"/>
			</c:if>
		</div>
		
	</div>
	--%>
	
	
</div>
<c:if test="${fn:contains(product.url, 'Add-Ons')}"></div></c:if>		

<div class="viewplan" data-row="2">
	<div class="header"><spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency"/></div>
	<div class="content">${product.subscriptionTerm.billingPlan.billingTime.name}</div>
</div>

<div class="viewplan" data-row="3">
	<div class="header"><spring:theme code="product.list.viewplans.price" text="Price"/></div>
	<div class="content">
        <c:if test="${not empty product.price.recurringChargeEntries}">
        	<c:set var="recurringChargeCount" value="${fn:length(product.price.recurringChargeEntries)}"/>
            <c:forEach items="${product.price.recurringChargeEntries}" var="recurringPrice" varStatus="recurringPricesCounter">
            	<c:choose>
            		<c:when test="${recurringPrice.cycleEnd == '-1'}">
            			<c:if test="${recurringChargeCount gt 1}">
            				<spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${recurringPrice.cycleStart}"/>
            			</c:if>
						<c:if test="${recurringChargeCount eq 1 and recurringPrice.cycleStart gt 1}">
							<spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${recurringPrice.cycleStart}"/>
						</c:if>
            			<format:price priceData="${recurringPrice.price}"/>
            		</c:when>
            		<c:otherwise>
            			<spring:theme code="product.list.viewplans.price.interval" arguments="${recurringPrice.cycleStart}, ${recurringPrice.cycleEnd}"/>
                		<format:price priceData="${recurringPrice.price}"/>
                	</c:otherwise>
                </c:choose>
                <br>
            </c:forEach>
            <div class="pay">${product.subscriptionTerm.billingPlan.billingTime.name}</div>
        </c:if>
        <c:if test="${not empty product.price.oneTimeChargeEntries}">
        	<c:if test="${not empty product.price.recurringChargeEntries}">
        		<br>
        	</c:if>
        	<c:forEach items="${product.price.oneTimeChargeEntries}" var="oneTimePrice" varStatus="oneTimePricesCounter">
        		<c:if test="${not oneTimePricesCounter.first}">
        			<br>
        		</c:if>
        		<spring:theme code="product.list.viewplans.price.onetime" arguments="${oneTimePrice.name}"/>
        		<format:price priceData="${oneTimePrice.price}"/>
        		<div class="pay">${oneTimePrice.billingTime.name}</div>
        	</c:forEach>
        </c:if>

	</div>
</div>


<div class="viewplan" data-row="4">
	<div class="header"><spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency"/></div>
	<div class="content">
		<c:if test="${product.subscriptionTerm.termOfServiceNumber gt 0}">${product.subscriptionTerm.termOfServiceNumber} &nbsp;</c:if>${product.subscriptionTerm.termOfServiceFrequency.name}
	</div>
</div>

<div class="viewplan" data-row="5">
	<div class="header"><spring:theme code="product.list.viewplans.termOfServiceRenewal" text="Term of service renewal"/></div>
	<div class="content">
		${product.subscriptionTerm.termOfServiceRenewal.name}
	</div>
</div>

<div class="viewplan" data-row="6">
	<div class="header"><spring:theme code="product.list.viewplans.entitlements" text="Entitlements"/></div>
	<div class="content">
        <c:if test="${not empty product.entitlements}">
        	<c:set var="old_entitlement_name" value="some_dummy_initial_value"/>
        	<c:forEach items="${product.entitlements}" var="entitlement">
        		<div>
        			<c:if test="${old_entitlement_name != entitlement.name}">
        				<b>${entitlement.name}</b><br>
        			</c:if>
        			<c:if test="${entitlement['class'].simpleName eq 'NonMeteredEntitlementData'}">
        				<spring:theme code="product.list.viewplans.entitlements.true" text="true"/>
        			</c:if>
        			<c:if test="${not empty entitlement.timeUnit}">
        				<c:if test="${not empty entitlement.timeUnitDuration}">
        					<spring:theme code="product.list.viewplans.entitlements.detailsWithDuration" arguments="${entitlement.timeUnit.code}^${entitlement.timeUnitStart}^${entitlement.timeUnitDuration}^${entitlement.timeUnit.code}" argumentSeparator="^"/>&nbsp;
        				</c:if>
        				<c:if test="${empty entitlement.timeUnitDuration}">
        					<spring:theme code="product.list.viewplans.entitlements.detailsWithoutDuration" arguments="${entitlement.timeUnit.code}^${entitlement.timeUnitStart}" argumentSeparator="^"/>&nbsp;
        				</c:if>
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
        		</div>
        		<c:set var="old_entitlement_name" value="${entitlement.name}"/>
        	</c:forEach>
        </c:if>		
	</div>
</div>


<div class="viewplan" data-row="7">
	<div class="header"><spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges"/></div>
	<div class="content">
        <c:if test="${not empty product.price and not empty product.price.usageCharges}">
        	<c:forEach items="${product.price.usageCharges}" var="usageCharge">
        	    <div>
        		    <b>${usageCharge.name}</b><br>
                    <c:if test="${not empty usageCharge.usageChargeEntries}">
                   		<c:set var="isFirstChargeEntry" value="true"/>
                        <c:forEach items="${usageCharge.usageChargeEntries}" var="usageChargeEntry">
                            <c:if test="${usageChargeEntry['class'].simpleName eq 'TierUsageChargeEntryData'}">
                            	<c:if test="${usageCharge['class'].simpleName eq 'PerUnitUsageChargeData'}">
                            		<c:if test="${isFirstChargeEntry}">
                                		<spring:theme code="product.list.viewplans.tierUsageChargeEntry" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}^${usageCharge.usageUnit.name}" argumentSeparator="^"/><br>
                                	</c:if>
                            		<c:if test="${not isFirstChargeEntry}">
                            			<c:if test="${usageCharge.usageChargeType.code eq 'each_respective_tier'}">
                                			<spring:theme code="product.list.viewplans.tierUsageChargeEntry" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}^${usageCharge.usageUnit.name}" argumentSeparator="^"/><br>
                                		</c:if>
                            			<c:if test="${usageCharge.usageChargeType.code eq 'highest_applicable_tier'}">
                                			<spring:theme code="product.list.viewplans.tierUsageChargeEntryHighestTier" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}^${usageCharge.usageUnit.name}" argumentSeparator="^"/><br>
                                		</c:if>
                                	</c:if>
                            	</c:if>
                            	<c:if test="${usageCharge['class'].simpleName eq 'VolumeUsageChargeData'}">
                            		<c:if test="${isFirstChargeEntry}">
                        				<spring:theme code="product.list.viewplans.volumeTierUsageChargeEntry" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}" argumentSeparator="^"/><br>
                        			</c:if>
                        			<c:if test="${not isFirstChargeEntry}">
                                		<spring:theme code="product.list.viewplans.volumeTierUsageChargeEntryNotFirstTier" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}" argumentSeparator="^"/><br>
                                	</c:if>
                            	</c:if>
                            </c:if>
                            <c:if test="${usageChargeEntry['class'].simpleName eq 'OverageUsageChargeEntryData' and fn:length(usageCharge.usageChargeEntries) gt 1}">
                    			<c:if test="${usageCharge['class'].simpleName eq 'PerUnitUsageChargeData' and usageCharge.usageChargeType.code eq 'each_respective_tier'}">
                    				<spring:theme code="product.list.viewplans.thereafterOverageUsageChargeEntry" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}"/>
                    			</c:if>                            	
                    			<c:if test="${usageCharge['class'].simpleName eq 'PerUnitUsageChargeData' and usageCharge.usageChargeType.code eq 'highest_applicable_tier'}">
                    				<spring:theme code="product.list.viewplans.thereafterOverageUsageChargeEntryHighestTier" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}"/>
                    			</c:if> 
                    			<c:if test="${usageCharge['class'].simpleName eq 'VolumeUsageChargeData'}">
                    				<spring:theme code="product.list.viewplans.thereafterOverageUsageChargeEntryVolume" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}"/>
                    			</c:if>  
                            </c:if>
                            <c:if test="${usageChargeEntry['class'].simpleName eq 'OverageUsageChargeEntryData' and fn:length(usageCharge.usageChargeEntries) eq 1}">
                             	<spring:theme code="product.list.viewplans.overageUsageChargeEntry" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}"/>
                            </c:if>
                            <c:set var="isFirstChargeEntry" value="false"/>
                        </c:forEach>
                    </c:if>
        	    </div>
        	    <br>
        	</c:forEach>
        </c:if>
	</div>
</div>

</form:form>
<c:url value="/sbgproducts/sbgaddtocart" var="sbgAddToCart"/>
<form:form id="addToCartForm" action="${sbgAddToCart}" method="post">
		<input type="hidden" name="productCodePost" value="${product.code}"/>
		<button type="submit" class="positive large addtocartbutton">
			<spring:theme code="basket.add.to.basket" />
		</button>
</form:form>
</ycommerce:testId>
