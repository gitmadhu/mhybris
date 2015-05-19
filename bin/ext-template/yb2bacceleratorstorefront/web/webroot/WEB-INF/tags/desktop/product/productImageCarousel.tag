<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="galleryImages" required="true" type="java.util.List" %>


<div class="scroller">
		<ul id="carousel_alternate" class="jcarousel-skin alt">
			<c:forEach items="${galleryImages}" var="container" varStatus="varStatus">
				<li>
					<span class="thumb">
						<a href="#">
							<img src="${container.thumbnail.url}" data-primaryimagesrc="${container.product.url}" data-galleryposition="${varStatus.index}" alt="${product.name}" title="${product.name}" />
						</a>
					</span>
				</li>
			</c:forEach>
		</ul>
	</div>