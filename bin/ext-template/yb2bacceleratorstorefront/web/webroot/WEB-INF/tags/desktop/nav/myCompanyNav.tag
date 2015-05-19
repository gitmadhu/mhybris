<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="selected" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>




<div id="companyNav" class="span-4">
		<div class="headline"><spring:theme code="text.company.myCompany" text="My Company"/></div>
			<ul>
				<li class='${selected eq 'organizationManagement' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_organizationManagement_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.organizationManagement" text="Organization Management"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'budgets' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/manage-budgets/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_budgets_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.manageBudgets" text="Manage Budgets"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'costCenters' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/manage-costcenters/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_costCenters_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.manageCostCenters" text="Manage Cost Centers"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'units' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/manage-units/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_units_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.manage.units" text="Manage Business Units"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'users' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/manage-users/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_users_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.manageUsers" text="Manage Users"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'manageUsergroups' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/manage-usergroups/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_usergroups_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.manageUsergroup" text="Manage Usergroups"/></a>
					</ycommerce:testId>
				</li>
				<li class='${selected eq 'managePermissions' ? 'active' : ''}'>
					<c:url value="/my-company/organization-management/manage-permissions/" var="encodedUrl" />
					<ycommerce:testId code="myCompany_orderThresholds_navLink">
						<a href="${encodedUrl}"><spring:theme code="text.company.managePermissions" text="Manage Permissions"/></a>
					</ycommerce:testId>
				</li>
			</ul>
	
	<cms:pageSlot position="SideContent" var="feature" element="div" class="span-4 side-content-slot cms_disp-img_slot">
		<cms:component component="${feature}"/>
	</cms:pageSlot>	
</div>


