<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${store.name} | ${siteName}">

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
		<div class="span-20 last">
			<div class="item_container_holder">
				<div class="title_holder">
					<div class="title">
						<div class="title-top">
							<span></span>
						</div>
					</div>
					<h2>${store.name}</h2>
				</div>
				<div class="item_container">
					<ycommerce:testId code="storeFinder_storeDetails_label">
						<div class="store_details_left_col">
							<store:storeImage store="${store}" format="store"/>
							<store:storeDetails store="${store}"/>
						</div>
					</ycommerce:testId>
					<div class="store_details_right_col">
						<store:storeMap store="${store}"/>
						<div class="store_paragraph_content">
							${store.storeContent}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</template:page>