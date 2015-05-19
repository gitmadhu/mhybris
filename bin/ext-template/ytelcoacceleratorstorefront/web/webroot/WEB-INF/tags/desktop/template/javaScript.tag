<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/" var="siteRootUrl"/>

<%-- j query 1.5.1 --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery-1.7.2.min.js"></script>

<%-- j query query 2.1.7 --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.query-2.1.7.js"></script>

<%-- jquery tabs dependencies --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery-ui-1.8.18.min.js"></script>

<%-- j carousel --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.jcarousel-0.2.8.min.js"></script>

<%-- j query templates --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.tmpl-1.0.0pre.min.js"></script>

<%-- j query block UI --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.blockUI-2.39.js"></script>

<%-- Galleriffic --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.galleriffic-2.0.1.js"></script>

<%-- colorbox --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.colorbox-1.3.16.js"></script>

<%-- Slide Viewer --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.slideviewer.1.2.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.easing.1.3.js"></script>

<%-- Scroll to --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.scrollTo-1.4.2-min.js"></script>


<script type="text/javascript" src="${commonResourcePath}/js/jquery.ui.stars-3.0.1.min.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.form-3.09.js"></script>

  <script type="text/javascript" src="${commonResourcePath}/js/jquery.tabs.js"></script>


<%-- BeautyTips  --%>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.bgiframe-2.1.2.min.js"></script>
<!--[if IE]><script type="text/javascript" src="${commonResourcePath}/js/excanvas-r3.compiled.js"></script><![endif]-->
<script type="text/javascript" src="${commonResourcePath}/js/jquery.bt-0.9.5-rc1.min.js"></script>


<%-- Custom ACC JS --%>
<script type="text/javascript" src="${commonResourcePath}/js/acc.common.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
	<%-- Define a javascript variable to hold the content path --%>
	ACC.common.contextPath = "${request.contextPath}";
	ACC.common.commonResourcePath = "${commonResourcePath}";
	ACC.common.themeResourcePath = "${themeResourcePath}";
	ACC.common.siteResourcePath = "${siteResourcePath}";
	ACC.common.rootPath = "${siteRootUrl}";
	ACC.common.CSRFToken = "${CSRFToken}";

    ACC.config = {};
    ACC.config.contextPath = "${request.contextPath}";
    ACC.config.language = "${currentLanguage.isocode}";	
	
/*]]>*/
</script>

<script type="text/javascript" src="${commonResourcePath}/js/acc.cms.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/acc.product.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/acc.paginationsort.js"></script>


<%-- Google maps API --%>
<c:if test="${!empty googleApiVersion}">
	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=${googleApiVersion}&key=${googleApiKey}&sensor=false"></script>
</c:if>

<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function()
	{
		$('.jcarousel-vertical').jcarousel({
			// Configuration goes here
			vertical: true
		});

		$('.jcarousel-horizontal').jcarousel({
		

		});

		
	});
/*]]>*/
</script>

<%-- Fire Add This sharing button on Click not Hover --%>
<script type="text/javascript">
/*<![CDATA[*/
	var addthis_config = {
		ui_click: true
	};
/*]]>*/
</script>

<c:if test="${currentLanguage.isocode eq 'en'}">

<script type="text/javascript" src="${commonResourcePath}/js/jquery.pstrength-1.2.min.js"></script>

<script type="text/javascript">
/*<![CDATA[*/
	$(function() {
		$('.strength').pstrength();
	});
/*]]>*/
</script>

</c:if>

<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function(){
		$(".modal").colorbox();
		$("div#homepage_slider").slideView({toolTip: true, ttOpacity: 0.6})
		$("div#homepage_slider").tabs("ul li a").has("img").unbind("click");
	});
/*]]>*/
</script>




<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function(){

		if($(".js-cancel-subscription").length>0){

			$(document).on("click",".js-cancel-subscription",function(e){
				e.preventDefault();

				$.colorbox({
					inline: true,
					href:"#cancel-subscription-confirm",
					width: "300px",
					height:"100px",
					overlayClose:false,
					close: false,
					onComplete: function(){
						$.colorbox.resize();
					}
				})
				
			})

			$(document).on("click","#cancel-subscription-confirm button.r_action_btn",function(){
				$.colorbox.close();
			})

		}
	});
/*]]>*/
</script>



<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function(){

		if($(".js-remove-address").length>0){

			$(document).on("click",".js-remove-address",function(e){
				e.preventDefault();

				var dataId = $(this).attr("data-id");

				$.colorbox({
					inline: true,
					href:"#remove-address-confirm-"+dataId,
					width: "300px",
					height:"100px",
					overlayClose:false,
					close: false,
					onComplete: function(){
						$.colorbox.resize();
					}
				})
				
			})

			$(document).on("click",".remove-address-confirm button.cancel",function(){
				$.colorbox.close();
			})

		}
	});
/*]]>*/
</script>
