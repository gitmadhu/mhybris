<%@ page import="org.springframework.security.core.AuthenticationException" %>
<%@ page import="org.springframework.security.oauth2.common.exceptions.UnapprovedClientAuthenticationException" %>
<%@ page import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter" %>
<%@ taglib prefix="authz" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

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

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Access Confirmation &middot; hybris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .authorize {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      
      form {
      	display: inline;	
      }
      

    </style>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
  </head>

  <body>

    <div class="container">

      <div class="authorize">
      
	    <% if (session.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY) != null && !(session.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY) instanceof UnapprovedClientAuthenticationException)) { %>
	      <div class="error">
		 <div class="alert alert-error">
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		  <strong>Woops!</strong> Access could not be granted. (<%= ((AuthenticationException) session.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY)).getMessage() %>)
		</div>	        
	    <% } %>
	    <c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION"/>      
      
    	<authz:authorize ifAllGranted="ROLE_CUSTOMERGROUP">      
      
	        <h2 class="form-authorize-heading">Please confirm</h2>  
			<p>You hereby authorize <strong><c:out value="${client.clientId}"/></strong> to access your protected resources.</p>
	
		      <form id="denialForm" name="denialForm" action="<%=request.getContextPath()%>/oauth/authorize" method="post">
		        <input name="user_oauth_approval" value="false" type="hidden"/>
		        <input name="deny" class="btn btn-large" value="Deny" type="submit">
		      </form>
		      <form id="confirmationForm" name="confirmationForm" action="<%=request.getContextPath()%>/oauth/authorize" method="post">
		        <input name="user_oauth_approval" value="true" type="hidden"/>
		        <input name="authorize" class="btn btn-large btn-primary" value="Authorize" type="submit">
		      </form>
	        
		</authz:authorize> 

      </div>

    </div> <!-- /container -->

   <script src="<%=request.getContextPath()%>/static/bootstrap/js/jquery-1.8.3.min.js"></script>
   <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.min.js"></script>
    
   
  </body>
</html>
