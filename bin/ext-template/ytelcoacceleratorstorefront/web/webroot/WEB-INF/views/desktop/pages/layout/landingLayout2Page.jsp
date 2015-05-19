<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>

<template:page pageTitle="${pageTitle}">
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<cms:slot var="feature" contentSlot="${slots.Section1}">
		<div class="section1">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	<cms:slot var="feature" contentSlot="${slots.Section2}">
		<div class="section2">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	<div class="section3">
		<cms:slot var="feature" contentSlot="${slots.Section3A}">
			<div class="section3-item">
				<cms:component component="${feature}"/>
			</div>
		</cms:slot>
		<cms:slot var="feature" contentSlot="${slots.Section3B}">
			<div class="section3-item">
				<cms:component component="${feature}"/>
			</div>
		</cms:slot>
		<cms:slot var="feature" contentSlot="${slots.Section3C}">
			<div class="section3-item">
				<cms:component component="${feature}"/>
			</div>
		</cms:slot>
	</div>
	<div class="section4">
		<cms:slot var="comp" contentSlot="${slots.Section4}">
			<cms:component component="${comp}" />
		</cms:slot>
	</div>
	<cms:slot var="feature" contentSlot="${slots.Section5}">
		<div class="section5">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	
	
</template:page>