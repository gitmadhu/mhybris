<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>


<div id="footer">
	
<c:forEach items="${navigationNodes}" var="node">
	<c:if test="${node.visible}">
		<div class="links">
			<h3>${node.title}</h3></li>
			<c:forEach items="${node.links}" step="${component.wrapAfter}" varStatus="i">
				<ul class="Fc ${i.count < 2 ? 'left_col' : 'right_col'}">
					<c:forEach items="${node.links}" var="childlink" begin="${i.index}" end="${i.index + component.wrapAfter - 1}">
						<cms:component component="${childlink}" evaluateRestriction="true" element="li" class="Fc ${i.count < 2 ? 'left_col' : 'right_col'}"/>
					</c:forEach>
				</ul>
			</c:forEach>
		</div>
	</c:if>
</c:forEach>

</div>
<div class="copyright">${notice}</div>
