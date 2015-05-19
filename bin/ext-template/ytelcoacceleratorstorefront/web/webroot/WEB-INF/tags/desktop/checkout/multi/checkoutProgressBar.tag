<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="steps" required="true" type="java.util.List" %>
<%@ attribute name="currentStep" required="true" type="java.lang.Integer"%>
<%@ attribute name="stepName" required="true" type="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="checkoutProgress">
	<ul>	
	  <c:forEach items="${steps}" var="checkoutStep" varStatus="status" > 
		<c:choose>
			<c:when test="${stepName eq checkoutStep.stepName}">
			 	<li class="checkoutProgressStepActive">
				 	<a href="${checkoutStep.url}" >
				 		<spring:theme code="checkout.multi.${checkoutStep.stepName}" />
				 	</a>
				 </li>
			</c:when>
			<c:when test="${status.count > currentStep }">
			 	<li class="checkoutProgressStepDisabled">
			 		<a href="${checkoutStep.url}" >
			 			<spring:theme code="checkout.multi.${checkoutStep.stepName}" />
			 		</a>
			 	</li>
			</c:when>
			<c:otherwise>
				<li class="checkoutProgressStepVisited">
					<a href="${checkoutStep.url}">
						<spring:theme code="checkout.multi.${checkoutStep.stepName}" />
					</a>
				</li>
			</c:otherwise>
		</c:choose>
	  	
	  </c:forEach>
	</ul>
</div>