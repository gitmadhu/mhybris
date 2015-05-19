<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="upgradeOptions" required="true" type="java.util.List" %>
<%@ attribute name="selectProduct" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showButtons" required="true" type="java.lang.Boolean" %>
<%@ attribute name="horizontalLayout" required="true" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/desktop/telco/guidedselling" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/telco/product" %>

<script type="text/javascript">

    $(document).ready(function(){
        
        $(".prod_add_to_cart").addClass("js");
        
        $(".tabs").accessibleTabs({
            tabhead:'h2',
            fx:"show",
            autoAnchor:true,
            fxspeed:null
        });


        $(".equalCheck").each(function(){
            var tds = $(this).parents("tr").find("td");
            if($(tds[0]).html() == $(tds[2]).html()){
                $(this).remove();
            }
        });


        $(document).on("click", ".viewPotentialUpgradeBillingDetails", function(){
            $self=$(this);
            $.colorbox({
                href:$self.data("url"),
                width:"600px",
                height:false,
                onComplete: function(){
                    $.colorbox.resize();

                    if($("#addUpgradeButton").hasClass("not-upgradable")){
                       $("#upgrade-billing-changes .confirm").attr("disabled","disabled").addClass("not-upgradable")
                    }
                }
            })
        })


         $(document).on("click", "#upgrade-billing-changes .r_action_btn", function(){
            $.colorbox.close();
        })

    });

</script>    

<div class="title_holder">
    <h2><spring:theme code="text.account.upgrade.options" text="Upgrade Options"/></h2>
</div>


<div class="item_container account-upgrade-subscription">

    <p><spring:theme code="text.account.upgrade.options.description" text="View options"/></p>
    
    <c:url value="/my-account/upgradesubscription" var="upgradeSubscription" />
    <c:url value="" var="buttonTooltip" />
    <c:set var="isSubscriptionUpgradable" value="true"/>
    <c:if test="${subscriptionData.subscriptionStatus == 'cancelled'}">
        <c:set var="isSubscriptionUpgradable" value="false"/>
        <c:url value="text.account.subscription.cancelledSubscriptionNotUpgradable" var="buttonTooltip" />
    </c:if>
    <c:if test="${isSubscriptionUpgradable eq true}">
        <c:forEach items="${cartData.entries}" var="entry">
            <c:if test="${not empty entry.originalSubscriptionId and subscriptionData.id eq entry.originalSubscriptionId}">
                <c:set var="isSubscriptionUpgradable" value="false"/>
                <c:url value="text.account.subscription.alreadyUpgraded" var="buttonTooltip" />
            </c:if>
        </c:forEach>
    </c:if>

    <div class="prod_add_to_cart">
        <div class="tabs">
            <c:forEach items="${upgradeOptions}" var="upgradeOptionTab" varStatus="upgradeOptionTabCounter">
                <c:if test="${upgradeOptionTab.preselected}"></c:if>
                <h2 <c:if test="${upgradeOptionTab.preselected}"> id="preselected"</c:if>>${upgradeOptionTab.name}</h2> <!-- TODO please preselect -->

                <div class="tabbody">
                   
                        <table class="account-upgrade-subscription-table">
                            <thead>
                                <tr>
                                    <th width="35%">
                                        <div class="top_plan">Current Subscription</div>
                                        <div class="info-line">${subscriptionProductData.name}</div>
                                    </th>
                                    <th width="30%">
                                       <div class="info-line center"> <spring:theme code="text.account.subscriptions.upgrade.change" text="Change"/></div>       
                                    </th>
                                    <th width="35%">
                                        <div class="top_plan">Upgrade option(s)</div>
                                        <div class="info-line">${upgradeOptionTab.name}</div>
                                    </th>
                                </tr>                               
                            </thead>
                            <tbody>
                                <tr>
                                    <td >${subscriptionProductData.subscriptionTerm.billingPlan.billingTime.name}</td>
                                    <td class="change_col">
                                        <spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency"/>
                                        <img class="equalCheck" src="${commonResourcePath}/../theme-blue-telco-extension/images/icon-checkout-summary-flow-tick.png"/>
                                    </td>
                                    <td >${upgradeOptionTab.subscriptionTerm.billingPlan.billingTime.name}</td>
                                </tr>
                                <tr>
                                    <td ><product:subscriptionPricesLister subscriptionData="${subscriptionProductData}"/></td>
                                    <td class="change_col">
                                        <spring:theme code="product.list.viewplans.price" text="Price"/>
                                        <img class="equalCheck" src="${commonResourcePath}/../theme-blue-telco-extension/images/icon-checkout-summary-flow-tick.png"/>
                                    </td>
                                    <td ><product:subscriptionPricesLister subscriptionData="${upgradeOptionTab}"/></td>
                                </tr>
                                <tr>
                                    <td >${subscriptionProductData.subscriptionTerm.termOfServiceNumber}&nbsp;${subscriptionProductData.subscriptionTerm.termOfServiceFrequency.name}</td>
                                    <td class="change_col">
                                        <spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency"/>
                                        <img class="equalCheck" src="${commonResourcePath}/../theme-blue-telco-extension/images/icon-checkout-summary-flow-tick.png"/>
                                    </td>
                                    <td >${upgradeOptionTab.subscriptionTerm.termOfServiceNumber}&nbsp;${upgradeOptionTab.subscriptionTerm.termOfServiceFrequency.name}</td>
                                </tr>
                                <tr>
                                    <td ><product:entitlementLister subscriptionData="${subscriptionProductData}"/></td>
                                    <td class="change_col">
                                        <spring:theme code="product.list.viewplans.entitlements" text="Included"/>
                                        <img class="equalCheck" src="${commonResourcePath}/../theme-blue-telco-extension/images/icon-checkout-summary-flow-tick.png"/>
                                    </td>
                                    <td ><product:entitlementLister subscriptionData="${upgradeOptionTab}"/></td>
                                </tr>
                                <tr>
                                    <td ><product:usageChargesLister subscriptionData="${subscriptionProductData}"/></td>
                                    <td class="change_col">
                                        <spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges"/>
                                        <img class="equalCheck" src="${commonResourcePath}/../theme-blue-telco-extension/images/icon-checkout-summary-flow-tick.png"/>
                                    </td>
                                    <td ><product:usageChargesLister subscriptionData="${upgradeOptionTab}"/></td>
                                </tr>
                                <tr>
                                    <td >${subscriptionProductData.subscriptionTerm.termOfServiceRenewal.name}</td>
                                    <td class="change_col">
                                        <spring:theme code="text.account.subscription.renewalType" text="Renewal Type"/>
                                        <img class="equalCheck" src="${commonResourcePath}/../theme-blue-telco-extension/images/icon-checkout-summary-flow-tick.png"/>
                                    </td>
                                    <td >${upgradeOptionTab.subscriptionTerm.termOfServiceRenewal.name}</td>
                                </tr>
                            </tbody>
                        </table>

                        <c:url value="/my-account/subscription/${subscriptionData.id}" var="myAccountSubscriptionDetailsUrl"/>
                        <button class="r_action_btn default" type="button" onclick="window.location='${myAccountSubscriptionDetailsUrl}'">
                            <spring:theme code="text.account.subscription.returnToCurrentPlan" text="Return to Current Plan"/>
                        </button>

                        <form:form class="upgrade_subscription_form right" id="upgradeSubscriptionForm_${subscriptionData.id}_${upgradeOptionTab.code}" action="${upgradeSubscription}" method="post">
                            <c:set var="buttonTypeUpgrade">button</c:set>
                            <c:if test="${ isSubscriptionUpgradable eq true }">
                                <c:set var="buttonTypeUpgrade">submit</c:set>
                            </c:if>
                            
                            <button id="addUpgradeButton" type="${buttonTypeUpgrade}" title="<spring:theme code="${buttonTooltip}"/>" class="p_action_btn positive right <c:if test="${isSubscriptionUpgradable eq false}">not-upgradable</c:if>">
                                <spring:theme code="text.account.subscription.upgradeSubscriptionNow" text="Upgrade Now"/>
                            </button>

                            <input type="hidden" name="productCode" value="${upgradeOptionTab.code}"/>
                            <input type="hidden" name="subscriptionId" value="${subscriptionData.id}"/>
                            <input type="hidden" name="originalOrderCode" value="${subscriptionData.orderNumber}"/>
                            <input type="hidden" name="originalEntryNumber" value="${subscriptionData.orderEntryNumber}"/>
                        </form:form>



                        <button class="function_btn right viewPotentialUpgradeBillingDetails" data-url="/ytelcoacceleratorstorefront/my-account/viewPotentialUpgradeBillingDetails?subscriptionId=${subscriptionData.id}&upgradeId=${upgradeOptionTab.code}">
                            <spring:theme code="text.account.subscription.previewBillingChanges" text="View Billing Changes"/>
                        </button>
                </div>
            </c:forEach>
        </div>
    </div>
</div>