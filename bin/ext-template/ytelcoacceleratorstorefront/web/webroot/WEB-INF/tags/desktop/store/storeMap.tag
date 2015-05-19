<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="store" required="false" type="de.hybris.platform.commercefacades.storelocator.data.PointOfServiceData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<script type="text/javascript">
/*<![CDATA[*/
	    var map;
    var markers = [];  
    var infowindow;
    
	function drawStore() {	 
		  var centerPoint = new google.maps.LatLng(${store.geoPoint.latitude}, ${store.geoPoint.longitude});	  				  				  			
			var mapOptions = {	
					 zoom :13,
					 zoomControl : true,
					 panControl : true,
					 streetViewControl : false,
					 mapTypeId: google.maps.MapTypeId.ROADMAP,
				     center: centerPoint
			}
		map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);	  	 		  
	    addStore(new google.maps.LatLng(${store.geoPoint.latitude}, ${store.geoPoint.longitude}));		
			  
	}
	
	 function addStore(coord) {  
		    marker = new google.maps.Marker({
			      position: coord, 
			      map: map
			      /*icon: "http://maps.google.com/mapfiles/marker" + String.fromCharCode(markers.length + 65) + ".png"*/
			    });
			markers.push(marker);
			infowindow = new google.maps.InfoWindow({			    
			    position : map.getCenter() ,
			    content: "<div class=\"strong\">${store.name}</div>" +
				"<div>${store.address.line1}</div>" +
				"<div>${store.address.line2}</div>" +
				"<div>${store.address.town}</div>" +
				"<div>${store.address.postalCode}</div>" +
				"<div>${store.address.country.name}</div>"
			  });
			infowindow.open(map);
	 }
		
 /*]]>*/
</script>
<c:if test="${store ne null and store.geoPoint.latitude ne null and store.geoPoint.longitude ne null}">
	<div class="store_map_details" id="map_canvas"></div>
	<script type="text/javascript">
		/*<![CDATA[*/
			drawStore();
		/*]]>*/
	</script>
</c:if>


