<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<store:storeSearch errorNoResults="${errorNoResults}"/>
<store:storesMap storeSearchPageData="${searchPageData}"/>
<store:storeListForm searchPageData="${searchPageData}" locationQuery="${locationQuery}" numberPagesShown="${numberPagesShown}" geoPoint="${geoPoint}"/>

