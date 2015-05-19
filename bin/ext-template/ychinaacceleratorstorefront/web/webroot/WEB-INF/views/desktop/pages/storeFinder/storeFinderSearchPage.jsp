<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/desktop/store" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- CHINAACC_START --%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- CHINAACC_END --%>

<%-- CHINAACC_START:DELETED --%>
<%--
<template:page pageTitle="${pageTitle}">
	
		<div id="breadcrumb" class="breadcrumb">
			<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
		</div>
		<div id="globalMessages">
			<common:globalMessages/>
		</div>
		
		<cms:pageSlot position="TopContent" var="feature">
			<cms:component component="${feature}"  element="div" class="top-content-slot cms_disp-img_slot"  />
		</cms:pageSlot>

		<div id="storeFinder">
			<store:storeSearch errorNoResults="${errorNoResults}"/>
			<store:storesMap storeSearchPageData="${searchPageData}"/>
			<store:storeListForm searchPageData="${searchPageData}" locationQuery="${locationQuery}"  numberPagesShown="${numberPagesShown}" geoPoint="${geoPoint}"/>
		</div>

</template:page>
 --%>
<%-- CHINAACC_END:DELETED --%>


<%-- CHINAACC_START --%>
<template:page pageTitle="${pageTitle}">
	<jsp:attribute name="pageScripts">
	<script type="text/javascript">
	var label_StoreClosed = '<spring:theme code="storeDetails.table.opening.closed" />';
	$(function(){
		$('.btnMore a').click(function(){
			if($(this).parent().hasClass('on')){
				$(this).parent().removeClass('on').find('a').html('<spring:theme code="storelocator.city.links.collapse" />');
				$('.mapListInner3').css('overflow','visible');
			}else{
				$(this).parent().addClass('on').find('a').html('<spring:theme code="storelocator.city.links.more" />');
				$('.mapListInner3').css('overflow','hidden');
			}
		});
		
		$('.city').click(function(){
			$(".city.highlight").removeClass("highlight");
			$(this).addClass("highlight");
			
			var city = {geoPoint:{}};
			city.geoPoint.longitude = $(this).attr("cityLng");
			city.geoPoint.latitude = $(this).attr("cityLat");
			$.ajax({
				type: "GET",
				url: "${contextPath}/store-finder/getStoresByCity",
				data: {cityId:$(this).attr("id")},
			}).done(function(data){
				$("#cityStores").empty();
				for(var i=0; i<data.length; i++) {
					var store = data[i];
					var storeNum = "";
					var j = Math.floor(i/26) + 1;
					var storeNum = "&#" + (i% 26 + 65) + ";";
					for(; j>1; j--) {
						storeNum += "&#" + (i% 26 + 65) + ";";
					}
	
					var content = "<li class='store' onclick='displayStore(\"" + store.storePK +"\")'>" +
						"<p><strong>" + storeNum + " " + store.name + "</strong></p>" +
						"<p>" + store.address.line1 + store. address.line2  + (("remarks" in store.address && store.address.remarks != null) ? (" (" + store.address.remarks + ")"):"") + "</p>" +
						"<p>" + store.address.phone  + "</p>" +
					"</li>";
					
					store.line1 = store.address.line1;
					store.line2 = store.address.line2;
					store.remarks = (("remarks" in store.address && store.address.remarks != null) ? (" (" + store.address.remarks + ")"):"");
					store.phone = store.address.phone;
					
					if("storeImages" in store) {
						for(var k=0; k< store.storeImages.length; k++) {
							if(store.storeImages[k].format == "store") {
								store.image = store.storeImages[k].url;
								break;
							}
						}
					}
					
					if("openingHours" in store) {
						if("weekDayOpeningList" in store.openingHours) {
							store.openingSchedule = '<table class="store-openings weekday_openings"><tbody>';
							for(var k=0; k< store.openingHours.weekDayOpeningList.length; k++) {
								var weekDay = store.openingHours.weekDayOpeningList[k];
								
								store.openingSchedule += '<tr class="';
								if(weekDay.closed) {
									store.openingSchedule += 'weekday_openings_closed"';
								}
								else {
									store.openingSchedule += 'weekday_openings"';
								}
								store.openingSchedule += '>';
								store.openingSchedule += '<td class="weekday_openings_day">' + weekDay.weekDay + '</td>';
								store.openingSchedule += '<td class="weekday_openings_times">';
								if(weekDay.closed) {
									store.openingSchedule += label_StoreClosed;
								}
								else {
									store.openingSchedule += weekDay.openingTime.formattedHour + "-" + weekDay.closingTime.formattedHour;
								}
								store.openingSchedule += '</td></tr>';
							}
							store.openingSchedule += '</tbody></table>';
						}
						
						if("specialDayOpeningList" in store.openingHours) {
							store.openingSpecialDays = '<table class="store-openings specialday_openings"><tbody>';
							for(var k=0; k< store.openingHours.specialDayOpeningList.length; k++) {
								var specialDay = store.openingHours.specialDayOpeningList[k];
								
								store.openingSpecialDays += '<tr>';
								store.openingSpecialDays += '<td class="specialday_openings_date">' + specialDay.formattedDate + '</td>';
								store.openingSpecialDays += '<td class="specialday_openings_date">' + specialDay.name + '</td>';
								store.openingSpecialDays += '<td class="specialday_openings_times">';
								if(specialDay.closed) {
									store.openingSpecialDays += label_StoreClosed;
								}
								else {
									store.openingSpecialDays += specialDay.openingTime.formattedHour + "-" + specialDay.closingTime.formattedHour;
								}
								store.openingSpecialDays += '</td>';
								store.openingSpecialDays += '</tr>';
							}
							store.openingSpecialDays += '</tbody></table>';
						}
					}
					
					if("features" in store) {
						store.featuresContent = "";
						for(var feature in store.features) {
							store.featuresContent += "<li>" + store.features[feature] + "<li>";
						}
					}
					
					//"<p>" + store.address.line1 + store.address.line2  + ("remarks" in store.address)? (" (" + store.address.remarks + ")"):"" + "</p>" +
					//alert(content);
					$("#cityStores").append(content);
					//alert(city.geoPoint.longitude + ":" + city.geoPoint.latitude);
					$("#bmap_canvas").trigger("switchMapToCity", [city, data]);
				}
				
				$("#cityStores li").hover(function () {
					$(this).addClass('liOver');
				},function () {
					$(this).removeClass('liOver');
				});
			});
		});
		
		$("#countryLink").click(function(){
			$(".city.highlight").removeClass("highlight");
			var cities = new Array();
			$(".city").each(function(){
				var cityObj = {geoPoint:{}};
				cityObj.geoPoint.longitude = $(this).attr("cityLng");
				cityObj.geoPoint.latitude = $(this).attr("cityLat");
				cityObj.storeCount = $(this).attr("storeCount");
				cityObj.cityPK = $(this).attr("id");
				
				cities.push(cityObj);
			});
			$("#bmap_canvas").trigger("switchMapToCountry", [cities]);
			$("#cityStores").empty();
		});
	});
	
	function displayStore(storePK) {
		$("#bmap_canvas").trigger("displayStore", [storePK]);
	}
	</script>
	<script type="text/javascript">
	var imgMissingImage = '${contextPath}<spring:theme code="img.missingStoreImage.store"  />';
	
	var storeInfowindowCache = new Array();
	function getStoreInfowindow(store) {
		if("id" in store && store.id in storeInfowindowCache) {
			return storeInfowindowCache[store.id];
		}
		
		if(! ("image" in store))
			store.image = imgMissingImage;
		var sContent = "<div class='mapArea'>" + 
		"<h4>" + store.name + "</h4><div class='clearfix'>" + 
		"<div class='mapImg'><img style='float:left;margin:4px' id='storeImage" + store.id + "' src='"+ store.image + "' title='"+ store.name + "'/></div>";
		sContent += "<div class='mapMsg'>"
		var line = "";
		if("line1" in store)
			line += store.line1;
		if("line2" in store)
			line += store.line2;
		if("remarks" in store)
			line += store.remarks;
		sContent += "<p><span><spring:theme code="storeDetails.table.address" />:</span>" + line + "</p>";
		if("phone" in store)
			sContent += "<p><span><spring:theme code="storeDetails.table.telephone" />:</span>" + store.phone + "</p>";
		if("openingSchedule" in store)
			sContent += "<p><span><spring:theme code="storeDetails.table.opening" />:</span>" + store.openingSchedule + "</p>";
		if("openingSpecialDays" in store)
			sContent += "<p><span><spring:theme code="storeDetails.table.openingSpecialDays" />:</span>" + store.openingSpecialDays + "</p>";
		if("featuresContent" in store)
			sContent += "<p><span><spring:theme code="storeDetails.table.features" />:</span>" + store.featuresContent + "</p>";
		sContent += "</div></div></div>";
		
		var infoWindow = new BMap.InfoWindow(sContent);
		infoWindow.setWidth(500) ;
		infoWindow.setHeight(230) ;
		//storeInfowindowCache[store.id] = infoWindow;
		return infoWindow;
	}
		
	
	$(document).ready(function(){
		var map = $("#bmap_canvas").bmap();

<c:if test="${empty cities and empty storesData}">
		map.centerAndZoom();
</c:if>

<c:if test="${cities ne null and !empty cities}">
	<c:forEach items="${cities}" var="city">

		var cityMarker = map.addMarker(${city.geoPoint.longitude}, ${city.geoPoint.latitude}, "Text", ${city.storeCount});
		
		cityMarker.addEventListener("click", function(){
			$("#${city.cityPK}").trigger("click");
		});
	</c:forEach>
		map.centerAndZoom();
</c:if>

<c:if test="${storesData ne null and !empty storesData}">
		var storeMarker = {};
		var store = {};
		var storeDetailPop = {};
	<c:forEach items="${storesData}" var="store" varStatus="loop">
	
		storeMarker = map.addMarker(${store.geoPoint.longitude}, ${store.geoPoint.latitude}, "Bubble", '&#<c:forEach begin="1" end="${loop.index / 26 + 1}">${loop.index % 26 + 65};</c:forEach>');
		<%--store.id = "${store.storePK}";--%>
		store.id = "${loop.index}";
		store.name = "${store.name}";
		
		<c:set value="${ycommerce:storeImage(store, '')}" var="storeImage"/>
		<c:choose>
			<c:when test="${not empty storeImage}">
		store.image = "${storeImage.url}";
			</c:when>
			<c:otherwise>
				<spring:theme code="img.missingStoreImage.${format}" text="/" var="missingImageUrl"/>
		store.image = "${missingImageUrl}";
			</c:otherwise>
		</c:choose>
		store.image = "/ychinaacceleratorstorefront/_ui/desktop/common/images/stores/electronics_store_365x246_01.jpg";
		
		<c:if test="${not empty store.address.line1}">
		store.line1 = "${store.address.line1}";
		</c:if>
		<c:if test="${not empty store.address.phone}">
		store.phone = "${store.address.phone}";
		</c:if>
		<c:if test="${not empty store.address.email}">
		store.email = "${store.address.email}";
		</c:if>
		<c:if test="${not empty store.openingHours}">
		store.openingSchedule = '<store:openingSchedule openingSchedule="${store.openingHours}" jsCR="" />';
		</c:if>
		<c:if test="${not empty store.openingHours.specialDayOpeningList}">
		store.openingSpecialDays = '<store:openingSpecialDays openingSchedule="${store.openingHours}" jsCR="" />';
		</c:if>
		<c:if test="${not empty store.features}">
		store.featuresContent = '<c:forEach items="${store.features}" var="feature"><li>${feature.value}</li></c:forEach>';
		</c:if>
		storeDetailPop = getStoreInfowindow(store);
		storeMarker.addEventListener("click", function(){          
			this.openInfoWindow(storeDetailPop);
			document.getElementById('storeImage' + store.id).onload= function (){
				storeDetailPop.redraw();
			}
		});
	</c:forEach>
		map.resetViewport();
</c:if>
		
		// can be triggered by $("#bmap_canvas").trigger("switchMapToCity", [cityObj, storesObjArray]);
		$("#bmap_canvas").on("switchMapToCity", function(event, city, stores){
			map.clearMarkers();
			map.centerAt(city.geoPoint.longitude, city.geoPoint.latitude);
			map.stores = new Array();
			for(var i=0; i < stores.length; i++) {
				var store = stores[i];
				var j = Math.floor(i/26) + 1;
				var str = "&#" + (i% 26 + 65) + ";";
				for(; j>1; j--) {
					str += "&#" + (i% 26 + 65) + ";";
				}
				var marker = map.addMarker(store.geoPoint.longitude, store.geoPoint.latitude, "Bubble",  str);
				map.stores["" + store.storePK] = marker;
				var infoWindow = getStoreInfowindow(store);
				marker.win = infoWindow;
				marker.addEventListener("click", function(){
					var thatWin = this.win;
					this.openInfoWindow(thatWin);
					document.getElementById('storeImage' + store.id).onload= function (){
						thatWin.redraw();
					}
				});
			}
			map.resetViewport();
		});
		// can be triggered by $("#bmap_canvas").trigger("displayStore", [storePK]);
		$("#bmap_canvas").on("displayStore", function(event, storePK){
			if(storePK in map.stores)
				map.stores[storePK].openInfoWindow(map.stores[storePK].win);
		});
		// can be triggered by $("#bmap_canvas").trigger("switchMapToCountry", [cityObjArray]);
		$("#bmap_canvas").on("switchMapToCountry", function(event, cities){
			map.clearMarkers();
			map.centerAt(106.404, 35.915);
			for(var i=0; i<cities.length; i++) {
				var city = cities[i];
				var aMarker = map.addMarker(city.geoPoint.longitude, city.geoPoint.latitude, "Text", city.storeCount);
				aMarker.cityPK = city.cityPK;
				aMarker.addEventListener("click", function(){
					$("#" + this._marker.cityPK).trigger("click");
				});
			}
			map.centerAndZoom();
		});
	});
	</script>
	</jsp:attribute>
	
	<jsp:body>
		<div id="breadcrumb" class="breadcrumb">
			<breadcrumb:breadcrumb breadcrumbs="${breadcrumbs}"/>
		</div>
		<div id="globalMessages">
			<common:globalMessages/>
		</div>
		
		<cms:pageSlot position="TopContent" var="feature">
			<cms:component component="${feature}"  element="div" class="top-content-slot cms_disp-img_slot"  />
		</cms:pageSlot>

		<div id="storeFinder">
			<div class="span-24 last">
				<store:cities />
			</div>
			<div class="span-6 store_finder">
				<store:cityStores />
			</div>
			<div class="span-18 last">
				<store:baiduStoresMap citiesData="${cities}"/>
			</div>
		</div>
	</jsp:body>

</template:page>
<%-- CHINAACC_END --%>
