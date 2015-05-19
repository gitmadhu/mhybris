<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ attribute name="pageTitle" required="false" rtexprvalue="true" %>
<%@ attribute name="metaDescription" required="false" %>
<%@ attribute name="metaKeywords" required="false" %>
<%@ attribute name="pageCss" required="false" fragment="true" %>
<%@ attribute name="pageScripts" required="false" fragment="true" %>

<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="analytics" tagdir="/WEB-INF/tags/shared/analytics" %>
<%@ taglib prefix="debug" tagdir="/WEB-INF/tags/shared/debug" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="${currentLanguage.isocode}">
<head>
	<title>
		${not empty pageTitle ? pageTitle : not empty cmsPage.title ? cmsPage.title : 'Accelerator Title'}
	</title>

	<%-- Provide some hints to mobile browser even though this is not the mobile site --%>
	<meta name="HandheldFriendly" content="True" />
	<meta name="MobileOptimized" content="970" />
	<meta name="viewport" content="width=970, target-densitydpi=160, maximum-scale=1.0" />

	<%-- Meta Content --%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="description" content="${metaDescription}"/>
	<meta name="keywords" content="${metaKeywords}"/>
	<meta name="robots" content="${metaRobots}"/>

	<%-- Favourite Icon --%>
	<spring:theme code="img.favIcon" text="/" var="favIconPath"/>
	<c:url value="${favIconPath}" var="faviconURL" />
	<link rel="shortcut icon" href="${faviconURL}" type="image/x-icon"/>

	<%-- CSS Files Are Loaded First as they can be downloaded in parallel --%>
	<template:styleSheets/>

	<%-- Inject any additional CSS required by the page --%>
	<jsp:invoke fragment="pageCss"/>

	<analytics:googleAnalytics/>
	<analytics:jirafe/>
</head>

<cms:body liveEditCssPath="${commonResourcePath}/css/hybris.cms.live.edit.css" liveEditJsPath="${commonResourcePath}/js/hybris.cms.live.edit.js">

	<%-- Load JavaScript required by the site --%>
	<template:javaScript/>

	<%-- Inject any additional JavaScript required by the page --%>
	<jsp:invoke fragment="pageScripts"/>

	<%-- Inject the page body here --%>
	<jsp:doBody/>

	<%-- AddOn JavaScript files --%>
	<c:forEach items="${addOnJavaScriptPaths}" var="addOnJavaScript">
	    <script type="text/javascript" src="${addOnJavaScript}"></script>
	</c:forEach>

</cms:body>

<debug:debugFooter/>

</html>
