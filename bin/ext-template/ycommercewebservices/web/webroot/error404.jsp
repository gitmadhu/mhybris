<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  ~ [y] hybris Platform
  ~
  ~ Copyright (c) 2000-2014 hybris AG
  ~ All rights reserved.
  ~
  ~ This software is the confidential and proprietary information of hybris
  ~ ("Confidential Information"). You shall not disclose such Confidential
  ~ Information and shall use it only in accordance with the terms of the
  ~ license agreement you entered into with hybris.
  --%>
<c:choose>
    <c:when test="${header.accept=='application/xml'}">
<% response.setContentType("application/xml"); %>
<?xml version='1.0' encoding='UTF-8'?>
<errors>
   <error>
      <message>There is no resource for path ${requestScope['javax.servlet.forward.request_uri']}</message>
      <type>UnknownResourceError</type>
   </error>
</errors>
</c:when>
    <c:otherwise><% response.setContentType("application/json"); %>{
   "errors" : [ {
      "message": "There is no resource for path ${requestScope['javax.servlet.forward.request_uri']}",
      "type": "UnknownResourceError"
   } ]
}
</c:otherwise>
</c:choose>
