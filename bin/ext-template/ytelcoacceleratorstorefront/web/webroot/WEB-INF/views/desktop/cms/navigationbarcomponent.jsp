<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>

<c:set value="${component.styleClass} ${dropDownLayout}" var="bannerClasses"/>
<li class="La ${bannerClasses}">
	<component:cmsLinkComponent component="${component.link}"/>
	<c:if test="${not empty component.navigationNode.children}">
		<ul class="Lb">
			<c:forEach items="${component.navigationNode.children}" var="child">
				<li class="Lb">
					<span class="nav-submenu-title">${child.title}</span>
					<c:forEach items="${child.links}" step="${component.wrapAfter}" varStatus="i">
						<ul class="Lc ${i.count < 2 ? 'left_col' : 'right_col'}">
							<c:forEach items="${child.links}" var="childlink" begin="${i.index}" end="${i.index + component.wrapAfter - 1}">
								<li class="Lc ${i.count < 2 ? 'left_col' : 'right_col'}">
										<component:cmsLinkComponent component="${childlink}" />
								</li>
							</c:forEach>
						</ul>
					</c:forEach>
				</li>
			</c:forEach>
		</ul>
	</c:if>
</li>