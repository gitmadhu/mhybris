<%--CHINAACC_NEWFILE --%>

<%@ page trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>

	<nav:accountNav selected="address-book"/>

    <div class="myAddList">
		<h3><spring:theme code="cnacc.text.account.addressBook.title" text="My Delivery Addresses"/></h3>
        <h4>
        	<ycommerce:testId code="china_addressBook_addNewAddress_button">
            	<spring:theme code="cnacc.text.account.addressBook.subtitle" text="Manage my address book"/>
                <a href="add-address"><spring:theme code="cnacc.text.account.addressBook.addAddress" text="Add new address"/></a>
            </ycommerce:testId>
		</h4>  
        <div class="myAddList2"> 
        	<table cellpadding="0" cellspacing="0" border="0" width="100%">
            	<tr>
                	<th><spring:theme code="cnacc.text.account.addressBook.address" text="Address"/></th>
                    <th style="text-align:center;" width="148"><spring:theme code="cnacc.text.account.addressBook.actions" text="Actions"/></th>
                </tr>
				
				<c:choose>
                	<c:when test="${not empty addressData}">
						<c:forEach items="${addressData}" var="addressDto">
							<tr>
                            	<td>
                                	<p><span class="nameMsg">${fn:escapeXml(addressDto.firstName)}</span></p>
                                    <p>
                                    	<span>${fn:escapeXml(addressDto.country.name)}</span><c:if test="${not empty addressDto.region.name}">, </c:if>
                                        <span class="provinceMsg">${fn:escapeXml(addressDto.region.name)}</span><c:if test="${not empty addressDto.city}">, </c:if>
                                        <span class="cityMsg">${fn:escapeXml(addressDto.city)}</span><c:if test="${not empty addressDto.cityDistrict}">, </c:if>
                                        <span class="regionMsg">${fn:escapeXml(addressDto.cityDistrict)}</span><c:if test="${not empty addressDto.line1}">, </c:if>
                                        <span class="addressMsg">${fn:escapeXml(addressDto.line1)}</span><c:if test="${not empty addressDto.postalCode}">, </c:if>
                                        <span class="zipMsg">${fn:escapeXml(addressDto.postalCode)}</span>
                                    </p>
                                    <p><span class="mobile">${fn:escapeXml(addressDto.cellphone)}</span><span class="phone">${fn:escapeXml(addressDto.phone)}</span></p>
								</td>
                                <td>
                                	<ycommerce:testId code="addressBook_addressOptions_label">
										<p class="myAddList2_btn">
                                        	<ycommerce:testId code="china_addressBook_editAddress_button">
                                        		<a href="edit-address/${addressDto.id}" class="myAddList2_edit"><spring:theme code="cnacc.text.account.addressBook.update" text="Update"/></a>
                                        	</ycommerce:testId>
                                        	<ycommerce:testId code="addressBook_removeAddress_button">
                                        		<input type="hidden" id="confirm" value='<spring:theme code="cnacc.text.account.addressBook.delete.confirm" text="Delete"/>' />
                                        		<a href="#" class="myAddList2_del removeAddressButton" data-address-id="${addressDto.id}"><spring:theme code="cnacc.text.account.addressBook.delete" text="Delete"/></a>
                                        	</ycommerce:testId>
											<c:if test="${addressDto.defaultAddress}">
												<ycommerce:testId code="china_addressBook_isDefault_label">
													<a href="#" class="myAddList2_set myAddList2_default"><spring:theme code="cnacc.text.account.addressBook.isdefault" text="default"/></a>
												</ycommerce:testId>
											</c:if>
	                                    	<c:if test="${not addressDto.defaultAddress}">
	                                    		<ycommerce:testId code="addressBook_isDefault_label">
	                                    			<a href="set-default-address/${addressDto.id}" class="myAddList2_set"><spring:theme code="cnacc.text.account.addressBook.setasdefault" text="Set as default"/></a>
	                                    		</ycommerce:testId>
	                                    	</c:if>
                                        </p>
									</ycommerce:testId>
								</td>
                                                                       
								<div style="display:none">
									<div id="popup_confirm_address_removal_${addressDto.id}">
										<div class="addressItem">
											<ycommerce:testId code="china_addressBook_address_label">
												<ul>
													<li>${fn:escapeXml(addressDto.firstName)}</li>
													<li>${fn:escapeXml(addressDto.country.name)}</li>
													<li>${fn:escapeXml(addressDto.region.name)}</li>
													<li>${fn:escapeXml(addressDto.city)}</li>
													<li>${fn:escapeXml(addressDto.cityDistrict)}</li>
													<li>${fn:escapeXml(addressDto.line1)}</li>
													<li>${fn:escapeXml(addressDto.postalCode)}</li>
													<li>${fn:escapeXml(addressDto.cellphone)}</li>
													<li>${fn:escapeXml(addressDto.phone)}</li>
												</ul>
											</ycommerce:testId>
											<spring:theme code="cnacc.text.adress.remove.confirmation" text="Are you sure you would like to delete this address?"/>

											<div class="buttons">
												<a class="removeAddressButton" data-address-id="${addressDto.id}" href="remove-address/${addressDto.id}">
													<spring:theme code="cnacc.text.yes" text="Yes"/>
												</a>
												<a class="closeColorBox" data-address-id="${addressDto.id}">
													<spring:theme code="cnacc.text.no" text="No"/>
												</a>
											</div>
										</div>
									</div>
								</div>
							</tr>
						</c:forEach>
					</c:when>
                    <c:otherwise>
						<p class="emptyMessage"><spring:theme code="text.account.addressBook.noSavedAddresses"/></p>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div> 
</template:page>