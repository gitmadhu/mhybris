<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<cms:slot var="feature" contentSlot="${slots['Section1']}">
		<div class="span-24 section1 advert">
			<cms:component component="${feature}"/>
		</div>
	</cms:slot>
	<div class="span-24">
		<div class="span-4">
			<nav:categoryNav pageData="${searchPageData}"/>
			
			<cms:slot var="feature" contentSlot="${slots['Section4']}">
				<div class="section4 small_detail">
					<cms:component component="${feature}"/>
				</div>
			</cms:slot>
		</div>
		<div class="span-20 last">
			<cms:slot var="feature" contentSlot="${slots['Section2']}">
				<div class="span-20 section2 advert last">
					<cms:component component="${feature}"/>
				</div>
			</cms:slot>
			<div class="span-20 last">
				<cms:slot var="feature" contentSlot="${slots['Section3']}">
					<div class="span-5 section3 advert ${(elementPos%4 == 3) ? 'last' : ''}">
						<cms:component component="${feature}"/>
					</div>
				</cms:slot>
			</div>
		</div>
	</div>
</template:page>