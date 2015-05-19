<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<template:page pageTitle="${pageTitle}">

	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<div class="span-4 left-content-slot advert">
		<cms:slot var="feature" contentSlot="${slots['SideContent']}">
			<cms:component component="${feature}"/>
		</cms:slot>
	</div>
	<div class="span-20 right last">
		<div class="span-20 last top-content-slot advert">
			<cms:slot var="feature" contentSlot="${slots['TopContent']}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
		<div class="span-10 store_finder">
			<store:storeSearch errorNoResults="${errorNoResults}"/>
		</div>
		<div class="span-10 last">
			<store:storesMap storeSearchPageData="${storeSearchPageData}" />
		</div>
		<div class="span-20 last">
			<store:storeListForm storeSearchPageData="${storeSearchPageData}" locationQuery="${locationQuery}" showMoreUrl="${showMoreUrl}"/>
		</div>
	</div>

</template:page>