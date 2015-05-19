<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="payment-method-delete">
	<div class="headline">
	    <spring:theme code="text.account.paymentDetails.removePaymentMethod" text="Remove Payment Details"/>
	</div>

	<div class="payment-box">
		<div class="credit-card">${paymentInfo.cardTypeData.name}</div>
        <spring:theme code="text.account.paymentDetails.payment.details" arguments="${fn:replace(paymentInfo.cardNumber,'*','')}" text="cardNumber"/><br>
        <spring:theme code="text.expires" text="Expires"/>:&nbsp;${paymentInfo.expiryMonth}/${paymentInfo.expiryYear}
    </div>

	<div class="infoline">
        <spring:theme code="text.account.paymentDetails.removePaymentMethodQuestion"/>
	</div>
	<br/>

	<div class="actions">
		<button class="r_action_btn">
			<spring:theme code="text.cancel" text="Cancel"/>
		</button>
		
        <c:url value="/paymentDetails/remove-payment-method?paymentInfoId=${paymentInfo.id}" var="removePaymentMethodUrl" />
        <button type="button" onclick="window.location='${removePaymentMethodUrl}'" class="positive">
            <spring:theme code="text.account.paymentDetails.removePaymentDetailsConfirm" text="Remove Payment Details"/>
        </button>
	</div>
</div>
