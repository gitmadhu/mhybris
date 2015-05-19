<%-- CHINAACC:NEWFILE --%>
<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="store" required="false" type="de.hybris.platform.commercefacades.storelocator.data.PointOfServiceData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<div class="cityStoresList">
<ycommerce:testId code="storeFinder_result_link">
	<ul id="cityStores">
	<%--
		<li>
			<p><strong>Store Name</strong></p>
			<p>Store Address‰</p>
			<p>Store Telephone</p>
		</li>
		 --%>
	</ul>
</ycommerce:testId>
</div>