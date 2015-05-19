<%@ page trimDirectiveWhitespaces="true" %>
<div>
	<img title="${media.altText}" alt="${media.altText}" src="${media.URL}" usemap="#map">
	<map name="map">
		${imageMapHTML}
	</map>
</div>