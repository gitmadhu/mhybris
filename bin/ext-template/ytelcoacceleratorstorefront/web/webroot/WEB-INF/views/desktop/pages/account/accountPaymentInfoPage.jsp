<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">

	<script type="text/javascript">
		function submitSetDefault(id){
			document.getElementById('setDefaultPaymentDetails'+id).submit();
		}

        $(document).on("click", "#editWithSubscriptions", function(){
			
         	if(isSessionAlive())
            	{
                	$self=$(this);
		            $.colorbox({
		              href:$self.data("url"),
		              width:false,
		              height:false,
		              onComplete: function(){
		                  $.colorbox.resize();
		              }
		            });
            	}
            else
            	{
            		location.reload();
            	}
        })


        $(document).on("click", "#payment-method-subscriptions .r_action_btn", function(){
            $.colorbox.close();
        })
			  
        
        $(document).on("click", "#removeWithSubscriptions", function(){
 
            if(isSessionAlive())
            	{
                	$self=$(this);
		            $.colorbox({
		              href:$self.data("url"),
		              width:false,
		              height:false,
		              onComplete: function(){
		                  $.colorbox.resize();
		              }
		            });
            	}
            else
            	{
            		location.reload();
            	}
        })

        $(document).on("click", "#payment-method-delete .r_action_btn", function(){
            $.colorbox.close();
        });
        
        function isSessionAlive()
        {
        		var isAlive;
	        	$.ajax({
					    url : "../my-account/is-alive",
					    type: "GET",
					    async: false,
					    success: function(data, textStatus, jqXHR)
					    {
					        if(data == 'alive')
					        	{	
					        		isAlive = true;
					        	}
					        else
					        	{
						      	isAlive = false;
					        	}
					    },
					    error: function (jqXHR, textStatus, errorThrown)
					    {
					    	isAlive = false;
					    }
	    			});   
        		
        		return isAlive;
        }
	</script>

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}" />
	</div>
	<div id="globalMessages">
		<common:globalMessages />
	</div>
	<nav:accountNav selected="payment-details" />
	<div class="span-20 last cust_acc-page">
		<div class="item_container_holder paymentDetails">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.paymentDetails" text="Payment Details"/></h2>
			</div>
			<div class="item_container">
				<p><spring:theme code="text.account.paymentDetails.managePaymentDetails" text="Manage your saved payment details."/></p>
				<c:if test="${not empty paymentInfoData}">


					<table class="account-table">
						<thead>
							<tr>
									<th id="header1"><spring:theme code="text.account.paymentDetails.paymentCard" text="Payment Card"/></th>
									<th id="header2"><spring:theme code="text.account.paymentDetails.billingAddress" text="Billing Address"/></th>
									<th id="header3"><spring:theme code="text.default" text="Default"/></th>
									<th id="header4"><spring:theme code="text.actions" text="Actions"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${paymentInfoData}" var="paymentInfo">
								<tr>
									<td headers="header1">
										<ul>
											<li><c:out value="${fn:replace(paymentInfo.cardNumber,'****','**** ')}" /></li>
											<li>${fn:escapeXml(paymentInfo.cardTypeData.name)}</li>
										<li><spring:theme code="text.expires.colon" text="Expires:"/>&nbsp;${fn:escapeXml(paymentInfo.expiryMonth)} / ${fn:escapeXml(paymentInfo.expiryYear)}</li>
										</ul>
									</td>
									<td headers="header2" class="background">
										<ul>
										<li><c:out value="${fn:escapeXml(paymentInfo.billingAddress.title)} ${fn:escapeXml(paymentInfo.billingAddress.firstName)} ${fn:escapeXml(paymentInfo.billingAddress.lastName)}"/></li>
											<li>${fn:escapeXml(paymentInfo.billingAddress.line1)}</li>
											<li>${fn:escapeXml(paymentInfo.billingAddress.line2)}</li>
											<li>${fn:escapeXml(paymentInfo.billingAddress.town)}</li>
											<li>${fn:escapeXml(paymentInfo.billingAddress.postalCode)}</li>
											<li>${fn:escapeXml(paymentInfo.billingAddress.country.name)}</li>
										</ul>
									</td>
									<td headers="header3">
										<c:if test="${paymentInfo.defaultPaymentInfo}">
											Yes
										</c:if>
										<c:if test="${not paymentInfo.defaultPaymentInfo}">
											<c:url value="/my-account/set-default-payment-details" var="setDefaultPaymentActionUrl"/>
											<form:form id="setDefaultPaymentDetails${paymentInfo.id}" action="${setDefaultPaymentActionUrl}" method="post">
												<input type="hidden" name="paymentInfoId" value="${paymentInfo.id}"/>
												<button type="button" onclick="javascript:submitSetDefault(${paymentInfo.id});" class="function_btn"><spring:theme code="text.account.paymentDetails.makeDefault" text="Set as default"/></button>
											</form:form>
										</c:if>
									</td>
									<td headers="header4" class="actions background">
										<ul>
							
	                                        <li>
		                                        <c:if test="${subscriptionsPerPaymentMethod[paymentInfo.id] gt '0'}">
	    											<c:url value="/my-account/manage-payment-method?paymentInfoId=${paymentInfo.id}" var="manageSubscriptionsUrl"/>
	                                                <button type="button" onclick="window.location='${manageSubscriptionsUrl}'" class="positive">
	                                                    <spring:theme code="text.account.paymentDetails.manageSubscriptions" text="Manage Subscriptions"/>
	                                                </button>
	                                            </c:if>
                                            </li>
											<li>
											
		                                        <div class="left">
		                                        	 <c:if test="${subscriptionsPerPaymentMethod[paymentInfo.id] gt '0'}">
		    											<c:url value="/my-account/payment-method-subscriptions?paymentInfoId=${paymentInfo.id}" var="manageSubscriptionsUrl"/>
		                                                <button id="editWithSubscriptions" class="function_btn" data-url="${manageSubscriptionsUrl}">
		                                                    <spring:theme code="text.edit" text="Edit"/>
		                                                </button>
		    										</c:if>
		                                            <c:if test="${subscriptionsPerPaymentMethod[paymentInfo.id] eq '0'}">
		                                                <c:url value="/paymentDetails/edit-payment-details?paymentInfoId=${paymentInfo.id}&targetArea=accountArea" var="continueToEditPaymentDetailsUrl" />
		                                                <button type="button" onclick="window.location='${continueToEditPaymentDetailsUrl}'" class="function_btn">
		                                                    <spring:theme code="text.edit" text="Edit"/>
		                                                </button>
		                                            </c:if>

		                                        </div>

		                                        <div class="left">
													<c:url value="/my-account/check-remove-payment-method?paymentInfoId=${paymentInfo.id}" var="removePaymentActionUrl"/>
		                                            <button id="removeWithSubscriptions" class="function_btn" data-url="${removePaymentActionUrl}">
		                                                <spring:theme code="text.account.paymentDetails.removePaymentDetails" text="Remove"/>
		                                            </button>
		                                        </div>


											</li>
										</ul>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>

				<c:url value="/paymentDetails/add-payment-method" var="addPaymentMethodUrl" />
				<button type="button" onclick="window.location='${addPaymentMethodUrl}?targetArea=accountArea'" class="positive">
                    <spring:theme code="text.account.paymentDetails.addNewPaymentDetails" text="Add New Payment Details"/>
				</button>
			</div>
		</div>
	</div>
</template:page>