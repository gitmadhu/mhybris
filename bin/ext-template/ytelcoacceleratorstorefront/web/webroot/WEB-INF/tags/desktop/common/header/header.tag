<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="header" tagdir="/WEB-INF/tags/desktop/common/header"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>


<%-- Test if the UiExperience is currently overriden and we should show the UiExperience prompt --%>
<%--
<c:if test="${uiExperienceOverride and not sessionScope.hideUiExperienceLevelOverridePrompt}">
	<c:url value="/_s/ui-experience?level=" var="clearUiExperienceLevelOverrideUrl"/>
	<c:url value="/_s/ui-experience-level-prompt?hide=true" var="stayOnDesktopStoreUrl"/>
	<div class="backToMobileStore">
		<a href="${clearUiExperienceLevelOverrideUrl}"><span class="greyDot">&lt;</span><spring:theme code="text.swithToMobileStore" /></a>
		<span class="greyDot closeDot"><a href="${stayOnDesktopStoreUrl}">x</a></span>
	</div>
</c:if>
--%>


<div id="header">
	<div class="siteLogo">
		<c:url value="/" var="homeUrl"/>
		<a href="${homeUrl}">
			<cms:slot var="logo" contentSlot="${slots.SiteLogo}">
				<cms:component component="${logo}"/>
			</cms:slot>
		</a>
	</div>
	<!--<span id="Branding"></span>-->
	
	<cms:slot var="cart" contentSlot="${slots.MiniCart}">
		<cms:component component="${cart}"/>
	</cms:slot>
	
	<div class="headerContent">
		<ul class="nav">
			<c:if test="${uiExperienceOverride}">


			</c:if>
			<sec:authorize ifAnyGranted="ROLE_CUSTOMERGROUP">
				<li class="logged_in"><ycommerce:testId code="header_LoggedUser"><spring:theme code="header.welcome" arguments="${user.firstName},${user.lastName}" htmlEscape="true"/></ycommerce:testId></li>
			</sec:authorize>
			<sec:authorize ifNotGranted="ROLE_CUSTOMERGROUP">
				<li><ycommerce:testId code="header_Login_link"><a href="<c:url value="/login"/>" title="<spring:theme code="header.link.login"/>"><spring:theme code="header.link.login"/></a></ycommerce:testId></li>
			</sec:authorize>
			<sec:authorize ifAnyGranted="ROLE_CUSTOMERGROUP">
				<li><ycommerce:testId code="header_myAccount"><a href="<c:url value="/my-account"/>" title="<spring:theme code="header.link.account"/>"><spring:theme code="header.link.account"/></a></ycommerce:testId></li>
			</sec:authorize>
			<cms:slot var="link" contentSlot="${slots.HeaderLinks}">
				<li><cms:component component="${link}"/></li>
			</cms:slot>
			<li>| &nbsp; <a href="<c:url value="/store-finder"/>" title="<spring:theme code="general.find.a.store" />"><spring:theme code="general.find.a.store" /></a></li>
			<sec:authorize ifAnyGranted="ROLE_CUSTOMERGROUP"><li><ycommerce:testId code="header_signOut"><a href="<c:url value='/logout'/>"><spring:theme code="header.link.logout"/></a></ycommerce:testId></li></sec:authorize>
		</ul>

		<%--TEL-233 the currency and language taken down from the site --%>
		<%--
		<ul class="language">
			<li><header:languageSelector languages="${languages}" currentLanguage="${currentLanguage}" /></li>
			<li><header:currencySelector currencies="${currencies}" currentCurrency="${currentCurrency}" /></li>
		</ul>
		--%>

		
	</div>
	<div class="clear"></div>
</div>

