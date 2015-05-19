<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="costCenter" required="true" type="de.hybris.platform.b2bacceleratorfacades.order.data.B2BCostCenterData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:url value="/checkout/single/summary/getCostCenters.json" var="getCostCenters"/>
<spring:url value="/checkout/single/summary/getCheckoutCart.json" var="getCheckoutCartUrl" />
<spring:url value="/checkout/single/summary/setCostCenter.json" var="setCostCenterUrl" />
<spring:url value="/checkout/single/summary/updateCostCenter.json" var="updateCostCenterUrl" />


<div class="summaryCostCenter summarySection"  
	data-set-cost-center-url='${setCostCenterUrl}'  
	data-update-cost-center-url='${updateCostCenterUrl}'>

	<div class="contentSection">
		<div class="content">
			<div class="headline"><span class="number">2</span><spring:theme code="checkout.summary.costCenter.header" htmlEscape="false"/></div>
			<div>
				<form:select id="CostCenter" path="costCenters" cssClass="constCenterSelect">
					<option value="" label="<spring:theme code='costCenter.title.pleaseSelect'/>">
					<form:options items="${costCenters}" itemValue="code" itemLabel="name"/>
				</form:select>
			</div>
		</div>
	</div>
</div>
