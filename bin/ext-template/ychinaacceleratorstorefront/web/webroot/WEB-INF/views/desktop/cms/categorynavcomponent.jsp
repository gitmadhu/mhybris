<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="product_list_box">
	<h2><spring:theme code="text.headline.productcategories" /></h2>
	<div class="product_list_box_inner product_list_box_inner1">
		<c:if test="${! empty categoryData }">
		<ul>
<c:forEach items="${categoryData}" var="category" varStatus="status">
			<li>
				<a href="${contextPath}${category.url}">${category.name}</a>
				<c:if test="${! empty category.categories}">
				<ul>
	<c:forEach items="${category.categories}" var="cat" varStatus="catStatus">
					<li>
						<a href="${contextPath}${cat.url}">${cat.name}</a>
					</li>
	</c:forEach>
				</ul>
				</c:if>
			</li>
</c:forEach>
		</ul>
		</c:if>
	</div>
</div>
