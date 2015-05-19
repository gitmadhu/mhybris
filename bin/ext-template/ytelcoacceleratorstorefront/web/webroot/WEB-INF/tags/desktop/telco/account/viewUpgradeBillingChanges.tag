<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="upgradePreviewData" required="true" type="java.util.List" %>
<%@ attribute name="tabId" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/desktop/telco/guidedselling" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/telco/product" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="upgrade-billing-changes">
	<div class="headline">
		<spring:theme code="text.account.upgrade.proposedBillingChanges" text="Proposed Billing Changes"/>
	</div>


	<div class="change-compare clearfix">
		<div class="change-box">
			<div class="title"><spring:theme code="text.account.upgrade.currentPlan" text="Proposed Billing Changes"/></div>
		    <div class="plan">${subProdData.name}</div>
			<div class="term">${subProdData.subscriptionTerm.name}</div>
		</div>

		<div class="change-box right">
			<div class="title"><spring:theme code="text.account.upgrade.upgradePlan" text="Proposed Billing Changes"/></div>
		    <div class="plan">${upgradeData.name}</div>
			<div class="term">${upgradeData.subscriptionTerm.name}</div>
		</div>
		
	</div>






	<c:forEach items="${upgradePreviewData}" var="upgradePreview" varStatus="loop">
		<table class="upgrade-preview-table">
			<thead>
				<tr>
					<td><spring:theme code="text.account.upgrade.billingPeriod" text="Billing Period"/></td>
					<td>${upgradePreview.billingPeriod}</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><spring:theme code="text.account.upgrade.paymentAmount" text="Payment Amount"/></td>
					<td>${upgradePreview.paymentAmount}</td>
				</tr>
				<tr>
					<td><spring:theme code="text.account.upgrade.billingDate" text="Billing Date"/></td>
					<td>${upgradePreview.billingDate}</td>
				</tr>
			</tbody>
		</table>
	</c:forEach>




	<div class="actions">	
		<button class="r_action_btn">
			<spring:theme code="text.cancel" text="Cancel"/>
		</button>
		
		<c:url value="/my-account/upgradesubscription" var="upgradeSubscription" />
		<form:form class="upgrade_subscription_form" action="${upgradeSubscription}" method="post">
			<button  type="submit"  class="confirm positive">
				<spring:theme code="text.account.subscription.upgradeSubscriptionNow" text="Upgrade Now"/>
			</button>

			<input type="hidden" name="productCode" value="${upgradeData.code}"/>
			<input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
			<input type="hidden" name="originalOrderCode" value="${subscriptionData.orderNumber}"/>
			<input type="hidden" name="originalEntryNumber" value="${subscriptionData.orderEntryNumber}"/>
		</form:form>
	</div>
</div>
