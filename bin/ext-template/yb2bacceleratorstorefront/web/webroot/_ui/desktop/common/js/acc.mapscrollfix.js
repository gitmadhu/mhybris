/*
 * [y] hybris Platform
 *
 * Copyright (c) 2000-2013 hybris AG
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of hybris
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with hybris.
 */

// This class is used to fix a bug where scrolling on Google Maps will cause the whole window to scroll
// For more information see https://code.google.com/p/gmaps-api-issues/issues/detail?id=3652

var ScrollInterceptOverlay = function (gmap)
{
	if (!(this instanceof ScrollInterceptOverlay))
	{
		return;
	}

	var $div;
	var $mapDiv;
	var $map;
	var $widthSpacing;
	var $heightSpacing;

	var initialize = function ()
	{
		$div = $('<div />').css({
			display: 'inline-block'
		});

		addEventListeners($div[0]);
		this.setMap(gmap);
	};

	var addEventListeners = function (div)
	{
		if (div && div.addEventListener)
		{
			// IE, Opera, Chrome and Safari
			div.addEventListener('mousewheel', mouseScrollStop);
			// Firefox
			div.addEventListener('DOMMouseScroll', mouseScrollStop);
			div.addEventListener('MozMousePixelScroll', mouseScrollStop);
		}
		else if (div && div.attachEvent)
		{
			// IE 8 and less
			div.attachEvent('onmousewheel', mouseScrollStop);
		}

		bindMouseDrag('#map_canvas');
	}

	var mouseScrollStop = function (e)
	{
		if (e && e.preventDefault)
		{
			e.preventDefault();
		}
	};

	this.onAdd = function ()
	{
		$div.prependTo(this.getPanes().overlayMouseTarget);
	};

	this.onRemove = function ()
	{
		addEventListeners($div[0]);
		$div.detach();
	};

	this.draw = function ()
	{
		var overlayProjection = this.getProjection();
		var sw = overlayProjection.fromLatLngToDivPixel($map.getBounds().getSouthWest());
		var ne = overlayProjection.fromLatLngToDivPixel($map.getBounds().getNorthEast());

		// Reposition the DIV so that it is centered on the map, triggers on zoom in/out
		$div.css({
			position: 'absolute', left: sw.x - $widthSpacing, top: ne.y - $heightSpacing
		});
	};

	var bindMouseDrag = function(map)
	{
		var isDragging = false;

		$(map).mousedown(function() {
			$(window).one('mousemove', function() {
				isDragging = true;
			});
		});

		$(window).mouseup(function() {
			$(window).unbind('mousemove');
			if (isDragging)
			{
				// Reposition the DIV so that it is centered on the map, triggers on mouse drag
				$div.offset({
					left: $(map).offset().left - $widthSpacing,
					top: $(map).offset().top - $heightSpacing
				});
				isDragging = false;
			}
		});
	};

	var base_setMap = this.setMap;
	this.setMap = function (map)
	{
		$map = map;
		$mapDiv = $(map.getDiv());
		$widthSpacing = $mapDiv.outerWidth() / 2;
		$heightSpacing = $mapDiv.outerHeight() / 2;

		if ($mapDiv && $mapDiv.length === 1)
		{
			// Doubled width and height to ensure that overlay covers the map
			$div.css({
				width: $mapDiv.outerWidth() * 2,
				height: $mapDiv.outerHeight() * 2
			});
		}

		base_setMap.call(this, map);
	};

	initialize.call(this);
};