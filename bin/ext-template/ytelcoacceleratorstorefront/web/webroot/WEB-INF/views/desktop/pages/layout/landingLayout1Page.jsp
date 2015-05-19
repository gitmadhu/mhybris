<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>

<template:page pageTitle="${pageTitle}">
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<cms:slot var="feature" contentSlot="${slots.Section1}">
		<div class="span-24 section1 advert">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	<div class="span-24 section2">
		<div class="span-12 zone_a advert">
			<cms:slot var="feature" contentSlot="${slots.Section2A}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
		<div class="span-6 zone_b thumbnail_detail">
			<cms:slot var="feature" contentSlot="${slots.Section2B}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
		<div class="span-6 zone_c last thumbnail_detail">
			<cms:slot var="feature" contentSlot="${slots.Section2C}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
	</div>
	<div class="span-24 section3 advert">
		<cms:slot var="feature" contentSlot="${slots.Section3}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
	<div class="span-24">
		<cms:slot var="feature" contentSlot="${slots.Section4}">
			<div class="span-6 section4 small_detail ${(elementPos%4 == 3) ? 'last' : ''}">
				<cms:component component="${feature}"/>
			</div>
		</cms:slot>
	</div>
	<div class="span-24 section5 advert">
		<cms:slot var="feature" contentSlot="${slots.Section5}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
</template:page>