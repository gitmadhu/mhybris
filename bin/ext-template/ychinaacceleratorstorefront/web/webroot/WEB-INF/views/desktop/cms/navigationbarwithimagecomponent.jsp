<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>

<c:set value="${component.styleClass} ${dropDownLayout}" var="bannerClasses"/>
<li class="La ${bannerClasses}">
	<cms:component component="${component.link}" evaluateRestriction="true"/>
	<c:if test="${not empty component.navigationNode.children}">
		<ul class="Lb">
			<c:forEach items="${component.navigationNode.children}" var="child">
				<c:if test="${child.visible}">
					<li class="Lb">
						<!-- <span class="nav-submenu-title">${child.title}</span> -->
						<c:forEach items="${child.links}" step="${component.wrapAfter}" varStatus="i">
							<ul class="Lc ${i.count < 2 ? 'left_col' : 'right_col'}">
								<c:forEach items="${child.links}" var="childlink" begin="${i.index}" end="${i.index + component.wrapAfter - 1}">
									<cms:component component="${childlink}" evaluateRestriction="true" element="li" class="Lc ${i.count < 2 ? 'left_col' : 'right_col'}"/>
								</c:forEach>
							</ul>
						</c:forEach>
						<ul class="Lc right_col">

							<c:url value="${component.imageLink.url}" var="encodedUrl" />
							<c:choose>
								<c:when test="${empty encodedUrl || encodedUrl eq '#'}">
									<img title="${component.image.altText}" alt="${component.image.altText}" src="${component.image.url}">
								</c:when>
								<c:otherwise>
									<a href="${encodedUrl}"><img title="${component.image.altText}" alt="${component.image.altText}" src="${component.image.url}"></a> 
								</c:otherwise>
							</c:choose>

							<!-- <img title="blablaheadline" alt="blablaalttext" src="${component.image.url}">
							<cms:component component="${component.imageLink}"/> -->
							
							<!-- <cms:component component="${component.imageLink}">TESTEXAMPLE</cms:component> -->
							
						</ul>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</c:if>
</li>