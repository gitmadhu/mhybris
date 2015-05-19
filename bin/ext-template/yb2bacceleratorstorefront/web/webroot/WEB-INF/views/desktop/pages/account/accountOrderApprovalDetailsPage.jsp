<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<spring:url value="/my-account/order/approvalDecision"
            var="orderApprovalDecisionURL"/>


<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="approval-dashboard"/>

	<form:form method="post" id="approvalDecisionForm" commandName="orderApprovalDecisionForm" action="${orderApprovalDecisionURL}">
	
		<div class="column accountContentPane clearfix orderList approval-dashboard">
		
			<order:orderApprovalStatusDetailsItem orderApprovalData="${orderApprovalData}"/>
			
			<c:if test="${orderApprovalData.b2bOrderData.triggerData ne null}">
				<order:replenishmentScheduleInformation order="${orderApprovalData.b2bOrderData}"/>
			</c:if>
			
			<div class="span-19 delivery_stages">
				<order:orderDetailsItem order="${orderApprovalData.b2bOrderData}" isOrderDetailsPage="true"/>
			</div>
			
			<div class="span-19">
				<div class="span-9">
					<order:receivedPromotions order="${orderApprovalData.b2bOrderData}"/>
				</div>
				
				<div class="span-9 right last">
					<order:orderTotalsItem order="${orderApprovalData.b2bOrderData}"/>
				</div>
			</div>
			
			<div class="span-19">
				<order:orderHistoryEntriesDetailsItem orderHistoryEntries="${orderApprovalData.quotesApprovalHistoryEntriesData}" itemHolderTitleKey="text.account.orderHistoryEntry.QuoteTitle" isQuoteNegotiation="true"/>
			</div>
			
			<div class="span-19 delivery_stages">
				<order:orderHistoryEntriesDetailsItem orderHistoryEntries="${orderApprovalData.orderHistoryEntriesData}" itemHolderTitleKey="text.account.orderHistoryEntry.customerTitle"/>
			</div>
			
			<c:choose>
				<c:when test="${orderApprovalData.approvalDecisionRequired}">
					<div class="span-19">
						<form:input type="hidden" name="workflowActionCode" path="workFlowActionCode" value="${orderApprovalData.workflowActionModelCode}"/>
						<form:input type="hidden" name="approverSelectedDecision" path="approverSelectedDecision" id="approverSelectedDecision"/>
						<button class="approverDecisionButton positive left pad_right" type="button" id="approverDecisionApprove" data-decision="APPROVE">
							<spring:theme code="text.account.orderApproval.approveButton.displayName"/>
						</button>
						<button class="approverDecisionButton positive right pad_right" type="button" id="approverDecisionReject" data-decision="REJECT">
							<spring:theme code="text.account.orderApproval.rejectButton.displayName"/>
						</button>
					</div>
					<div class="span-19 delivery_stages">
						<div class="headline">
							<spring:theme code="text.account.orderApprovalDetails.comments.label" text="Comments"/>
						</div>

							<div class="item_container">
								<div class="your_cart">
									<form:input cssClass="textarea" path="comments" cssStyle="width:290px;height:30px;"/>
								</div>
							</div>
						</div>
				</c:when>
			</c:choose>

			<div class="span-19">
				<order:orderHistoryEntriesDetailsItem orderHistoryEntries="${orderApprovalData.merchantApprovalHistoryEntriesData}" itemHolderTitleKey="text.account.orderHistoryEntry.merchantTitle"/>
			</div>
			
	</div>
		

	</form:form>
</template:page>
