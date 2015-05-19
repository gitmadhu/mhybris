<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>

<script id="future-tooltip-template" type="text/x-jquery-tmpl">
	<span class="future_tooltip">
		<a href="#future">
			\${formattedDate}
			<span class="tooltip_table">
				<div class="tooltip_title">\${deliverMessage}</div>
				<div class="tooltip_title">\${qtyMessage}</div><br>
				{{each(index, availability) availabilities}}
				<div class="tooltip_value">\${formattedDate}</div>
				<div class="tooltip_value">\${stock.stockLevel}</div><br>
				{{/each}}
			</span>
		</a>
	</span>
</script>
<script id="future-tooltip-error-template" type="text/x-jquery-tmpl">
	<span class='oms_message_holder' id='oms-message-holder'>$\{errorMessage}</span>
</script>