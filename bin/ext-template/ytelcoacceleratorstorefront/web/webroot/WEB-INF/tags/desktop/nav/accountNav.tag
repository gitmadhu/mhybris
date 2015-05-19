<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="selected" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div class="span-4">
	<div class="span-4 nav_column">
		<div class="title_holder">
			<div class="title">
				<div class="title-top">
					<span></span>
				</div>
			</div>
			<h2><spring:theme code="text.account.yourAccount" text="Your Account"/></h2>
		</div>
		<div class="item">
			<ul class="facet_block indent">
				<li class='${selected eq 'profile' ? 'nav_selected' : ''}'>
					<c:url value="/my-account/profile" var="encodedUrl" />
					<ycommerce:testId code="myAccount_profile_navLink">
						<a href="${encodedUrl}" title="<spring:theme code="text.account.profile" text="Profile"/>"><spring:theme code="text.account.profile" text="Profile"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'address-book' ? 'nav_selected' : ''}'>
					<c:url value="/my-account/address-book" var="encodedUrl" />
					<ycommerce:testId code="myAccount_addressBook_navLink">
						<a href="${encodedUrl}" title="<spring:theme code="text.account.addressBook" text="Address Book"/>"><spring:theme code="text.account.addressBook" text="Address Book"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'payment-details' ? 'nav_selected' : ''}'>
					<c:url value="/my-account/payment-details" var="encodedUrl" />
					<ycommerce:testId code="myAccount_paymentDetails_navLink">
						<a href="${encodedUrl}" title="<spring:theme code="text.account.paymentDetails" text="Payment Details"/>"><spring:theme code="text.account.paymentDetails" text="Payment Details"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'orders' ? 'nav_selected' : ''}'>
					<c:url value="/my-account/orders" var="encodedUrl" />
					<ycommerce:testId code="myAccount_orders_navLink">
						<a href="${encodedUrl}" title="<spring:theme code="text.account.orderHistory" text="Order History"/>"><spring:theme code="text.account.orderHistory" text="Order History"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'subscriptions' ? 'nav_selected' : ''}'>
					<c:url value="/my-account/subscriptions" var="encodedUrl" />
					<ycommerce:testId code="myAccount_subscriptions_navLink">
						<a href="${encodedUrl}" title="<spring:theme code="text.account.subscriptions" text="Subscriptions"/>"><spring:theme code="text.account.subscriptions" text="Subscriptions"/></a>
					</ycommerce:testId>
				</li>
			</ul>
		</div>
	</div>
	<div class="span-4 side-content-slot advert">
		<cms:slot var="feature" contentSlot="${slots['SideContent']}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
</div>