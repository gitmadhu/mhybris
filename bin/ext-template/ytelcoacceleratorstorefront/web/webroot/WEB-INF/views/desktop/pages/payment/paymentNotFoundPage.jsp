<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>

<script type="text/javascript">

$("div").removeClass("span-24");

$(document).bind('cbox_closed', function(){
	  location.reload();
});
</script>

<div id="payment-method-delete">
	<div class="headline">
	    <spring:theme code="text.account.paymentDetails.removePaymentMethod" text="Remove Payment Details"/>
	</div>
	<br/>

	<div id="globalMessages">
		<common:globalMessages />
	</div>
</div>
