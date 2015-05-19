<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/telco/product" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="subscriptions" />
	<div class="span-20 last">
		<div class="span-20 wide-content-slot advert">
			<cms:slot var="feature" contentSlot="${slots['TopContent']}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
	
		<c:url value="${subscriptionData.productUrl}" var="productDetailsUrl"/>
		<c:url value="/my-account/order/${subscriptionData.orderNumber}" var="orderDetailsUrl"/>		
		
		<div class="item_container_holder subscription_details">

			<div class="item_container">

				<div id="plan_name" class="left">
					<ycommerce:testId code="subscription_productName_link">
						<a href="${productDetailsUrl}"><h2>${subscriptionData.name}</h2></a>
					</ycommerce:testId>
				</div>
				

				<c:if test="${fn:toUpperCase(subscriptionData.subscriptionStatus) ne 'CANCELLED' and upgradable}">
					<c:url value="/my-account/upgradeSubscriptionComparison?subscriptionId=${subscriptionData.id}" var="upgradeSubscriptionComparisionUrl"/>
					<button type="button" onclick="window.location='${upgradeSubscriptionComparisionUrl}'" class="positive right p_action_btn"><spring:theme code="text.account.subscription.upgradeSubscriptionDetail" text="Upgrade Options"/></button>
				</c:if>
				
				<div class="plan_summary left">
					<ycommerce:testId code="subscription_description_label">
						${subscriptionData.description}
					</ycommerce:testId>
				</div>

  				<table>
					<tr>
						<td class="subscription_content_area">
						<table  id="subscription_details">
							<tr>
								<td class="subscription_detail_area_head">	
									<spring:theme code="text.account.subscription.detail" text="Subscription Detail"/>
								</td>
							</tr>					
							<tr>
								<td class="first_row">
									<span><spring:theme code="text.account.subscription.billingFrequency" text="Billing Frequency"/>:</span>			
									<ycommerce:testId code="subscription_billingFrequency_label">
										${subscriptionData.billingFrequency}
									</ycommerce:testId>
								</td>
							</tr>
							<tr>
								<td>
									<span><spring:theme code="product.list.viewplans.price" text="Price"/>:</span>
									<span class="bold_text"><product:subscriptionPricesLister subscriptionData="${subscriptionProductData}"/></span>						
								</td>
							</tr>
							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.contractDuration" text="Contract Duration"/>:</span>
									<ycommerce:testId code="subscription_contractDuration_label">
										${subscriptionData.contractDuration}&nbsp;${subscriptionData.contractFrequency}
									</ycommerce:testId>
								</td>
							</tr>

							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.Cancellable" text="Cancellable"/>:</span>
									<ycommerce:testId code="subscription_status_label">
										<c:choose>
											<c:when test="${subscriptionData.cancellable}">
												<spring:theme code="text.account.subscription.cancellable.yes"/>
											</c:when>
											<c:otherwise>
												<spring:theme code="text.account.subscription.cancellable.no"/>
											</c:otherwise>
										</c:choose>
									</ycommerce:testId>
								</td>
								
							</tr>
							<tr>
								<td>
									<span><spring:theme code="product.list.viewplans.entitlements" text="Included"/>:</span>
									<span><product:entitlementLister subscriptionData="${subscriptionProductData}"/></span>
								</td>
							</tr>
							<tr>
								<td>
									<span><spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges"/>:</span>
									<span><product:usageChargesLister subscriptionData="${subscriptionProductData}"/></span>
								</td>
							</tr>
						</table>
					</td>
					<td class="subscription_content_area">
						<table id="subscription_manage">
							<tr>
								<td class="subscription_detail_area_head">	
									<spring:theme code="text.account.subscription.manageSubscription" text="Manage This Subscription"/>
								</td>							
							</tr>					
							<c:if test="${fn:toUpperCase(subscriptionData.subscriptionStatus) ne 'CANCELLED' }">
							<tr>
								<td class="first_row h_45">
								<span>
									<c:url value="/my-account/changeSubscriptionState" var="changeSubscriptionStateUrl" />
									<c:if test="${fn:toUpperCase(subscriptionData.subscriptionStatus) eq 'PAUSED'}">
										<form:form class="resume_subscription_form" id="resumeSubscriptionForm" action="${changeSubscriptionStateUrl}" method="post">
											<button type="submit" class="r_function_btn left">
												<spring:theme code="text.account.subscription.resumeSubscription" text="Resume Subscription"/>
											</button>
											<input type="hidden" name="newState" value="ACTIVE"/>
											<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
										</form:form>
									</c:if>

									<c:if test="${fn:toUpperCase(subscriptionData.subscriptionStatus) eq 'ACTIVE'}">
									<form:form class="pause_subscription_form" id="pauseSubscriptionForm" action="${changeSubscriptionStateUrl}" method="post">
										<button type="submit" class="r_function_btn left">
											<spring:theme code="text.account.subscription.pauseSubscription" text="Pause Subscription"/>
										</button>
										<input type="hidden" name="newState" value="PAUSED"/>
										<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
									</form:form>	
									</c:if>

								</span>
								<div>	
									<c:if test="${subscriptionData.cancellable}">
									<c:url value="/my-account/cancelsubscription/${subscriptionData.id}" var="cancelUrl"/>
										<button type="button" data-url="${cancelUrl}" class="function_btn js-cancel-subscription left"><spring:theme code="text.account.subscription.cancelSubscription" text="Cancel"/></button>
										<div style="display: none;">
											<div id="cancel-subscription-confirm" >
												<div class="title"><spring:theme code="text.account.subscription.confirm.cancellation" text="Confirm Cancellationa"/></div>
												<p><spring:theme code="text.account.subscription.cancellation.message" text="Are you sure you would like to cancel this subscriptiona"/></p>
												<div class="actions">
													<button type="button" class="r_action_btn"><spring:theme code="text.account.subscription.cancellable.no" text="Noa"/></button>
													<button type="button" onclick="window.location='${cancelUrl}'" class="confirm positive"><spring:theme code="text.account.subscription.cancellable.yes" text="Yes"/></button>
												</div>
											</div>
										</div>
									</c:if>
								</div>														
								</td>
							</tr>
							</c:if>
							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.status" text="Status"/>:</span>
									<ycommerce:testId code="subscription_status_label">
										${subscriptionData.subscriptionStatus}
									</ycommerce:testId>
								</td>
							</tr>
							<c:if test="${fn:toUpperCase(subscriptionData.subscriptionStatus) ne 'CANCELLED' }">
							<tr>
								<td>
									<span>
										<c:url value="/my-account/setAutorenewalStatus" var="setAutorenewStatusUrl" />
										<c:if test="${!subscriptionData.renewalType}">
											<form:form class="activate_autorenewal_form" id="activateAutorenewalForm" action="${setAutorenewStatusUrl}" method="post">
												<button type="submit" class="r_function_btn left">
													<spring:theme code="text.account.subscription.activateAutorenew" text="Activate Auto-Renew"/>
												</button>
												<input type="hidden" name="autorenew" value="true"/>
												<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
											</form:form>
										</c:if>
										<c:if test="${subscriptionData.renewalType}">
											<form:form class="deactivate_autorenewal_form" id="deactivateAutorenewalForm" action="${setAutorenewStatusUrl}" method="post">
												<button type="submit" class="r_function_btn left">
													<spring:theme code="text.account.subscription.deactivateAutorenew" text="Deactivate Auto-Renew"/>
												</button>
												<input type="hidden" name="autorenew" value="false"/>
												<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
											</form:form>
										</c:if>
									</span>					
								</td>
							</tr>

							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.renewalType" text="Renewal Type"/>:</span>
							
									<ycommerce:testId code="subscription_renewalType_label">
										${subscriptionData.renewalType}
									</ycommerce:testId>
								</td>
							</tr>

							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.endDate" text="End Date"/>:</span>
							
									<ycommerce:testId code="subscription_endDate_label">
										<fmt:formatDate value="${subscriptionData.endDate}" dateStyle="long" timeStyle="short" type="both"/>
									</ycommerce:testId>
								</td>
							</tr>
							<tr>
								<td>
                                    <c:url value="/my-account/extendSubscriptionTermDuration" var="extendSubscriptionTermDuration" />
                                    <form:form class="extend_subscription_form" id="extendSubscriptionForm" action="${extendSubscriptionTermDuration}" method="post">
                                        <span>
	                                        <select id="contractDurationExtensionOptions" name="contractDurationExtension" >                             
	                                        	<c:forEach items="${extensionOptions}" var="extensionOption" varStatus="extensionOptionCounter">
	                                            	<option value="${extensionOption.code}">${extensionOption.name}</option>
	                                            </c:forEach>
	                                        </select>
	                                     </span>
                                    
                                        <button type="submit" class="function_btn left">
                                            <spring:theme code="text.account.subscription.updateTermDuration"/>
                                        </button>
                                        <input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
                                    </form:form>
								</td>
							</tr>
							<tr>
								<td>
									<c:url value="/my-account/replaceSubscriptionPaymentMethod" var="replaceSubscriptionPaymentMethodUrl" />
									<form:form class="update_paymentmethod_form" id="updatePaymentmethodForm" action="${replaceSubscriptionPaymentMethodUrl}" method="post">
										<span>
											<select name="paymentMethodId" id="paymentMethods" <c:if test="${fn:length(paymentInfos) lt 2}">disabled</c:if>>
												<c:forEach items="${paymentInfos}" var="paymentInfo">
													<option value="${paymentInfo.subscriptionId}" <c:if test="${paymentInfo.subscriptionId eq subscriptionData.paymentMethodId}">selected</c:if>><spring:theme code="text.account.subscription.paymentMethod" arguments="${paymentInfo.cardTypeData.name},${fn:replace(paymentInfo.cardNumber,'****','**** ')},${paymentInfo.expiryMonth},${paymentInfo.expiryYear}"/></option>
												</c:forEach>
											</select>
										</span>
										<button type="submit" class="function_btn left" <c:if test="${fn:length(paymentInfos) lt 2}">disabled</c:if>>
											<spring:theme code="text.account.subscription.updatePaymentMethod" text="Update"/>
										</button>
										<input type="hidden" name="effectiveFrom" value="NOW"/>
										<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
									</form:form>								
								</td>
							</tr>
							</c:if>
						</table>
						<table id="subscription_activity">						
							<tr>
								<td class="subscription_detail_area_head">	
									<span class="activity"><spring:theme code="text.account.subscription.activity" text="Actitiy"/></span>
		
									<span class="order_number"><spring:theme code="text.account.subscription.orderNumber" text="Order Number"/>:</span>
									<span class="order_number"><ycommerce:testId code="subscription_orderNumber_link">
										<a href="${orderDetailsUrl}">${subscriptionData.orderNumber}</a>
									</ycommerce:testId>
									</span>														
								</td>							
							</tr>									
							<tr>
								<td>
									<c:url value="/my-account/subscriptionBillingActivity" var="subscriptionBillingActivityUrl" />
									<form:form class="view_billing_activity_form" id="viewBillingActivityForm" action="${subscriptionBillingActivityUrl}" method="get">
										<button type="submit" class="function_btn left">
											<spring:theme code="text.account.subscription.viewBillingActivity" text="View Billing Activity"/>
										</button>
										<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
									</form:form>
								</td>
							</tr>
							<tr>
								<td>
									<c:if test="${fn:toUpperCase(subscriptionData.subscriptionStatus) eq 'CANCELLED'}">
										<span><spring:theme code="text.account.subscription.cancelledDate" text="Cancelled Date"/>:</span>
										<ycommerce:testId code="subscription_cancelledDate_label">
											<fmt:formatDate value="${subscriptionData.cancelledDate}" dateStyle="long" timeStyle="short" type="both"/>
										</ycommerce:testId>
									</c:if>
								</td>
							</tr>
							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.startDate" text="Start Date"/>:</span>
								
									<ycommerce:testId code="subscription_startDate_label">
										<fmt:formatDate value="${subscriptionData.startDate}" dateStyle="long" timeStyle="short" type="both"/>
									</ycommerce:testId>
								</td>
							</tr>
							<tr>
								<td>
									<span><spring:theme code="text.account.subscription.placedOn" text="Placed On"/>:</span>
									<ycommerce:testId code="subscription_placedOn_label">
										<fmt:formatDate value="${subscriptionData.placedOn}" dateStyle="long" timeStyle="short" type="both"/>
									</ycommerce:testId>
								</td>	
							</tr>
							</table>
						</table>					
					</td>
					</tr>
				</table>

				<c:url value="/my-account/subscriptions" var="backToSubscriptions"/>
				<button type="button" onclick="window.location='${backToSubscriptions}'" class="r_action_btn left"><spring:theme code="text.account.subscription.returntosubscriptions" text="Return To Subscriptions"/></button>
			</div>
		</div>
	</div>
</template:page>
