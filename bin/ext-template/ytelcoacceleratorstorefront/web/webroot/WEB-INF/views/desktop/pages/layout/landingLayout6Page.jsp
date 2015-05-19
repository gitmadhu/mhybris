<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>

<template:page pageTitle="${pageTitle}">
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<cms:slot var="feature" contentSlot="${slots.Section1}">
		<div class="span-24 section1">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	<div class="span-24">
		<div class="span-4 section3 advert">
			<cms:slot var="feature" contentSlot="${slots.Section3}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
		<div class="span-20 last">
			<div class="span-20 section2 advert">
				<cms:slot var="feature" contentSlot="${slots.Section2}">
					<cms:component component="${feature}"/>
				</cms:slot>
			</div>
			<div class="span-20 last">
				<cms:slot var="feature" contentSlot="${slots.Section4}">
					<div class="span-6 section4 small_detail ${(elementPos%3 == 2) ? 'last' : ''}">
						<cms:component component="${feature}"/>
					</div>
				</cms:slot>
			</div>
			<div class="span-20 section5 advert last">
				<cms:slot var="feature" contentSlot="${slots.Section5}">
					<cms:component component="${feature}"/>
				</cms:slot>
			</div>
		</div>
	</div>
</template:page>