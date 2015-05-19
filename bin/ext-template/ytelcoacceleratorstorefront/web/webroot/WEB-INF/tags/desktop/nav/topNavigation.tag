<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="/cms2lib/cmstags/cmstags.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>

<div id="nav_main" class="nav_main">
	
	<ul class="clear_fix">
	<li class="home-navigation"><a href="<c:url value="/"/>" title="<spring:theme code="general.homeButton" text="Home Button"/>"><spring:theme code="general.homeButton" text="Home Button"/></a></li>
		<cms:slot var="component" contentSlot="${slots['NavigationBar']}">
			<cms:component component="${component}"/>
		</cms:slot>
	
			<li class="search">
			<form name="search_form" method="get" action="<c:url value="/search"/>">
				<spring:theme code="text.search" var="searchText"/>
				<label class="skip" for="search">${searchText}</label>
				<spring:theme code="search.placeholder" var="searchPlaceholder"/>
				<ycommerce:testId code="header_search_input">
					<input id="search" class="text" type="text" name="text" value="" maxlength="100" placeholder="${searchPlaceholder}"/>
				</ycommerce:testId>
				<ycommerce:testId code="header_search_button">
					<spring:theme code="img.searchButton" text="/" var="searchButtonPath"/>
					<input class="button" type="image" title="${searchText}" src="<c:url value="${searchButtonPath}"/>" alt="${searchText}"/>
				</ycommerce:testId>
			</form>
			
			<script>
				<c:url value="/search/autocomplete" var="autocompleteUrl"/>
				$(function() {
					$( "#search" ).autocomplete({
						source: function( request, response ) {
							$.getJSON(
									"${autocompleteUrl}", 
									{
										term : $('#search').val()
									},
									function(data) {
										response(data);
									}
								);
						},
						minLength: 2,
						open: function(event, ui) { $(".ui-menu").css("z-index", 10000); },
						close: function(event, ui) { $(".ui-menu").css("z-index", -1); },
						select: function(event, ui) { 
							if(ui.item) {
					            $('#search').val(ui.item.value.trim());
					            
					        }
					        document.forms['search_form'].submit();
						},
						autoFocus: false
			
					});
				});
			</script>

		</li>
	</ul>
</div>