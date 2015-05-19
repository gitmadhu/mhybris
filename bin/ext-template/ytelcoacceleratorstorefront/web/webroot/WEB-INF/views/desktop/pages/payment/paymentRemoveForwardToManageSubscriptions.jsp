<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>

<script type="text/javascript">

$("div").removeClass("span-24");

</script>
<div id="payment-method-delete">
	<div class="headline">
	    <spring:theme code="text.account.paymentDetails.removePaymentMethod" text="Remove Payment Details"/>
	</div>
	
    <div id="globalMessages">
        <common:globalMessages/>
    </div>
    
    <div class="payment-box">
        <div class="credit-card">${paymentInfo.cardTypeData.name}</div>
        <spring:theme code="text.account.paymentDetails.payment.details" arguments="${fn:replace(paymentInfo.cardNumber,'*','')}" text="cardNumber"/><br>
        <spring:theme code="text.expires" text="Expires"/>:&nbsp;${paymentInfo.expiryMonth}/${paymentInfo.expiryYear}
    </div>
    
    <div class="account-box">  
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
                        <td headers="header1">${subscription.name}</td>
                        <td headers="header2" class="background"><fmt:formatDate type="date" value="${subscription.startDate}"/></td>
                        <td headers="header3"><fmt:formatDate type="date" value="${subscription.endDate}"/></td>
                        <td headers="header4" class="background">${subscription.subscriptionStatus}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    	<div class="actions">
            <button class="r_action_btn cancel">
    			<spring:theme code="text.no" text="Cancel"/>
    		</button>
    		
            <c:url value="/my-account/manage-payment-method?paymentInfoId=${paymentInfo.id}" var="paymentMethodSubscriptionsUrl"/>
            <button type="button" onclick="window.location='${paymentMethodSubscriptionsUrl}'" class="positive ">
                <spring:theme code="text.account.paymentDetails.manageSubscriptions" text="Manage Subscriptions"/>
            </button>
    	</div>
    </div>
</div>