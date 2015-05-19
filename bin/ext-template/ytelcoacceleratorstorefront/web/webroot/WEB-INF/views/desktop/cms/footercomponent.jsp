<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>
<div id="footer">
	<div class="Fa">
		<c:forEach items="${navigationNodes}" var="node">
			<div class="Fa col">
				<div class="Fb">
					<h3>${node.title}</h3>
					<c:forEach items="${node.links}" step="${component.wrapAfter}" varStatus="i">
				
							<ul class="Fc ${i.count < 2 ? 'left_col' : 'right_col'}">
								<c:forEach items="${node.links}" var="childlink" begin="${i.index}" end="${i.index + component.wrapAfter - 1}">
									<li class="Fc ${i.count < 2 ? 'left_col' : 'right_col'}">
										<component:cmsLinkComponent component="${childlink}"   />
									</li>
								</c:forEach>
							</ul>
						
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
    <div id="copyright">
		<p>${notice}</p>
	</div>
</div>

