<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	
		<div class="item_container_holder subscriptions">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.subscriptions" text="Subscriptions"/></h2>
			</div>
			<div class="item_container">
				<c:if test="${not empty subscriptions}">
					<p><spring:theme code="text.account.subscriptions.manageSubscriptions" text="Manage your subscriptions"/></p>

					<table id="subscriptions">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.account.subscriptions.productName" text="Product Name"/></th>
								<th id="header2"><spring:theme code="text.account.subscriptions.startDate" text="Start Date"/></th>
								<th id="header3"><spring:theme code="text.account.subscriptions.endDate" text="End Date"/></th>
								<th id="header4"><spring:theme code="text.account.subscriptions.status" text="Status"/></th>
								<th id="header5"><spring:theme code="text.account.subscriptions.paymentDetails" text="Payment Details"/></th>
								<th id="header6"><spring:theme code="text.account.orderHistory.actions" text="Actions"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${subscriptions}" var="subscription">

								<c:url value="/my-account/subscription/${subscription.id}" var="myAccountSubscriptionDetailsUrl"/>
								<c:url value="${subscription.productUrl}" var="productDetailsUrl"/>
								
								<tr>
									<td headers="header1">
										<ycommerce:testId code="subscriptions_productName_link">
											<p><a href="${productDetailsUrl}">${subscription.name}</a></p> 
										</ycommerce:testId>
									</td>
									<td headers="header2" class="background">
										<ycommerce:testId code="subscriptions_startDate_label">
											<p><fmt:formatDate value="${subscription.startDate}" dateStyle="long" timeStyle="short" type="date"/></p>
										</ycommerce:testId>
									</td>
									<td headers="header3">
										<ycommerce:testId code="subscriptions_endDate_label">
											<p><fmt:formatDate value="${subscription.endDate}" dateStyle="long" timeStyle="short" type="date"/></p>
										</ycommerce:testId>
									</td>
									<td headers="header4" class="background">
										<ycommerce:testId code="subscriptions_status_label">
											<p>${subscription.subscriptionStatus}</p>
										</ycommerce:testId>
									</td>
									<td headers="header5" >
											<ycommerce:testId code="subscriptions_status_label">
										 <c:if test= "${not empty paymentInfoMap[subscription.paymentMethodId]}">
										 	<c:set value="${paymentInfoMap[subscription.paymentMethodId]}" var="paymentMethod"></c:set>
										 	<p title="<spring:theme code="text.account.subscriptions.payment.details.title" arguments="${paymentMethod.cardTypeData.name},${fn:replace(paymentMethod.cardNumber,'****','**** ')},${paymentMethod.expiryMonth},${paymentMethod.expiryYear}" text=""/>"><spring:theme code="text.account.subscriptions.payment.details" arguments="${fn:substring(paymentMethod.cardTypeData.name,0,4)},${fn:replace(paymentMethod.cardNumber,'*','')},${paymentMethod.expiryMonth},${paymentMethod.expiryYear}" text=""/></p>
										 </c:if>
										 </ycommerce:testId>
									</td>
									<td headers="header6" class="background">
										<button type="button" onclick="window.location='${myAccountSubscriptionDetailsUrl}'" class="function_btn">
                                            <spring:theme code="text.manage" text="Manage"/>
                                        </button>
										<c:if test="${fn:toUpperCase(subscription.subscriptionStatus) ne 'PAUSED' and fn:toUpperCase(subscription.subscriptionStatus) ne 'CANCELLED' 
										and !empty subscriptionFacade.getUpsellingOptionsForSubscription(subscription.productCode)}">
                                        	<c:url value="/my-account/upgradeSubscriptionComparison?subscriptionId=${subscription.id}" var="upgradeSubscriptionComparisionUrl"/>
                                        		<button type="button" onclick="window.location='${upgradeSubscriptionComparisionUrl}'" class="positive">
                                            	<spring:theme code="text.account.subscription.upgradeSubscription" text="Upgrade Subscription"/>
                                        	</button>
                                        </c:if>
										<c:if test="${fn:toUpperCase(subscription.subscriptionStatus) eq 'PAUSED' and fn:toUpperCase(subscription.subscriptionStatus) ne 'CANCELLED'}">
											<c:url value="/my-account/changeSubscriptionState" var="changeSubscriptionStateUrl" />
											<form:form class="resume_subscription_form" id="resumeSubscriptionForm" action="${changeSubscriptionStateUrl}" method="post">
												<button type="submit" class="positive">
													<spring:theme code="text.account.subscription.resumeSubscription" text="Resume Subscription"/>
												</button>
												<input type="hidden" name="newState" value="ACTIVE"/>
												<input type="hidden" name="subscriptionId" value="${subscription.id}"/>
											</form:form>
                                        </c:if>
                                    
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

				</c:if>
				<c:if test="${empty subscriptions}">
					<p><spring:theme code="text.account.subscriptions.noSubscriptions" text="You have no subscriptions"/></p>
				</c:if>
			</div>
		</div>
	</div>
</template:page> 