function getCMSElement(event) {
	var contentSlot = "";
	var contentElement = "";
	var t;
	if(window.event){ //IE only
		t=event.srcElement;
	}else{
		t=event.target;
	}
	while (t.tagName != "BODY") {
		t = t.parentNode;
		var id = t.id;
		if (id.length >= "ceid_".length && id.substring(0, 5) == "ceid_") {
			var cid = id.substring(5, id.length);
			var tmp = cid.split("___");
			if (tmp.length == 1) {
				var contentElement = tmp[0];
			} else {
				var contentSlot = tmp[0];
				var contentElement = tmp[1];
			}
			break;
		}
	}
	if (contentElement != "" && parent.notifyIframeZkComponent) {
		parent.notifyIframeZkComponent(contentElement, contentSlot);
	}
	return false;
}

/*
 * Find all the divs with IDs that start with the "ceid_" prefix and add the "liveEditElement" class to them.
 */
$(document).ready(function() {
	$('div[id^="ceid_"]').addClass('liveEditElement');
});
