<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="orderData" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData"%>
<%@ attribute name="orderHistoryEntries" required="true" type="java.util.List"%>
<%@ attribute name="quoteOrderForm" required="true" type="de.hybris.platform.yb2bacceleratorstorefront.forms.QuoteOrderForm"%>
<%@ attribute name="isOrderDetailsPage" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%--
	~ /*
	~  * [y] hybris Platform
	~  *
	~  * Copyright (c) 2000-2011 hybris AG
	~  * All rights reserved.
	~  *
	~  * This software is the confidential and proprietary information of hybris
	~  * ("Confidential Information"). You shall not disclose such Confidential
	~  * Information and shall use it only in accordance with the terms of the
	~  * license agreement you entered into with hybris.
	~  *
	~  */
--%>

<spring:url value="/my-account/quote/quoteOrderDecision"
	var="quoteOrderDecisionURL" />

<script type="text/javascript"> // set vars
	var quoteActive=true;
	var negotiateQuote = ${quoteOrderForm.negotiateQuote};
</script>

<form:form method="post" id="quoteOrderDecisionForm" commandName="quoteOrderDecisionForm" action="${quoteOrderDecisionURL}">
	
	<div class="headline">
		<spring:theme code="text.quotes.orderStatusDetails.label" text="Order Status Details" />
	</div>

		<div class="span-19">
			
			<div class="span-7 table-budget-container">
				<table class="table_budget">
					<tr>
						<td><spring:theme code="text.account.orderApprovalDetails.OrderNumber" text="Order number" />:</td>
						<td>${orderData.code}</td>
					</tr>
					<tr>
						<td><spring:theme code="text.account.orderApprovalDetails.orderPlacedBy" text="Order placed by" />:</td>
						<td>${orderData.b2bCustomerData.name}</td>
					</tr>
					<tr>
						<td><spring:theme code="text.account.orderApprovalDetails.paidOntoAccount" text="Paid onto account" />:</td>
						<c:if test="${orderData.paymentType.code eq 'CARD'}">
							<td>${orderData.paymentInfo.cardNumber}</td>
						</c:if>
						<c:if test="${orderData.paymentType.code eq 'ACCOUNT'}">
							<td>${orderData.costCenter.code}</td>
						</c:if>
					</tr>
					<tr>
						<td><spring:theme code="text.account.orderApprovalDetails.purchaseOrderNumber" text="P.O.No" />:</td>
						<td>${orderData.purchaseOrderNumber}</td>
					</tr>
					<tr>
						<td><spring:theme code="text.account.orderApprovalDetails.parentBusinessUnit" text="Parent Business Unit" />:</td>
						<td>${orderData.costCenter.unit.uid}</td>
					</tr>
					<c:if test="${orderData.paymentType.code eq 'ACCOUNT'}">
						<tr>
							<td><spring:theme code="text.account.orderApprovalDetails.costCenter" text="Cost Center" /></td>
							<td>${orderData.costCenter.code}</td>
						</tr>
					</c:if>
					<tr>
						<td><spring:theme code="text.account.orderApproval.orderStatus" text="Order Status"/></td>
						<td><spring:theme code="text.account.order.status.display.${orderData.statusDisplay}"/></td>
					</tr>
				</table>
			</div> <!-- /table-budget-container -->

			<div class="span-11 last quote-actions right">
				<form:input type="hidden" name="orderCode" path="orderCode" value="${orderData.code}" />
				<form:input type="hidden" name="selectedQuoteDecision" path="selectedQuoteDecision" id="selectedQuoteDecision" />

				<c:if test="${orderData.status=='PENDING_QUOTE'}">
					<button class="positive pad_right" name="ADDADDITIONALCOMMENT" id="addAdditionalComment">
						<spring:theme code="text.quotes.addAdditionalComment.displayName" text="Add Comment" />
					</button>
				</c:if>
				<c:if test="${orderData.status=='APPROVED_QUOTE' || orderData.status=='REJECTED_QUOTE' || orderData.status=='PENDING_QUOTE'}">
					<button class="positive pad_right" name="CANCELQUOTE" id="cancelQuoteButton">
						<spring:theme code="text.quotes.cancelQuoteButton.displayName" text="Cancel Quote" />
					</button>
				</c:if>
				<c:if test="${orderData.status eq 'APPROVED_QUOTE'}">
					<button class="positive pad_right" name="ACCEPTQUOTE" id="acceptQuoteButton" onClick="ACC.quote.submitQuoteDecision('ACCEPTQUOTE');return false;">
						<spring:theme code="text.quotes.acceptQuoteButton.displayName" text="Accept Quote" />
					</button>
				</c:if>
				<c:if test="${orderData.status=='APPROVED_QUOTE' || orderData.status=='REJECTED_QUOTE'}">
					<button class="positive pad_right" name="NEGOTIATEQUOTE" id="negotiateQuoteButton">
						<spring:theme code="text.quotes.negotiateQuoteButton.displayName" text="Re-Quote" />
					</button>
				</c:if>

			</div> <!-- /quote-actions -->
			
		</div>
			
		<div class="span-19 negotiate-quote" id="negotiate-quote-div" style="display:none">
			<div class="headline">
				<div id="negotiate-quote-div-label-add-comment" style="display:none">
					<spring:theme code="checkout.summary.negotiateQuote.quoteReason" />
				</div>
				<div id="negotiate-quote-div-label-cancel" style="display:none">
					<spring:theme code="checkout.summary.negotiateQuote.quotecancelreason" />
				</div>
			</div>
			<div class="span-7">
				<div class="your_cart control-group">
					<span class="controls">
						<c:if test="${quoteOrderForm.negotiateQuote}" >
							<span class="form_field_error">
						</c:if>
						<form:input cssClass="text" id="comments" path="comments" />
					</span>
				</div>
			</div>
			<div class="span-7 last right">
				<form:input type="hidden" name="negotiateQuote" class="negotiateQuoteClass" path="negotiateQuote"/>
				<button class="positive right pad_right negotiateQuote" id="proceedButton">
					<spring:theme code="checkout.summary.negotiateQuote.proceed" />
				</button>
				<button class="positive right pad_right cancel" id="cancelComment">
					<spring:theme code="checkout.summary.negotiateQuote.cancel" />
				</button>
			</div>
		</div> <!-- /negotiate-quote-div -->
			
		<div class="span-19 quote-metadata">
			<table class="orderListTable">
				<thead>
					<tr>
						<th id="header1"><spring:theme code="text.quote.orderHistoryEntry.date" text="Date" /></th>
						<th id="header2"><spring:theme code="text.quote.orderHistoryEntry.status" text="Status" /></th>
						<th id="header3"><spring:theme code="text.quote.orderHistoryEntry.user" text="User" /></th>
						<th id="header4"><spring:theme code="text.quote.orderHistoryEntry.price" text="Cart Total" /></th>
						<th id="header5"><spring:theme code="text.quote.orderHistoryEntry.comment" text="Comment" /></th>
						<th id="header6"><spring:theme code="text.quote.orderHistoryEntry.quoteExpirationDate" text="Quote Expiration Date" /></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderHistoryEntries}" var="orderHistoryEntryData">
						<tr>
							<td headers="1">${orderHistoryEntryData.timeStamp}</td>
							<td headers="2"><spring:theme code="text.account.order.status.display.${orderHistoryEntryData.previousOrderVersionData.statusDisplay}"/></td>
							<td headers="3">${orderHistoryEntryData.ownerData.name}</td>
							<td headers="4">${orderHistoryEntryData.previousOrderVersionData.totalPrice.formattedValue}</td>
							<td headers="5">${orderHistoryEntryData.previousOrderVersionData.b2BComment.comment}</td>
							<td headers="6">${orderHistoryEntryData.previousOrderVersionData.quoteExpirationDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>  <!-- /quote-metadata -->

	<div class="span-19 quote-comments">
		<div class="headline">
			<spring:theme code="text.quotes.comments.label"	text="Quotes Comments Details" />
		</div>
		<table class="orderListTable">
			<thead>
				<tr>
					<th id="header1" width="1px"><spring:theme code="text.quote.orderHistoryEntry.date" text="Date" /></th>
					<th id="header2" width="1px"><spring:theme code="text.quote.orderHistoryEntry.user" text="User" /></th>
					<th id="header3" width="5px"><spring:theme code="text.quote.orderHistoryEntry.comment" text="Comment" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderData.b2bCommentData}" var="b2bComments">
					<tr>
						<td headers="1">${b2bComments.timeStamp}</td>
						<td headers="2">${b2bComments.ownerData.name}</td>
						<td headers="3">${b2bComments.comment}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div> <!-- /quote-comments -->

</form:form>