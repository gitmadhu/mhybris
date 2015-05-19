<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:theme code="payment.alipay.wait"/></title>
<script type="text/javascript">
	function gotoAlipay() {
		window.location.reload();
	}	
</script>
</head>
<body onload="setInterval(gotoAlipay, 3000)">
<h1><spring:theme code="payment.alipay.wait"/></h1>
<script type="text/javascript"></script>
</body>
</html>