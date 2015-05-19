<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<template:page pageTitle="${pageTitle}">

<script type="text/javascript">
	
	$(document).ready(function() {
		
		  $('#selectall').prop('checked', true);
	
		  
	  $('#selectall').click(function(event) {  //on click for the selectall checkbox
	
	  	 $('input:checkbox').not(this).prop('checked', this.checked);
	  
	  });
	  
	  $('input:checkbox').click(function(event) {  //on click for any checkbox other than the selectall checkbox
	
	  	if( $('#selectall').prop("checked") && $(this).prop("checked")==false)
	  	{
	  		 $('#selectall').prop('checked', false);
	  	}
	  
	  if($('input:checkbox').not($('#selectall')).not(':checked').length == 0)
	  	{
	  	 $('#selectall').prop('checked', true);
	  	}
	 
	 });
	  
	});

	$(document).on("click", "#editWithSubscriptions", function(){
        $self=$(this);
        
        if($self.val()=='edit')
        	{
        		  window.location.href=$self.data("url");
        	}
        else
        	{
		        $.colorbox({
		            href:$self.data("url"),
		            width:"600px",
		            height:false,
		            onComplete: function(){
		                $.colorbox.resize();
		            }
		        })
        	}
    })

    $(document).on("click", "#payment-method-subscriptions .r_action_btn", function(){
        $.colorbox.close();
    })

    $(document).on("click", "#removeWithSubscriptions", function(){
        $self=$(this);
        $.colorbox({
          href:$self.data("url"),
          width:false,
          height:false,
          onComplete: function(){
              $.colorbox.resize();
          }
        })
    })

    function switchChangeButton()
    {
        var button = document.getElementById("buttonChangeTo");
        var pm = document.getElementById("id_changeToPM").value;
        if(pm == "") {
            button.disabled = true;
        } else {
            button.disabled = false;
        }
    }  
    $(document).on("click", "#payment-method-delete .r_action_btn", function(){
        $.colorbox.close();
    })
</script>

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}" />
	</div>
	<div id="globalMessages">
		<common:globalMessages />
	</div>
	<nav:accountNav selected="payment-details" />
	<div class="span-20 last cust_acc-page">
		<div class="item_container_holder paymentDetails manageSubscriptions">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>

                <h2><spring:theme code="text.account.paymentDetails.manageSubscriptions" text="Manage Associated Subscriptions"/></h2>
			</div>
			
			<div class="item_container">
			    <p class="infoline">
			        <spring:theme code="text.account.paymentDetails.manageAssociatedSubscriptions"/>
			    </p>

			    <table class="account">
			    	<colgroup>
					    <col width="20%">
					    <col width="20%">
					    <col width="50%">
					</colgroup>
			    	<tbody>
						<tr>
							<td headers="header1">
								<ul>
									<li>${paymentInfo.cardNumber}</li>
									<li>${paymentInfo.cardTypeData.name}</li>
									<li><spring:theme code="text.expires" text="Expires"/>&nbsp;${paymentInfo.expiryMonth} / ${paymentInfo.expiryYear}</li>
								</ul>															
							</td>
							<td headers="header2">
								<ul>
									<li><c:out value="${paymentInfo.billingAddress.title} ${paymentInfo.billingAddress.firstName} ${paymentInfo.billingAddress.lastName}"/></li>
									<li>${paymentInfo.billingAddress.line1}</li>
									<li>${paymentInfo.billingAddress.line2}</li>
									<li>${paymentInfo.billingAddress.town}</li>
									<li>${paymentInfo.billingAddress.postalCode}</li>
									<li>${paymentInfo.billingAddress.country.name}</li>
								</ul>
							</td>
							<td headers="header4" class="actions">
								<ul>
									<li>
										<br>
										<c:url value="/my-account/payment-method-subscriptions?paymentInfoId=${paymentInfo.id}" var="manageSubscriptionsUrl"/>
										<c:url value="/paymentDetails/edit-payment-details?paymentInfoId=${paymentInfo.id}&targetArea=accountArea" var="continueToEditPaymentDetailsUrl" />
                                        <button value="${empty subscriptions? 'edit':'manage'}" id="editWithSubscriptions" class="function_btn positive black" data-url="${empty subscriptions? continueToEditPaymentDetailsUrl:manageSubscriptionsUrl}">
                                            <spring:theme code="text.edit" text="Edit"/>
                                        </button>

										<c:url value="/my-account/check-remove-payment-method?paymentInfoId=${paymentInfo.id}" var="removePaymentActionUrl"/>
                                        <button id="removeWithSubscriptions" class="function_btn positive ${empty subscriptions? 'black':'grey'}" data-url="${removePaymentActionUrl}">
                                            <spring:theme code="text.account.paymentDetails.removePaymentDetails" text="Remove"/>
                                        </button>
									</li>
								</ul>
							</td>
						</tr>
					</tbody>
			    </table>
			    
			    <c:choose>
				    <c:when test="${not empty subscriptions}">
				       
				    			
				    <p class="infoline"><spring:theme code="text.account.paymentDetails.associatedSubscriptions"/> </p>
	
				    <br>
				
				    <c:url value="/paymentDetails/change-payment-method-subscription" var="changePaymentMethodSubscriptionUrl" />
				    <form:form id="idManageAssociatedSubscriptions" method="post" commandName="paymentSubscriptionsForm" action="${changePaymentMethodSubscriptionUrl}">
						    <input type="hidden" name="paymentInfoId" value="${paymentInfo.id}"/>
						
						    <table class="account-table">
						        <thead>
						            <tr>
						                <th id="header1"><spring:theme code="text.account.subscription.productName" text="Product Name"/></th>
						                <th id="header2"><spring:theme code="text.account.subscription.startDate" text="Start Date"/></th>
						                <th id="header3"><spring:theme code="text.account.subscription.endDate" text="End Date"/></th>
						                <th id="header4"><spring:theme code="text.account.subscription.status" text="Status"/></th>
						                <c:if test="${not empty subscriptions and not empty paymentMethods}">
						                	<th id="header5"><input type="checkbox" id="selectall"/>&nbsp;&nbsp;<spring:theme code="text.account.subscription.selectAll" text="Select All"/></th>
						                </c:if>
						            </tr>
						        </thead>
						        <tbody>
	
						            <c:forEach items="${subscriptions}" var="subscription" varStatus="loop">
						                <tr>
						                    <td headers="header1">${subscription.name}</td>
						                    <td headers="header2" class="background"><fmt:formatDate type="date" value="${subscription.startDate}"/></td>
						                    <td headers="header3"><fmt:formatDate type="date" value="${subscription.endDate}"/></td>
						                    <td headers="header4" class="background">${subscription.subscriptionStatus}</td>
						                    <c:if test="${not empty paymentMethods}">
						                        <td headers="header5">
						                            <form:checkbox path="subscriptionsToChange" value="${subscription.id}"/>
						                        </td>
						                    </c:if>
						                </tr>
						            </c:forEach>
						        </tbody>
						    </table>
	
						    <div class="infoline">
						    	<spring:theme code="text.account.paymentDetails.change.selectedSubscriptions"/>
						        <br/>

						        <c:if test="${empty paymentMethods}">
					               <div class="no-payment">
					                	<spring:theme code="text.account.paymentDetails.remove.changeImpossible" text="Remove impossible"/>
					                	<br/>
					                </div>
						        </c:if>
						    </div>
	
						    <c:if test="${not empty paymentMethods}">
				             <div class="payment-box">
							        <div class="credit-card">${paymentInfo.cardTypeData.name}</div>
							        <spring:theme code="text.account.paymentDetails.payment.details" arguments="${fn:replace(paymentInfo.cardNumber,'*','')}" text="cardNumber"/><br>
						        	<spring:theme code="text.expires" text="Expires"/>:&nbsp;${paymentInfo.expiryMonth}/${paymentInfo.expiryYear}
							    </div>
						  		<div class="change-box right">
								    <div class="actions">								  
								            <table>
								                <tr>
								                    <td>
								                        <form:select id="id_changeToPM" path="newPaymentMethodId" onchange="switchChangeButton();">
								                            <option value="" label="<spring:theme code='text.account.paymentDetails.selectPaymentMethod'/>" selected="selected">
								                            	<spring:theme code="text.account.paymentDetails.selectPaymentMethod" text="Remove impossible"/>
								                            </option>
								                            <form:options items="${paymentMethods}" itemValue="code" itemLabel="name" />
								                        	</form:select>
								                        <button id="buttonChangeTo" type="${buttonTypeUpgrade}" class="function_btn positive" disabled="disabled">
								                            <spring:theme code="text.account.paymentDetails.changeTo"/>
								                        </button>
								                    </td>
								                </tr>
								            </table>								           
								    </div>
								</div>
							</c:if>
							<div class="back_btns">
								<c:url value="/paymentDetails/add-payment-method" var="addPaymentMethodUrl" />
								<button type="button" onclick="window.location='${addPaymentMethodUrl}?targetArea=accountArea'" class="function_btn positive right">
				                    <spring:theme code="text.account.paymentDetails.addNewPaymentDetails" text="Add New Payment Details"/>
								</button>
	
								<c:url value="/my-account/payment-details" var="backToPaymentInfoUrl" />
							    <button type="button" onclick="window.location='${backToPaymentInfoUrl}'" class="r_action_btn"><spring:theme code="text.account.paymentDetails.returnToPaymentDetails" text="Return To Payment Details"/>
						    	</button>
						    </div>
						    
				    </form:form>
			    </c:when>
				    <c:otherwise>
				    	 <spring:theme code="text.account.paymentDetails.noAssociatedSubscriptions" text="There are currently no subscriptions associated to this payment method."/>
				    </c:otherwise>
				</c:choose>
	


			</div>
        </div>
	</div>
</template:page>