<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscriptions" required="true" type="java.util.List" %>
<%@ attribute name="paymentInfo" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
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

<div id="payment-method-subscriptions">
	<div class="headline">
	    <spring:theme code="text.account.paymentDetails.editPaymentDetails" text="Edit Payment Details"/>
	</div>

	<div class="payment-box">
		<div class="credit-card">${paymentInfo.cardTypeData.name}</div>
    	<spring:theme code="text.account.paymentDetails.payment.details" arguments="${fn:replace(paymentInfo.cardNumber,'*','')}" text="cardNumber"/><br>
    	<spring:theme code="text.expires" text="Expires"/>:&nbsp;${paymentInfo.expiryMonth}/${paymentInfo.expiryYear}
    </div>
	<div class="infoline">
        <spring:theme code="text.account.paymentDetails.associatedSubscriptions" text="Edit Payment Details"/>
	</div>


		<table class="account-table">
			<thead>
				<tr>
					<th id="header1"><spring:theme code="text.account.subscription.productName" text="Product Name"/></th>
	                <th id="header2"><spring:theme code="text.account.subscription.startDate" text="Start Date"/></th>
	                <th id="header3"><spring:theme code="text.account.subscription.endDate" text="End Date"/></th>
	                <th id="header4"><spring:theme code="text.account.subscription.status" text="Status"/></th>
				</tr>
			</thead>
			<tbody>
            	<c:forEach items="${subscriptions}" var="subscription" varStatus="loop">
                    <tr>
                        <td>${subscription.name}</td>
                        <td class="background"><fmt:formatDate type="date" value="${subscription.startDate}"/></td>
                        <td><fmt:formatDate type="date" value="${subscription.endDate}"/></td>
                        <td class="background">${subscription.subscriptionStatus}</td>
                    </tr>
	            </c:forEach>
			</tbody>
		</table>

	<div class="actions">
		<button class="r_action_btn">
			<spring:theme code="text.cancel" text="Cancel"/>
		</button>

        <c:url value="/paymentDetails/edit-payment-details?paymentInfoId=${paymentInfo.id}&targetArea=accountArea" var="continueToEditPaymentDetailsUrl" />
        <button type="button" onclick="window.location='${continueToEditPaymentDetailsUrl}'" class="positive">
            <spring:theme code="text.editpaymentdetails" text="Edit Payment Details"/>
        </button>
	</div>
</div>
