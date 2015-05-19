<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/desktop/product" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/desktop/nav" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>

<template:page pageTitle="${pageTitle}">
	<div id="breadcrumb" class="breadcrumb">
		<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
	</div>
	
	<c:if test="${not empty message}">
		<spring:theme code="${message}"/>
	</c:if>

	<div id="globalMessages">
		<common:globalMessages/>
	</div>
	<div class="span-24">
		<div class="span-4 side-content-slot advert">
			<cms:slot var="feature" contentSlot="${slots['SideContent']}">
				<cms:component component="${feature}"/>
			</cms:slot>
		</div>
		<div class="span-20 right last">
			<div class="item_container_holder">
				<div class="title_holder">
					<div class="title">
						<div class="title-top">
							<span></span>
						</div>
					</div>
					<h2><spring:theme code="search.no.results" text="No Results Found"/></h2>
				</div>
				<div class="item_container">
					<cms:slot var="comp" contentSlot="${slots.MiddleContent}">
						<cms:component component="${comp}"/>
					</cms:slot>
				</div>
				<div class="item_container">
					<nav:searchSpellingSuggestion spellingSuggestion="${searchPageData.spellingSuggestion}" />
				</div>
			</div>
			<div class="span-20 advert right last">
				<cms:slot var="comp" contentSlot="${slots.BottomContent}">
					<cms:component component="${comp}"/>
				</cms:slot>
			</div>
		</div>
	</div>
</template:page>