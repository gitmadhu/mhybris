<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="storeSearchPageData" required="false"
              type="de.hybris.platform.commerceservices.storefinder.data.StoreFinderSearchPageData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    /*<![CDATA[*/
    var map;
    var markers = [];

    function drawStores() {
        var centerPoint = new google.maps.LatLng(${storeSearchPageData.sourceLatitude}, ${storeSearchPageData.sourceLongitude});
        var mapOptions = {
            zoom:              13,
            zoomControl:       true,
            panControl:        true,
            streetViewControl: false,
            mapTypeId:         google.maps.MapTypeId.ROADMAP,
            center:            centerPoint
        }

        map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
        var bounds = new google.maps.LatLngBounds(new google.maps.LatLng(${storeSearchPageData.boundSouthLatitude}, ${storeSearchPageData.boundWestLongitude}), new google.maps.LatLng(${storeSearchPageData.boundNorthLatitude}, ${storeSearchPageData.boundEastLongitude}));
        map.fitBounds(bounds);

    <c:forEach items="${storeSearchPageData.results}" var="singlePos">
        addStore(new google.maps.LatLng(${singlePos.geoPoint.latitude}, ${singlePos.geoPoint.longitude}), "${singlePos.name}");
    </c:forEach>

    }

    function addStore(coord, name) {
        var marker = new google.maps.Marker({
            position: coord,
            map:      map,
            title:    name,
            icon:     "http://maps.google.com/mapfiles/marker" + String.fromCharCode(markers.length + 65) + ".png"
        });
        markers.push(marker);
        var infowindow = new google.maps.InfoWindow({
            content:        name,
            disableAutoPan: true
        });
        google.maps.event.addListener(marker, 'click', function() {
            infowindow.open(map, marker);
        });
    }
    /*]]>*/
</script>

<c:if test="${storeSearchPageData ne null and !empty storeSearchPageData.results}">
    <div class="store_map" id="map_canvas" style="z-index: 9999"></div>
    <script type="text/javascript">
        /*<![CDATA[*/
        drawStores();
        /*]]>*/
    </script>
</c:if>


