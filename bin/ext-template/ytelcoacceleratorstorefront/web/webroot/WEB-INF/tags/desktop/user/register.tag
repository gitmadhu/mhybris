<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="actionNameKey" required="true" type="java.lang.String" %>
<%@ attribute name="action" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div class="item_container_holder">
	<div class="title_holder">
		<div class="title">
			<div class="title-top">
				<span></span>
			</div>
		</div>
		<h2><spring:theme code="register.new.customer" /></h2>
	</div>

	<div class="item_container">
	<p><spring:theme code="register.description"/></p>
	<p class="required"><spring:theme code="form.required"/></p>
	<form:form method="post" commandName="registerForm" action="${action}">
		<dl>
			<formElement:formSelectBox idKey="register.title" labelKey="register.title" path="titleCode" mandatory="true" skipBlank="false" skipBlankMessageKey="form.select.empty" items="${titles}"/>
			<formElement:formInputBox idKey="register.firstName" labelKey="register.firstName" path="firstName" inputCSS="text" mandatory="true"/>
			<formElement:formInputBox idKey="register.lastName" labelKey="register.lastName" path="lastName" inputCSS="text" mandatory="true"/>
			<formElement:formInputBox idKey="register.email" labelKey="register.email" path="email" inputCSS="text" mandatory="true"/>
			<formElement:formPasswordBox idKey="password" labelKey="register.pwd" path="pwd" inputCSS="text password strength" mandatory="true"/>
			<formElement:formPasswordBox idKey="register.checkPwd" labelKey="register.checkPwd" path="checkPwd" inputCSS="text password" mandatory="true" errorPath="registerForm"/>
		<%--for captchaaddon--%>
            <c:if test="${ycommerce:isExtensionInstalled('captchaaddon')}">
                <%@ taglib prefix="recaptcha" tagdir="/WEB-INF/tags/desktop/telco/recaptcha" %>
                <recaptcha:widget/>
            </c:if>
		</dl>
		<span style="display: block; clear: both;">
			<ycommerce:testId code="register_Register_button">
				<button class="positive"><spring:theme code='${actionNameKey}'/></button>
			</ycommerce:testId>
		</span>

	</form:form>
	</div>
</div>
