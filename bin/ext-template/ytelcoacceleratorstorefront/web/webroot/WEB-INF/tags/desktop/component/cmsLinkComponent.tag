<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%--
 Custom Tag to support the CMSLinkComponent.
 This is called instead of using the <cms:component> tag.
--%>
<%@ attribute name="component" required="true" type="de.hybris.platform.cms2.model.contents.components.CMSLinkComponentModel" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<c:url value="${ycommerce:cmsLinkComponentUrl(component, request)}" var="encodedUrl" />
<a href="${encodedUrl}" name="${component.linkName}" target="${component.target == null || component.target == 'SAMEWINDOW' ? '' : '_new'}">${component.linkName}</a>