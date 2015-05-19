<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="errorNoResults" required="true" type="java.lang.String" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<div class="item_container_holder">
    <div class="title_holder">
        <div class="title">
            <div class="title-top">
                <span></span>
            </div>
        </div>
        <h2><spring:theme code="storeFinder.find.a.store"/></h2>
    </div>
    <div class="item_container">
        <p><spring:theme code="storeFinder.use.this.form"/></p>
        <c:url value="/store-finder" var="storeFinderFormAction"/>
        <form:form action="${storeFinderFormAction}" method="get" commandName="storeFinderForm">
            <dl>
                <ycommerce:testId code="storeFinder_search_box">
                    <formElement:formInputBox idKey="storelocator.query"
                                              labelKey="storelocator.query" path="q" inputCSS="text"
                                              mandatory="true"/>
                    <button class="form search">
						<span class="search-icon">
							<spring:theme code="storeFinder.search"/>
						</span>
                    </button>
                </ycommerce:testId>
            </dl>
        </form:form>
    </div>
</div>
