ACC.maps = {

	bindAll: function()
	{
		
	},

	getImageUrl: function(img, loopIndex)
	{
		var imageSrc = 'http://maps.google.com/mapfiles/marker' + String.fromCharCode(loopIndex + 65) + '.png';
		if (img.src != imageSrc) { 
			img.src = imageSrc;
		}
	},

	drawStore: function()
	{
		  var centerPoint = new google.maps.LatLng(latitude, longitude);
			var mapOptions = {
					zoom :13,
					zoomControl : true,
					panControl : true,
					streetViewControl : false,
					mapTypeId: google.maps.MapTypeId.ROADMAP,
					center: centerPoint
			}
		overlay = new ScrollInterceptOverlay(new google.maps.Map(document.getElementById("map_canvas"), mapOptions));
		ACC.maps.addStore(new google.maps.LatLng(latitude, longitude));
	},

	addStore: function(coord)
	{
			marker = new google.maps.Marker({
				position: coord, 
				map: overlay.getMap()
			});
			markers.push(marker);
			infowindow = new google.maps.InfoWindow({
				position : overlay.getMap().getCenter() ,
				content: "<div class=\"strong\">"+storename+"</div>" +
				"<div>"+storeaddressline1+"</div>" +
				"<div>"+storeaddressline2+"</div>" +
				"<div>"+storeaddresstown+"</div>" +
				"<div>"+storeaddresspostalCode+"</div>" +
				"<div>"+storeaddresscountryname+"</div>"
			});
			infowindow.open(overlay.getMap());
	},

	drawStores: function()
	{
		var centerPoint = new google.maps.LatLng(latitude, longitude);
		var mapOptions = {
			zoom:				13,
			zoomControl:		true,
			panControl:			true,
			streetViewControl:	false,
			mapTypeId:			google.maps.MapTypeId.ROADMAP,
			center:				centerPoint
		};

		overlay = new ScrollInterceptOverlay(new google.maps.Map(document.getElementById("map_canvas"), mapOptions));
		var bounds = new google.maps.LatLngBounds(new google.maps.LatLng(boundSouthLatitude, boundWestLongitude), new google.maps.LatLng(boundNorthLatitude, boundEastLongitude));
		overlay.getMap().fitBounds(bounds);

		 for (x = 0; x < singlePosname.length; x++) 
		 {
			ACC.maps.addStores(new google.maps.LatLng(singlePosgeoPointlatitude[x],singlePosgeoPointlongitude[x] ), singlePosname[x]);
		 }
		 


	},

	addStores: function(coord,name)
	{
		var marker = new google.maps.Marker({
			position:	coord,
			map:		overlay.getMap(),
			title:		name,
			icon:		"http://maps.google.com/mapfiles/marker" + String.fromCharCode(markers.length + 65) + ".png"
		});
		markers.push(marker);
		var infowindow = new google.maps.InfoWindow({
			content:		name,
			disableAutoPan:	true
		});
		google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(overlay.getMap(), marker);
		});
	}
	
};

$(document).ready(function()
{
	ACC.maps.bindAll();

	if(typeof drawMapStore != 'undefined' && drawMapStore)
	{
		ScrollInterceptOverlay.prototype = new google.maps.OverlayView();
		ACC.maps.drawStore();
	}
	
	if(typeof drawMapStores != 'undefined' && drawMapStores)
	{
		ScrollInterceptOverlay.prototype = new google.maps.OverlayView();
		ACC.maps.drawStores();
	}
});











