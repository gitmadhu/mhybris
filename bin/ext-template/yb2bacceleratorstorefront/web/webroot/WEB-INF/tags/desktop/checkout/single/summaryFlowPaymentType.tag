<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:url value="/_ui/desktop/common/images/spinner.gif" var="spinnerUrl" />
<spring:url value="/checkout/single/summary/setPaymentType.json" var="setPaymentTypeURL" />
<spring:url value="/checkout/single/summary/getCheckoutCart.json" var="getCheckoutCartUrl" />
<spring:url value="/checkout/single/summary/setPurchaseOrderNumber.json" var="setPurchaseOrderNumberURL" />


<div class="summaryPaymentType summarySection"  		
	data-set-payment-type-url="${setPaymentTypeURL}" 
	data-set-purchase-order-number-url="${setPurchaseOrderNumberURL}" >
	
	
	<ycommerce:testId code="paymentType_text">
		<div class="contentSection">
			<div class="content">
				<div class="headline"><span class="number">1</span><spring:theme code="checkout.summary.paymentType.header" htmlEscape="false"/></div>
				<div>
		            <c:forEach items="${paymentTypes}" var="paymentType">
		                <form:radiobutton path="paymentTypes" id="PaymentTypeSelection_${paymentType.code}" name="PaymentType" value="${paymentType.code}" label="${paymentType.displayName}"/><br>
		            </c:forEach>
		            <br>
					
					<label><spring:theme code="checkout.summary.purchaseOrderNumber"/></label>
					<br>
			
					<input type="text" id="PurchaseOrderNumber"  name="PurchaseOrderNumber" maxlength="255" />
				</div>
			</div>
		</div>
	</ycommerce:testId>
</div>