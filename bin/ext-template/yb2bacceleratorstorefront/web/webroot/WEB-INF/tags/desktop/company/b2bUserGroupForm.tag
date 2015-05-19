<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ attribute name="b2BUserGroupForm" required="true"
			  type="de.hybris.platform.yb2bacceleratorstorefront.forms.B2BUserGroupForm" %>
<%@ attribute name="formUrl" required="true"
			  type="java.lang.String" %>
<%@ attribute name="cancelUrl" required="true"
			  type="java.lang.String" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<div class="required right"><spring:theme code="form.required" text="Fields marked * are required" /></div>
<div class="description"><spring:theme code="text.company.manageUsergroup.editForm" text="Please use this form to update usergroup details"/></div>



<form:form action="${formUrl}" method="post" commandName="b2BUserGroupForm">
		<form:input type="hidden" name="originalUid" path="originalUid" id="originalUid"/>
		<formElement:formInputBox idKey="b2busergroup.id" labelKey="b2busergroup.id"
							   path="uid" inputCSS="text" mandatory="true"/>
		<formElement:formInputBox idKey="b2busergroup.name" labelKey="b2busergroup.name"
							   path="name" inputCSS="text" mandatory="true"/>
		<formElement:formSelectBox idKey="b2busergroup.parent" labelKey="b2busergroup.parent"
								path="parentUnit"
								mandatory="false" skipBlank="false"
								skipBlankMessageKey="form.select.empty"
								items="${branchSelectOptions}"/>
							
								<a href="${cancelUrl}" class="button no-confirm"><spring:theme code="b2busergroup.cancel" text="Cancel"/></a>
								<ycommerce:testId code="Unit_SaveChange_button">
									<button type="submit" class="button confirm"><spring:theme code="b2busergroup.save" text="Save Updates"/></button>
								</ycommerce:testId>
</form:form>
