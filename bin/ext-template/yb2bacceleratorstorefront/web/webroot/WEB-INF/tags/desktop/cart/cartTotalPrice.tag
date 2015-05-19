<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<%@ attribute name="totalPrice" required="true" type="de.hybris.platform.commercefacades.product.data.PriceData"%>

<span class="cart_total">
	<span><spring:theme text="Total:" code="basket.page.total" /></span> 
	<span><format:price priceData="${totalPrice}" /></span>
</span>