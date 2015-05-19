<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>

<div class="dashboard dashboard-empty">
		<div class="dashboard-item <c:if test="${type eq 'DeviceModel'}">dashboard-item-active</c:if> dashboard-empty-DeviceModel">
			<div class="dashboard-headline">
			<c:if test="${type eq 'DeviceModel'}"><span class="hidden">No device selected yet - Active Tab: </span></c:if>
				<spring:theme code="guidedselling.dashboard.step.DeviceModel"/> 
			</div>
		</div>					
		<div class="dashboard-item <c:if test="${type eq 'ServicePlanModel' or type eq 'DeviceModel'}">dashboard-item-active</c:if> dashboard-empty-ServicePlanModel">
			<div class="dashboard-headline">
				<c:if test="${type eq 'ServicePlanModel' or type eq 'DeviceModel'}"><span class="hidden">No service plan selected yet - Active Tab: </span></c:if>
				<spring:theme code="guidedselling.dashboard.step.ServicePlanModel"/>
			</div>
		</div>					
		<div class="dashboard-item dashboard-empty-ServiceAddOnModel">
			<div class="dashboard-headline">
				<span class="hidden">No service add-ons selected yet</span>
				<spring:theme code="guidedselling.dashboard.step.ServiceAddOnModel"/> 
			</div>
		</div>					
</div>