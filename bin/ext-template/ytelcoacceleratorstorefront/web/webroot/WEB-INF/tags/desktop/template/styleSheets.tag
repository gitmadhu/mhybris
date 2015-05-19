<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- colorbox CSS --%>
<link rel="stylesheet" type="text/css" media="screen" href="${commonResourcePath}/css/jquery.colorbox-1.3.16.css"/>

<%-- BeautyTips CSS --%>
<link rel="stylesheet" type="text/css" media="screen" href="${commonResourcePath}/css/jquery.bt-0.9.5.css" />

<%-- blueprintcss --%>
<link rel="stylesheet" href="${commonResourcePath}/blueprint/screen.css" type="text/css" media="screen, projection" />

<%-- <link rel="stylesheet" href="${commonResourcePath}/blueprint/print.css" type="text/css" media="print" /> --%>
<style type="text/css" media="print">
	@IMPORT url("${commonResourcePath}/blueprint/print.css");
</style>

<%-- jQuery UI CSS --%>
<link rel="stylesheet" type="text/css" media="screen" href="${commonResourcePath}/css/jquery.ui.stars-3.0.1.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${commonResourcePath}/css/jquery.ui.autocomplete-1.8.18.css" />

<%-- our site css --%>
<link rel="stylesheet" type="text/css" media="screen" href="${commonResourcePath}/css/common.css" />
<!--[if IE 8]> <link type="text/css" rel="stylesheet" href="${commonResourcePath}/css/ie_8.css" media="screen, projection" /> <![endif]-->
<!--[if IE 7]> <link type="text/css" rel="stylesheet" href="${commonResourcePath}/css/ie_7.css" media="screen, projection" /> <![endif]-->

<%-- theme specific css --%>
<link rel="stylesheet" type="text/css" media="screen" href="${themeResourcePath}/css/changes.css" />
<!--[if IE 8]> <link type="text/css" rel="stylesheet" href="${themeResourcePath}/css/ie_8.css" media="screen, projection" /> <![endif]-->
<!--[if IE 7]> <link type="text/css" rel="stylesheet" href="${themeResourcePath}/css/ie_7.css" media="screen, projection" /> <![endif]-->

<!-- telco specific css addon -->
<link rel="stylesheet" type="text/css" media="screen" href="${themeResourcePath}/../theme-blue-telco-extension/css/changes.css" />
<!--[if IE 7]> <link type="text/css" rel="stylesheet" href="${themeResourcePath}/../theme-blue-telco-extension/css/ie_7.css" media="screen, projection" /> <![endif]-->
<!--[if IE 8]> <link type="text/css" rel="stylesheet" href="${themeResourcePath}/../theme-blue-telco-extension/css/ie_8.css" media="screen, projection" /> <![endif]-->


<%--  AddOn Common CSS files --%>
<c:forEach items="${addOnCommonCssPaths}" var="addOnCommonCss">
    <link rel="stylesheet" type="text/css" media="all" href="${addOnCommonCss}" />
</c:forEach>

<%--  AddOn Theme CSS files --%>
<c:forEach items="${addOnThemeCssPaths}" var="addOnThemeCss">
    <link rel="stylesheet" type="text/css" media="all" href="${addOnThemeCss}" />
</c:forEach>