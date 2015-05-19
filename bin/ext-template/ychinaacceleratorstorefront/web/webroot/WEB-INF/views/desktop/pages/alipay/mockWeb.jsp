<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>hybris Accelerator Alipay Payment Mock</title>
</head>
<body style="font-family: arial;">

	<img alt="logo" src="/ychinaacceleratorstorefront/_ui/desktop/common/images/mock/logo-hybris_zh.png" />

	<h2>Accelerator Alipay Payment Mock</h2>
	<h4>Transferred parameters and values</h4>

	<table border="0" cellspacing="2" cellpadding="1">
		<c:forEach var="var" items="${params}">
			<tr>
				<td nowrap="nowrap" align="right">${var.key}:</td>
				<td nowrap="nowrap">${var.value}</td>
			</tr>
		</c:forEach>
	</table>


	<p />
	<h4>
		Signature:
		<c:choose>
			<c:when test="${signIsValid}">
				<span style="color: green; font-size: 200%">VALID</span>
			</c:when>
			<c:otherwise>
				<span style="color: red; font-size: 200%">INVALID</span>
			</c:otherwise>
		</c:choose>
	</h4>

	<form action="${basePath}alipay/mock/gateway.do" method="POST">
		<c:forEach var="var" items="${params}">
			<input type="hidden" name="${var.key}" value="${var.value}" />
		</c:forEach>

		<table>
			<tr>
				<td>
					<h4>Trade Status:</h4>
				</td>
				<td><select title="trade_status" name="trade_status">
						<option value="" />
						<option value="WAIT_BUYER_PAY">WAIT_BUYER_PAY: Transaction awaits user payment</option>
						<option value="TRADE_PENDING">TRADE_PENDING: Pending Transaction</option>
						<option value="TRADE_SUCCESS">TRADE_SUCCESS: Transaction complete, and available for refund</option>
						<option value="TRADE_FINISHED">TRADE_FINISHED: Transaction success (passed expire date), not refundable</option>
						<option value="TRADE_CLOSED">TRADE_CLOSED: Unpaid transactions closed after a period of time, Transactions closed after a full refund</option>
				</select></td>
			<tr>
				<td>
					<h4>Error Code:</h4>
				</td>
				<td><select title="error_Code" name="error_code">
						<option value="" />
						<option value="SELLER_NOT_IN_SPECIFIED_SELLERS">SELLER_NOT_IN_SPECIFIED_SELLERS</option>
						<option value="TRADE_SELLER_NOT_MATCH">TRADE_SELLER_NOT_MATCH</option>
						<option value="TRADE_BUYER_NOT_MATCH">TRADE_BUYER_NOT_MATCH</option>
						<option value="ILLEGAL_FEE_PARAM">ILLEGAL_FEE_PARAM</option>
						<option value="SUBJECT_MUST_NOT_BE_NULL">SUBJECT_MUST_NOT_BE_NULL</option>
						<option value="TRADE_PRICE_NOT_MATCH">TRADE_PRICE_NOT_MATCH</option>
						<option value="TRADE_QUANTITY_NOT_MATCH">TRADE_QUANTITY_NOT_MATCH</option>
						<option value="TRADE_TOTALFEE_NOT_MATCH">TRADE_TOTALFEE_NOT_MATCH</option>
						<option value="TRADE_NOT_ALLOWED_PAY">TRADE_NOT_ALLOWED_PAY</option>
						<option value="DIRECT_PAY_WITHOUT_CERT_CLOSE">DIRECT_PAY_WITHOUT_CERT_CLOSE</option>
						<option value="FAIL_CREATE_CASHIER_PAY_ORDER">FAIL_CREATE_CASHIER_PAY_ORDER</option>
						<option value="ILLEGAL_EXTRA_COMMON_PARAM">ILLEGAL_EXTRA_COMMON_PARAM</option>
						<option value="ILLEGAL_PAYMENT_TYPE">ILLEGAL_PAYMENT_TYPE</option>
						<option value="NOT_SUPPORT_GATEWAY">NOT_SUPPORT_GATEWAY</option>
						<option value="BUYER_SELLER_EQUAL">BUYER_SELLER_EQUAL</option>
						<option value="SELLER_NOT_EXIST">SELLER_NOT_EXIST</option>
						<option value="ILLEGAL_ARGUMENT">ILLEGAL_ARGUMENT</option>
						<option value="TRADE_NOT_FOUND">TRADE_NOT_FOUND</option>
						<option value="TRADE_GOOD_INFO_NOT_FOUND">TRADE_GOOD_INFO_NOT_FOUND</option>
						<option value="BUYER_EMAIL_ID_MUST_NULL">BUYER_EMAIL_ID_MUST_NULL</option>
						<option value="PRODUCT_NOT_ALLOWED">PRODUCT_NOT_ALLOWED</option>
						<option value="ROYALTY_RECEIVER_NOT_IN_SPECIFIED_ACCOUNTS">ROYALTY_RECEIVER_NOT_IN_SPECIFIED_ACCOUNTS</option>
						<option value="ROYALTY_LENGTH_ERROR">ROYALTY_LENGTH_ERROR</option>
						<option value="ILLEGAL_EXTER_INVOKE_IP">ILLEGAL_EXTER_INVOKE_IP</option>
						<option value="HAS_NO_PRIVILEGE">HAS_NO_PRIVILEGE</option>
						<option value="DEFAULT_BANK_INVALID">DEFAULT_BANK_INVALID</option>
						<option value="DIS_NOT_SIGN_PROTOCOL">DIS_NOT_SIGN_PROTOCOL</option>
						<option value="SELF_TIMEOUT_NOT_SUPPORT">SELF_TIMEOUT_NOT_SUPPORT</option>
						<option value="ILLEGAL_OUTTIME_ARGUMENT">ILLEGAL_OUTTIME_ARGUMENT</option>
						<option value="EBANK_CERDIT_GW_RULE_NOT_OPEN">EBANK_CERDIT_GW_RULE_NOT_OPEN</option>
						<option value="DIRECTIONAL_PAY_FORBIDDEN">DIRECTIONAL_PAY_FORBIDDEN</option>
						<option value="SELLER_ENABLE_STATUS_FORBID">SELLER_ENABLE_STATUS_FORBID</option>
						<option value="ROYALTY_SELLER_ENABLE_STATUS_FORBID">ROYALTY_SELLER_ENABLE_STATUS_FORBID</option>
						<option value="ROYALTY_SELLER_NOT_CERTIFY">ROYALTY_SELLER_NOT_CERTIFY</option>
						<option value="ROYALTY_FORAMT_ERROR">ROYALTY_FORAMT_ERROR</option>
						<option value="ROYALTY_TYPE_ERROR">ROYALTY_TYPE_ERROR</option>
						<option value="ROYALTY_RECEIVE_EMAIL_NOT_EXIST">ROYALTY_RECEIVE_EMAIL_NOT_EXIST</option>
						<option value="ROYALTY_RECEIVE_EMAIL_NOT_CERTIFY">ROYALTY_RECEIVE_EMAIL_NOT_CERTIFY</option>
						<option value="ROYALTY_PAY_EMAIL_NOT_EXIST">ROYALTY_PAY_EMAIL_NOT_EXIST</option>
						<option value="TAOBAO_ANTI_PHISHING_CHECK_FAIL">TAOBAO_ANTI_PHISHING_CHECK_FAIL</option>
						<option value="SUBJECT_HAS_FORBIDDENWORD">SUBJECT_HAS_FORBIDDENWORD</option>
						<option value="PAY_CHECK_FAIL">PAY_CHECK_FAIL</option>
						<option value="BODY_HAS_FORBIDDENWORD">BODY_HAS_FORBIDDENWORD</option>
						<option value="NEED_CTU_CHECK_PARAMETER_ERROR">NEED_CTU_CHECK_PARAMETER_ERROR</option>
						<option value="NEED_CTU_CHECK_NOT_ALLOWED">NEED_CTU_CHECK_NOT_ALLOWED</option>
						<option value="BUYER_NOT_EXIST">BUYER_NOT_EXIST</option>
						<option value="ILLEGAL_SIGN">ILLEGAL_SIGN</option>
						<option value="ILLEGAL_DYN_MD5_KEY">ILLEGAL_DYN_MD5_KEY</option>
						<option value="ILLEGAL_ENCRYPT">ILLEGAL_ENCRYPT</option>
						<option value="ILLEGAL_ARGUMENT">ILLEGAL_ARGUMENT</option>
						<option value="ILLEGAL_SERVICE">ILLEGAL_SERVICE</option>
						<option value="ILLEGAL_PARTNER">ILLEGAL_PARTNER</option>
						<option value="ILLEGAL_EXTERFACE">ILLEGAL_EXTERFACE</option>
						<option value="ILLEGAL_PARTNER_EXTERFACE">ILLEGAL_PARTNER_EXTERFACE</option>
						<option value="ILLEGAL_SECURITY_PROFILE">ILLEGAL_SECURITY_PROFILE</option>
						<option value="ILLEGAL_AGENT">ILLEGAL_AGENT</option>
						<option value="ILLEGAL_SIGN_TYPE">ILLEGAL_SIGN_TYPE</option>
						<option value="ILLEGAL_CHARSET">ILLEGAL_CHARSET</option>
						<option value="ILLEGAL_CLIENT_IP">ILLEGAL_CLIENT_IP</option>
						<option value="ILLEGAL_DIGEST">ILLEGAL_DIGEST</option>
						<option value="ILLEGAL_DIGEST_TYPE">ILLEGAL_DIGEST_TYPE</option>
						<option value="ILLEGAL_NUMBER_FORMAT">ILLEGAL_NUMBER_FORMAT</option>
						<option value="ILLEGAL_FILE_FORMAT">ILLEGAL_FILE_FORMAT</option>
						<option value="ILLEGAL_ENCODING">ILLEGAL_ENCODING</option>
						<option value="EXTERFACE_IS_CLOSED">EXTERFACE_IS_CLOSED</option>
						<option value="ILLEGAL_REQUEST_REFERER">ILLEGAL_REQUEST_REFERER</option>
						<option value="ILLEGAL_ANTI_PHISHING_KEY">ILLEGAL_ANTI_PHISHING_KEY</option>
						<option value="ANTI_PHISHING_KEY_TIMEOUT">ANTI_PHISHING_KEY_TIMEOUT</option>
						<option value="ILLEGAL_INTEGER_FORMAT">ILLEGAL_INTEGER_FORMAT</option>
						<option value="ILLEGAL_MONEY_FORMAT">ILLEGAL_MONEY_FORMAT</option>
						<option value="ILLEGAL_DATA_FORMAT">ILLEGAL_DATA_FORMAT</option>
						<option value="REGEXP_MATCH_FAIL">REGEXP_MATCH_FAIL</option>
						<option value="ILLEGAL_LENGTH">ILLEGAL_LENGTH</option>
						<option value="PARAMTER_IS_NULL">PARAMTER_IS_NULL</option>
						<option value="LOGIN_USER_TYPE_MUST_A">LOGIN_USER_TYPE_MUST_A</option>
						<option value="SERVICE_NOT_ALLOWED">SERVICE_NOT_ALLOWED</option>
						<option value="SESSION_TIMEOUT">SESSION_TIMEOUT</option>
						<option value="SYSTEM_ERROR">SYSTEM_ERROR</option>
						<option value="ILLEGAL_TARGET_SERVICE">ILLEGAL_TARGET_SERVICE</option>
						<option value="ILLEGAL_ACCESS_SWITCH_SYSTEM">ILLEGAL_ACCESS_SWITCH_SYSTEM</option>
						<option value="ILLEGAL_SWITCH_SYSTEM">ILLEGAL_SWITCH_SYSTEM</option>
				</select></td>
			</tr>
		</table>

		<input type="submit" name="action" value="notify" /> 
		<input type="submit" name="action" value="notify_error" /> 
		<input type="submit" name="action" value="return" />

	</form>
	<p />
</html>