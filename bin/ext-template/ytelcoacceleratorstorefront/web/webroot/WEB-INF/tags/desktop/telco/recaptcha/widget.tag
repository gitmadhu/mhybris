<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<div id="recaptcha_widget" style="display:none"  data-recaptcha-public-key="${requestScope.recaptchaPublicKey}">
	<c:if test="${requestScope.recaptchaChallangeAnswered == false}">
		<span class="form_field_error">
	</c:if>

	<div id="recaptcha_image" class="left"></div>
	<div class="left">
		<a href="javascript:Recaptcha.reload()" class="cicon reload"></a>
		<div class="recaptcha_only_if_image"><a href="javascript:Recaptcha.switch_type('audio')" class="cicon audio"></a></div>
		<div class="recaptcha_only_if_audio"><a href="javascript:Recaptcha.switch_type('image')" class="cicon image"></a></div>
	</div>

	<div class="recaptcha_only_if_incorrect_sol" style="color:red">Incorrect please try again</div>

	<dt>
		<span class="recaptcha_only_if_image">Enter the words above:</span>
		<span class="recaptcha_only_if_audio">Enter the numbers you hear:</span>
	</dt>
	
	<dd>
		<input type="text" id="recaptcha_response_field" name="recaptcha_response_field" class="left" />
		<a href="javascript:Recaptcha.showhelp()" class="cicon help left" ></a>
	</dd>


	<c:if test="${requestScope.recaptchaChallangeAnswered == false}">
		</span>
	</c:if>
</div>
