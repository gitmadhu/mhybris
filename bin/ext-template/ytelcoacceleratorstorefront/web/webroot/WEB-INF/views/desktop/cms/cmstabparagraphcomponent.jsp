<%@ page trimDirectiveWhitespaces="true" %>
<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function() {
		$('#tab_01').after('<li><h2><a href="#tab-${component.uid}" class="tab_02" title="${component.title}">${component.title}</a></h2></li>');
		$('#prod_tabs').append('<div class="prod_content" id="tab-${component.uid}">${component.content}</div>');
	});
/*]]>*/
</script>
