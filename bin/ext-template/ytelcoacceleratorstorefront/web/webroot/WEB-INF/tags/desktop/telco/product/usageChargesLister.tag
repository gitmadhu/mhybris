<%@ attribute name="subscriptionData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>

<c:if test="${not empty subscriptionData.price and not empty subscriptionData.price.usageCharges}">
    <c:forEach items="${subscriptionData.price.usageCharges}" var="usageCharge" varStatus="loop">
        <b>${usageCharge.name}</b><br/>
        <c:if test="${not empty usageCharge.usageChargeEntries}">
            <c:forEach items="${usageCharge.usageChargeEntries}" var="usageChargeEntry">
                <c:if test="${usageChargeEntry['class'].simpleName eq 'TierUsageChargeEntryData'}">
                    <spring:theme code="product.list.viewplans.tierUsageChargeEntry" arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}^${usageCharge.usageUnit.name}" argumentSeparator="^"/><br/>
                </c:if>
                <c:if test="${usageChargeEntry['class'].simpleName eq 'OverageUsageChargeEntryData'}">
                    <spring:theme code="product.list.viewplans.overageUsageChargeEntry" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}"/>
                </c:if>
            </c:forEach>
        </c:if>
        <c:if test="${not loop.last}">
            <br/><br/>
        </c:if>
    </c:forEach>
</c:if>