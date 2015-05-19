<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>

<template:page pageTitle="${pageTitle}">

<div class="lazyLoadConfig"  data-lazy-load-config='{ "failure_limit" : 10, "threshold" : 100, "skip_invisible" : "false" }' data-timeout='250'></div>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	
	<cms:pageSlot position="Section1" var="feature">
		<cms:component component="${feature}" element="div" class="section1"/>
	</cms:pageSlot>

	<div class="span-24 langing-section-banner">
		<%-- CHINAACC_START:DELETED --%><%--
		<cms:pageSlot position="Section2A" var="feature" element="div" class="span-6 zoneA">
		--%><%-- CHINAACC_END:DELETED --%>
		<%-- CHINAACC_START --%>
		<%-- CHINAACC:COMMENT:prev storefront version had different CSS classes<cms:pageSlot position="Section2A" var="feature" element="div" class="span-8 zone_a thumbnail_detail"> --%>
		<cms:pageSlot position="Section2A" var="feature" element="div" class="span-8 zoneA">
		<%-- CHINAACC_END --%>
			<cms:component component="${feature}" />
		</cms:pageSlot>

		<%-- CHINAACC_START:DELETED --%><%--
		<cms:pageSlot position="Section2B" var="feature" element="div" class="span-6 zoneB ">
		--%><%-- CHINAACC_END:DELETED --%>
		<%-- CHINAACC_START --%>
		<%-- CHINAACC:COMMENT:prev storefront version had different CSS classes<cms:pageSlot position="Section2B" var="feature" element="div" class="span-8 zone_b thumbnail_detail"> --%>
		<cms:pageSlot position="Section2B" var="feature" element="div" class="span-8 zoneB">
		<%-- CHINAACC_END --%>
			<cms:component component="${feature}" />
		</cms:pageSlot>

		<%-- CHINAACC_START:DELETED --%><%--
		<cms:pageSlot position="Section2C" var="feature" element="div" class="span-12 last zoneC ">
		--%><%-- CHINAACC_END:DELETED --%>
		<%-- CHINAACC_START --%>
		<%-- CHINAACC:COMMENT:prev storefront version had different CSS classes <cms:pageSlot position="Section2C" var="feature" element="div" class="span-8 zone_c cms_disp-img_slot last">--%>
		<cms:pageSlot position="Section2C" var="feature" element="div" class="span-8 zoneC">
		<%-- CHINAACC_END --%>
			<cms:component component="${feature}" element="div"/>
		</cms:pageSlot>
	</div>

	<cms:pageSlot position="Section3" var="feature" element="div" class="span-24">
		<cms:component component="${feature}" />
	</cms:pageSlot>

	<cms:pageSlot position="Section4" var="feature" element="div" class="span-24 section4">
		<%--CHINAACC_START:DELETED --%><%-- 
		<cms:component component="${feature}" element="div" class="span-6  ${(elementPos%4 == 3) ? 'last' : ''}"/>
		 --%><%--CHINAACC_END:DELETED --%><%--
		<%--CHINAACC_START --%>
		<cms:component component="${feature}" element="div"/>
		<%--CHINAACC_END --%>
	</cms:pageSlot>

	<cms:pageSlot position="Section5" var="feature" element="div" class="span-24 section5 cms_disp-img_slot">
		<cms:component component="${feature}" />
	</cms:pageSlot>

</template:page>