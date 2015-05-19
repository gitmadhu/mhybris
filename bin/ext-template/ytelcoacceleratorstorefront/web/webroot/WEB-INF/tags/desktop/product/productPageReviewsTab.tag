<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
/*<![CDATA[*/
	var showReviewForm = <c:out value="${showReviewForm}" default="false"/>;
/*]]>*/
</script>

<c:url value="${product.url}/reviewhtml/3" var="getPageOfReviewsUrl"/>
<c:url value="${product.url}/reviewhtml/all" var="getAllReviewsUrl"/>

<script type="text/javascript">
/*<![CDATA[*/
           
    function showReviewsAction() {
    	$.get("${getPageOfReviewsUrl}", function(result){
	    	$('#reviews').html(result);
	    	$('#show_all_reviews_action').click(function(e){
				e.preventDefault();
				$.get("${getAllReviewsUrl}", function(result){
			    	$('#reviews').html(result);
			    	$('#show_all_reviews_action').hide();
			    	$('#write_review_action').click(function(e){
						e.preventDefault();
						$('#reviews').hide();
						$('#write_reviews').show();
					});
			  	});
			});
	    	$('#write_review_action').click(function(e){
				e.preventDefault();
				$('#reviews').hide();
				$('#write_reviews').show();
				$('#reviewForm input[name=headline]').focus();
			});
	    });
	}
	
	$(document).ready(function() {
		$('#read_reviews_action').click(function(e){
			e.preventDefault();
			showReviewsAction();
	    	$('#reviews').show();
			$('#write_reviews').hide();
		});
		
		$(".tab_03").click(function() {
			showReviewsAction();
	  	});
		
		$('#write_review_action').click(function(e){
			e.preventDefault();
			$('#reviews').hide();
			$('#write_reviews').show();
			$('#reviewForm input[name=headline]').focus();
		});
    	if(showReviewForm) {
    		$('#reviews').hide();
			$('#write_reviews').show();
    	}
		$("#stars-wrapper").stars({
			inputType: "select"
		});
		
		/* Telko change */
		$('#stars-wrapper div').each(function(index) {
		    $(this).attr('tabindex', 0)
		});
		$('div#stars-wrapper div.ui-stars-star').focusin(function() {  
        	$(this).addClass("ui-stars-star-hover");
	        return false;
        });
        $('div#stars-wrapper').focusout(function() {  
        	$('div.ui-stars-star').removeClass("ui-stars-star-hover");
        });
        $('div.ui-stars-star').keypress(function(e) {
            var keyCode;
            if (window.event) keyCode = window.event.keyCode;
            else if(e) keyCode = e.which;
            else return true;
            if (keyCode == 13 || keyCode == 32) {
                $(this).click();
                $(this).addClass("ui-stars-star-on");
                return false;
            } else return true;
        });        
        $('.ui-stars-cancel').keypress(function(e) {
            var keyCode;
            if (window.event) keyCode = window.event.keyCode;
            else if(e) keyCode = e.which;
            else return true;
            if (keyCode == 13 || keyCode == 32) {
                $(this).click();
                $(this).addClass("ui-stars-cancel-disabled").css({"opacity":"0.5"});
                return false;
            } else return true;
        });
		/* End Telko change */
		
	});
/*]]>*/
</script>

<div id="reviews"></div>

<div id="write_reviews" style="display:none">
	<ul class="review_actions">
		<li><a href="#" id="read_reviews_action"><spring:theme code="review.back"/></a></li>
	</ul>
	<div class="write_review">
		<h3><spring:theme code="review.write.title"/></h3>
		<p><spring:theme code="review.write.description"/></p>
		<p><spring:theme code="review.required"/></p>

		<c:url value="${product.url}/review" var="productReviewActionUrl"/>
		<form:form method="post" action="${productReviewActionUrl}" commandName="reviewForm">
			<dl>
				<formElement:formInputBox idKey="review.headline" labelKey="review.headline" path="headline" inputCSS="text" mandatory="true"/>
				<formElement:formTextArea idKey="review.comment" labelKey="review.comment" path="comment" areaCSS="textarea" mandatory="true"/>
				<spring:bind path="rating">
					<c:if test="${not empty status.errorMessages}">
						<span class="form_field_error">
					</c:if>
					<dt><span><spring:theme code="review.rating"/>*:</span></dt>
					<dd></dd>					
					<div id="stars-wrapper" path="rating">
						<form:select path="rating" >
							<form:option value='1'>1/5</form:option>
							<form:option value='2'>2/5</form:option>
							<form:option value='3'>3/5</form:option>
							<form:option value='4'>4/5</form:option>
							<form:option value='5'>5/5</form:option>
						</form:select>
					</div>							
					<p><form:errors path="rating" /></p>
					<c:if test="${not empty status.errorMessages}">
						</span>
					</c:if>
					</spring:bind>
					<dt><label for="alias"><spring:theme code="review.alias"/>:</label></dt>
				<dd><form:input path="alias" /></dd>
			</dl>
			<div style="clear:both;"></div>
			<span style="display: block; clear: both;">
				<button class="form" type="submit" value="<spring:theme code="review.submit"/>"><spring:theme code="review.submit"/></button>
			</span>
		</form:form>
	</div>
</div>
