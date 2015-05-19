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
		
		<div class="item_container_holder subscription_billing_activity">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.subscription.billingActiviy" text="Billing Activity"/></h2>
			</div>
			<div class="item_container">

				<div id="plan_name" class="left">
					<ycommerce:testId code="subscription_productName_link">
						<h2>${subscriptionData.name}</h2>
					</ycommerce:testId>
				</div>
					
				<div class="plan_summary left">
					<p>
						<ycommerce:testId code="subscription_description_label">
							${subscriptionData.description}
						</ycommerce:testId>
					</p>
				</div>
				

  				<c:if test="${not empty billingActivities}">
					<table id="billingActivities">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.account.subscription.billingActivity.billingPeriod" text="Billing Period"/></th>
								<th id="header2"><spring:theme code="text.account.subscription.billingActivity.billingDate" text="Billing Date"/></th>
								<th id="header3"><spring:theme code="text.account.subscription.billingActivity.paymentAmount" text="Payment Amount"/></th>
								<th id="header4"><spring:theme code="text.account.subscription.billingActivity.paymentStatus" text="Payment Status"/></th>
								<th id="header5"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${billingActivities}" var="billingActivity">

								<c:url value="/my-account/downloadSubscriptionBillingActivityDetail" var="billingActivityDetailUrl"/>
								
								<tr>
									<td headers="header1">
										<ycommerce:testId code="subscription_billing_activity_billingPeriod">
											<p>${billingActivity.billingPeriod}</p> 
										</ycommerce:testId>
									</td>
									<td headers="header2">
										<ycommerce:testId code="subscription_billing_activity_billingDate">
											<p>${billingActivity.billingDate}</p> 
										</ycommerce:testId>
									</td>
									<td headers="header3">
										<ycommerce:testId code="subscription_billing_activity_paymentAmount">
											<p>${billingActivity.paymentAmount}</p> 
										</ycommerce:testId>
									</td>
									<td headers="header4">
										<ycommerce:testId code="subscription_billing_activity_paymentStatus">
											<p>${billingActivity.paymentStatus}</p> 
										</ycommerce:testId>
									<td headers="header5">
										<c:url value="/my-account/downloadSubscriptionBillingActivityDetail" var="downloadBillingActivityDetailUrl" />
										<form:form class="resume_subscription_form" id="resumeSubscriptionForm" action="${downloadBillingActivityDetailUrl}" method="get">
											<c:if test="${billingActivity.paymentStatus == 'Paid'}">
                                                <button type="submit" class="function_btn left">
                                                    <spring:theme code="text.account.subscription.billingActivity.download" text="Download"/>
                                                </button>
                                                <input type="hidden" name="billingActivityId" value="${billingActivity.billingId}"/>
											</c:if>
										</form:form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

				</c:if>
				<c:if test="${empty billingActivities}">
					<p><spring:theme code="text.account.subscriptions.noSubscriptions" text="You have no subscriptions"/></p>
				</c:if>
				
				<br><br>
				<c:url value="/my-account/subscription/${subscriptionData.id}" var="backToSubscriptionDetails"/>
				<button type="submit" onclick="window.location='${backToSubscriptionDetails}'" class="r_action_btn left"><spring:theme code="text.account.subscription.returnToSubscriptionDetails" text="Return To Subscription Details"/></button>
			</div>
		</div>
		
	</div>
</template:page>