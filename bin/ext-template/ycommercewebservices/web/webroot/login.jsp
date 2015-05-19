<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
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
    <title>Sign in &middot; hybris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
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
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
  </head>

  <body>

    <div class="container">

      <form id="loginForm" name="loginForm" class="form-signin" action="<c:url value="/login.do"/>" method="post">
      
		<c:if test="${not empty param.authentication_error}">
			 <div class="alert alert-error">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong>Woops!</strong> Your login attempt was not successful.
			</div>
		</c:if>
		
		<c:if test="${not empty param.authorization_error}">
			 <div class="alert alert-error">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong>Woops!</strong> You are not permitted to access that resource.
			</div>
		</c:if>      

    
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="text" name="j_username" class="input-block-level" placeholder="Email address">
        <input type="password" name="j_password" class="input-block-level" placeholder="Password">
        <input type="submit" class="btn btn-large btn-primary" type="submit" value="Sign in"/>
      </form>

    </div> <!-- /container -->

   <script src="<%=request.getContextPath()%>/static/bootstrap/js/jquery-1.8.3.min.js"></script>
   <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.min.js"></script>
   
   
  </body>
</html>
