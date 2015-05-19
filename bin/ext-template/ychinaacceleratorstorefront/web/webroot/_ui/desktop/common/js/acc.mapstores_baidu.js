/* CHINAACC:NEWFILE */

function TextMarker(point, text, mouseoverText){
	this._point = point;
	this._text = text;
	this._overText = mouseoverText;
}
if(typeof BMap!='undefined')
	TextMarker.prototype = new BMap.Overlay();
TextMarker.prototype.initialize = function(map){
	this._map = map;
	var div = this._div = document.createElement("div");
	div.style.position = "absolute";
	div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
	div.style.backgroundColor = "#EE5D5B";
	div.style.border = "1px solid #BC3B3A";
	div.style.color = "white";
	div.style.height = "18px";
	div.style.padding = "2px 10px";
	div.style.lineHeight = "18px";
	div.style.whiteSpace = "nowrap";
	div.style.MozUserSelect = "none";
	div.style.fontSize = "12px";
	var span = this._span = document.createElement("span");
	div.appendChild(span);
	span.appendChild(document.createTextNode(this._text));	  
	var that = this;

	var arrow = this._arrow = document.createElement("div");
	arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
	arrow.style.position = "absolute";
	arrow.style.width = "11px";
	arrow.style.height = "10px";
	arrow.style.top = "22px";
	arrow.style.left = "10px";
	arrow.style.overflow = "hidden";
	div.appendChild(arrow);
   
	div.onmouseover = function(){
	  this.style.backgroundColor = "#6BADCA";
	  this.style.borderColor = "#0000ff";
	  this.style.cursor = "pointer";
	  this.getElementsByTagName("span")[0].innerHTML = that._overText;
	  arrow.style.backgroundPosition = "0px -20px";
	}

	div.onmouseout = function(){
	  this.style.backgroundColor = "#EE5D5B";
	  this.style.borderColor = "#BC3B3A";
	  this.getElementsByTagName("span")[0].innerHTML = that._text;
	  arrow.style.backgroundPosition = "0px 0px";
	}
	
	map.getPanes().labelPane.appendChild(div);
	
	div._marker = this;
	
	return div;
}
TextMarker.prototype.draw = function(){
	var map = this._map;
	var pixel = map.pointToOverlayPixel(this._point);
	this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
	this._div.style.top  = pixel.y - 30 + "px";
};
TextMarker.prototype.addEventListener = function(evt, handler) {
	this._div.addEventListener(evt, handler)
}


$.fn.bmap = function(options) {
	var mapInstance  = $.extend({
		initOptions: {minZoom:5},
		_bmap_centerPoint: new BMap.Point(106.404, 35.915),
		centerAt: function(lng, lat) {
			this._bmap_centerPoint = new BMap.Point(lng, lat);
		},
		zoomLevel:5,
		viewPoints: new Array(),
		addMarker: function(lng, lat, style, txt) {
			var point = new BMap.Point(lng, lat);
			this.viewPoints.push(point);
			var marker = {};
			if(style) {
				if(style == 'Bubble') {
					marker = new BMap.Marker(point);
					var label = new BMap.Label(txt);
					label.setStyle({border:"0px", background:"transparent", padding:"4px"});
					marker.setLabel(label);
				}
				else 
					marker = new TextMarker(point, txt, txt);
			} else {
				var marker = new BMap.Marker(point);
			}
			this._bmap.addOverlay(marker);
			return marker;
		},
		clearMarkers: function() {
			this._bmap.clearOverlays();
			this.viewPoints = new Array();
		},
		centerAndZoom: function() {
			this._bmap.centerAndZoom(this._bmap_centerPoint, this.zoomLevel);
		},
		resetViewport: function() {
			if(this.viewPoints.length > 0) {
				this._bmap.setViewport(this.viewPoints);
			}
			else {
				this.centerAndZoom();
			}
		}
	}, options);
	
	mapInstance._bmap = new BMap.Map(this[0], mapInstance.initOptions);
	mapInstance._bmap.addControl(new BMap.NavigationControl())
	return mapInstance;
}
