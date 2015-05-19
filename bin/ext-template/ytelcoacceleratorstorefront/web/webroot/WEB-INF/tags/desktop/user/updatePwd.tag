<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div class="span-4 side-content-slot advert">
	<cms:slot var="feature" contentSlot="${slots['SideContent']}">
		<cms:component component="${feature}"/>
	</cms:slot>
</div>

<div class="span-20 last">
	<div class="item_container_holder">
		<div class="title_holder">
			<div class="title">
				<div class="title-top">
					<span></span>
				</div>
			</div>
			<h2><spring:theme code="updatePwd.title"/></h2>
		</div>

		<div class="item_container">
			<p><spring:theme code="updatePwd.description"/></p>
			<p class="required"><spring:theme code="form.required"/></p>
			<form:form method="post" commandName="updatePwdForm">
				<dl>
					<formElement:formPasswordBox idKey="updatePwd-pwd" labelKey="updatePwd.pwd" path="pwd" inputCSS="text password strength" mandatory="true"/>
					<formElement:formPasswordBox idKey="updatePwd.checkPwd" labelKey="updatePwd.checkPwd" path="checkPwd" inputCSS="text password" mandatory="true" errorPath="updatePwdForm"/>
				</dl>
				<span style="display: block; clear: both;">
					<ycommerce:testId code="update_update_button">
						<button class="form"><spring:theme code="updatePwd.submit"/></button>
					</ycommerce:testId>
				</span>
			</form:form>
		</div>
	</div>
</div>
