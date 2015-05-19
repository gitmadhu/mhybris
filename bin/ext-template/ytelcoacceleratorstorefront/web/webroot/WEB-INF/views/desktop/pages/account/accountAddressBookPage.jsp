<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<nav:accountNav selected="address-book" />
	<div class="span-20 last cust_acc-page">
		<div class="item_container_holder address_book">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="text.account.addressBook" text="Address Book"/></h2>
			</div>
			<div class="item_container">
				<p><spring:theme code="text.account.addressBook.manageYourAddresses" text="Manage your delivery addresses"/></p>
				<c:if test="${not empty addressData}">


					<table class="account-table">
						<thead>
							<tr>
								<th id="header1"><spring:theme code="text.address" text="Delivery Address"/></th>
								<th id="header2"><spring:theme code="text.default" text="Default"/></th>
								<th id="header3"><spring:theme code="text.actions" text="Actions"/></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${addressData}" var="address">
							<tr>
								<td headers="header1">
									<ycommerce:testId code="addressBook_address_label">
										<ul>
											<li>${fn:escapeXml(address.title)}&nbsp;${fn:escapeXml(address.firstName)}&nbsp;${fn:escapeXml(address.lastName)}</li>
											<li>${fn:escapeXml(address.line1)}</li>
											<li>${fn:escapeXml(address.line2)}</li>
											<li>${fn:escapeXml(address.town)}</li>
											<li>${fn:escapeXml(address.postalCode)}</li>
											<li>${fn:escapeXml(address.country.name)}</li>
										</ul>
									</ycommerce:testId>
								</td>
								<td headers="header2" class="background">
									<c:if test="${address.defaultAddress}">
										Yes
									</c:if>
									<c:if test="${not address.defaultAddress}">
										<ycommerce:testId code="addressBook_isDefault_button">
											<a href="set-default-address/${address.id}" class="function_btn btn_add"><spring:theme code="text.account.addressBook.makeDefault" text="Set As Default"/></a>
										</ycommerce:testId>
									</c:if>
								</td>
								<td headers="header3" class="actions">
									<ul>
										<li>
											<ycommerce:testId code="addressBook_editAddress_button">
											<a href="edit-address/${address.id}" class="positive btn_add"><spring:theme code="text.account.addressBook.editAddress" text="Edit Address"/></a>
											</ycommerce:testId>
										</li>
										<li>
											<ycommerce:testId code="addressBook_removeAddress_button">
												<c:url value="remove-address/${address.id}" var="removeAddress"/>
												<a href="#" class="function_btn btn_add js-remove-address" data-id="${address.id}"><spring:theme code="text.account.addressBook.removeAddress" text="Remove Address"/></a>
												<div style="display: none;">
													<div id="remove-address-confirm-${address.id}" class="remove-address-confirm" >
														<div class="title"><spring:theme code="text.account.addressBook.confirmRemoval" text="Confirm Removal"/></div>
														<p><spring:theme code="text.account.addressBook.removeAddress.confirmMessage" text="Are you sure you would like to remove this delivery address"/></p>
														<div class="actions">
															<button type="button" class="cancel r_action_btn"><spring:theme code="text.account.addressBook.removeAddress.cancel" text="No"/></button>
															<button type="button" onclick="window.location='${removeAddress}'" class="confirm positive"><spring:theme code="text.account.addressBook.removeAddress.yes" text="Yes"/></button>
														</div>
													</div>
												</div>
											</ycommerce:testId>
										</li>
									</ul>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>

				</c:if>
                <ycommerce:testId code="addressBook_addNewAddress_button">
					<a href="add-address" class="positive btn_add">
							<spring:theme code="text.account.addressBook.addAddress" text="Add new address"/>
					</a>
				</ycommerce:testId>
			</div>
		</div>
	</div>
</template:page>