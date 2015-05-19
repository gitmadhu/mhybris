<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="languages" required="true" type="java.util.Collection" %>
<%@ attribute name="currentLanguage" required="true" type="de.hybris.platform.commercefacades.storesession.data.LanguageData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<c:if test="${fn:length(languages) > 1}">
	<script type="text/javascript">
	/*<![CDATA[*/
		$(document).ready(function() {
			$('#lang-selector').change(function() {
					$('#lang-form').submit();
				})
			}
		);
	/*]]>*/
	</script>
	<c:url value="/_s/language" var="setLanguageActionUrl"/>
	<form:form action="${setLanguageActionUrl}" method="post" id="lang-form">
		<spring:theme code="text.language" var="languageText"/>
		<label class="skip" for="lang-selector">${languageText}</label>
		<ycommerce:testId code="header_language_select">
			<select name="code" id="lang-selector">
				<c:forEach items="${languages}" var="lang">
					<c:choose>
						<c:when test="${lang.isocode == currentLanguage.isocode}">
							<option value="${lang.isocode}" selected="selected" lang="${lang.isocode}">
								${lang.nativeName}
							</option>
						</c:when>
						<c:otherwise>
							<option value="${lang.isocode}" lang="${lang.isocode}">
								${lang.nativeName} <%-- (${lang.name}) --%>
							</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</ycommerce:testId>
	</form:form>
</c:if>