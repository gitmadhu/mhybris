<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="deliveryAddress" required="true" type="de.hybris.platform.commercefacades.user.data.AddressData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="single-checkout" tagdir="/WEB-INF/tags/desktop/checkout/single" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:url value="/checkout/single/summary/getDeliveryAddresses.json" var="getDeliveryAddressesUrl" />
<spring:url value="/checkout/single/summary/setDeliveryAddress.json" var="setDeliveryAddressUrl" />
<spring:url value="/checkout/single/summary/getDeliveryAddressForm.json" var="getDeliveryAddressFormUrl" />

<script type="text/javascript">
/*<![CDATA[*/
	/* Extend jquery with a postJSON method */
	jQuery.extend({
	   postJSON: function( url, data, callback) {
		  return jQuery.post(url, data, callback, "json");
	   }
	});

	var handleChangeAddressButtonClick = function() {
		$.postJSON('${getDeliveryAddressesUrl}', handleAddressDataLoad);
		return false;
	};

	var handleAddressDataLoad = function(data) {
		// Fill the available delivery addresses
		$('.delivery_addresses_list').html($('#deliveryAddressesTemplate').tmpl({addresses: data}));

		// Handle selection of address
		$('.delivery_addresses_list button.use_address').click(handleSelectExistingAddressClick);
		// Handle edit address
		$('.delivery_addresses_list button.edit').click(handleEditAddressClick);
		// fill form fields
		fillAddressForm();

		// Show the delivery address popup
		$.colorbox({inline:true, href:"#popup_checkout_delivery_address", height: false, overlayClose: false});
	};

	function fillAddressForm()
	{
		var addressId = $('.change_address_button').attr('address-id');
		var options = {
			url: '${getDeliveryAddressFormUrl}',
			data: {addressId: addressId, createUpdateStatus: ''},
			type: 'GET',
			success: function(data) {
				$('#create_update_address_form_container_div').html(data);
				bindCreateUpdateAddressForm();
			}
		};

		$.ajax(options);
	}

	var handleSelectExistingAddressClick = function() {
		var addressId = $(this).attr('address-id');
		$.postJSON('${setDeliveryAddressUrl}', {addressId: addressId}, handleSelectExitingAddressSuccess);
		return false;
	};

	var handleEditAddressClick = function() {
		var addressId = $(this).attr('address-id');
		var options = {
			url: '${getDeliveryAddressFormUrl}',
			data: {addressId: addressId, createUpdateStatus: ''},
			target: '#create_update_address_form_container_div',
			type: 'GET',
			success: function(data) {
				//alert(data);
				bindCreateUpdateAddressForm();
			},
			error: function(xht, textStatus, ex) {
				alert("Failed to update cart. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
			}
		};

		$(this).ajaxSubmit(options);
		return false;
	};

	var handleSelectExitingAddressSuccess = function(data) {
		if(data != null)
		{
			//alert("delivery address set successfully");

			refreshPage(data);
			parent.$.colorbox.close();
		}
		else
		{
			alert("Failed to set delivery address");
		}
	};

	$(document).ready(function(){

		$('div.checkout_summary_flow_a .change_address_button').click(handleChangeAddressButtonClick);

	});

	$(document).ready(function() {

		bindCreateUpdateAddressForm()
	});

	function bindCreateUpdateAddressForm()
	{
		$('.create_update_address_form').each(function () {
			var options = {
				type: 'POST',
				beforeSubmit: function() {
					$('#checkout_delivery_address').block({ message: "<img src='${commonResourcePath}/images/spinner.gif' />" });
				},
				success: function(data) {
					//alert(data);
					$('#create_update_address_form_container_div').html(data);
					var status = $('.create_update_address_id').attr('status');
					if(status != null && "success" == status.toLowerCase())
					{
						getCheckoutCartDataAndRefreshPage();
						parent.$.colorbox.close();
					}
					else
					{
						bindCreateUpdateAddressForm();
					}
				},
				error: function(xht, textStatus, ex) {
					alert("Failed to update cart. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
				},
				complete: function () {
					$('#checkout_delivery_address').unblock();
				}
			};

			$(this).ajaxForm(options);
		});
	}

	function refreshDeliveryAddressSection(data)
	{
		$('#checkout_summary_deliveryaddress_div').replaceWith($('#deliveryAddressSummaryTemplate').tmpl(data));
		//bind change address button
		$('div.checkout_summary_flow_a .change_address_button').click(handleChangeAddressButtonClick);
	}
/*]]>*/
</script>

<script id="deliveryAddressSummaryTemplate" type="text/x-jquery-tmpl">
	<div class="checkout_summary_flow_a {{if deliveryAddress}}complete{{/if}}" id="checkout_summary_deliveryaddress_div">
		<div class="item_container_holder">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="checkout.summary.deliveryAddress.header" htmlEscape="false"/><span></span></h2>
			</div>

			<div class="item_container">
				<ul>
					{{if deliveryAddress}}
						<li>{{= deliveryAddress.title}} {{= deliveryAddress.firstName}} {{= deliveryAddress.lastName}}</li>
						<li>{{= deliveryAddress.line1}}</li>
						<li>{{= deliveryAddress.line2}}</li>
						<li>{{= deliveryAddress.town}}</li>
						<li>{{= deliveryAddress.postalCode}}</li>
					{{else}}
						<li><spring:theme code="checkout.summary.deliveryAddress.noneSelected"/></li>
					{{/if}}
				</ul>
			</div>
		</div>

		{{if deliveryAddress}}
				<ycommerce:testId code="checkout_changeAddress_element">
				<a href="#" class="edit_complete change_address_button" address-id="{{= deliveryAddress.id}}"><spring:theme code="checkout.summary.deliveryAddress.editDeliveryAddressButton"/></a>
				</ycommerce:testId>
		{{else}}
				<ycommerce:testId code="checkout_changeAddress_element">
				<button class="form change_address_button" address-id="{{= deliveryAddress.id}}"><spring:theme code="checkout.summary.deliveryAddress.enterDeliveryAddressButton"/></button>
				</ycommerce:testId>
		{{/if}}
	</div>
</script>

<script id="deliveryAddressesTemplate" type="text/x-jquery-tmpl">
	{{if !addresses.length}}
		<spring:theme code="checkout.summary.deliveryAddress.noExistingAddresses"/>
	{{/if}}
	{{if addresses.length}}
		<form>
			{{each addresses}}
				<div class="existing_address">
					<ul>
						<li>{{= $value.title}} {{= $value.firstName}} {{= $value.lastName}}</li>
						<li>{{= $value.line1}}</li>
						<li>{{= $value.line2}}</li>
						<li>{{= $value.town}}</li>
						<li>{{= $value.postalCode}}</li>
					</ul>

					<button class="form right pad_left use_address" address-id="{{= $value.id}}"><spring:theme code="checkout.summary.deliveryAddress.useThisAddress"/></button>
					<button class="form right edit" address-id="{{= $value.id}}"><spring:theme code="checkout.summary.deliveryAddress.edit"/></button>
				</div>
			{{/each}}
		</form>
	{{/if}}
</script>

<c:set value="${not empty deliveryAddress}" var="deliveryAddressOk"/>

<div class="checkout_summary_flow_a ${deliveryAddressOk ? 'complete' : ''}" id="checkout_summary_deliveryaddress_div">
	<div class="item_container_holder">
		<ycommerce:testId code="checkout_deliveryAddressData_text">
			<div class="title_holder">
				<div class="title">
					<div class="title-top">
						<span></span>
					</div>
				</div>
				<h2><spring:theme code="checkout.summary.deliveryAddress.header" htmlEscape="false"/><span></span></h2>
			</div>

			<div class="item_container">
				<ul>
					<c:choose>
						<c:when test="${deliveryAddressOk}">
							<li>${fn:escapeXml(deliveryAddress.title)}&nbsp;${fn:escapeXml(deliveryAddress.firstName)}&nbsp;${fn:escapeXml(deliveryAddress.lastName)}</li>
							<li>${fn:escapeXml(deliveryAddress.line1)}</li>
							<li>${fn:escapeXml(deliveryAddress.line2)}</li>
							<li>${fn:escapeXml(deliveryAddress.town)}</li>
							<li>${fn:escapeXml(deliveryAddress.postalCode)}</li>
							<li>${fn:escapeXml(deliveryAddress.country.name)}</li>
						</c:when>
						<c:otherwise>
							<li><spring:theme code="checkout.summary.deliveryAddress.noneSelected"/></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</ycommerce:testId>
	</div>

	<ycommerce:testId code="checkout_changeAddress_element">
		<c:choose>
			<c:when test="${deliveryAddressOk}">
				<a href="#" class="edit_complete change_address_button" address-id="${deliveryAddress.id}"><spring:theme code="checkout.summary.deliveryAddress.editDeliveryAddressButton"/></a>
			</c:when>
			<c:otherwise>
				<button class="form change_address_button" address-id="${deliveryAddress.id}"><spring:theme code="checkout.summary.deliveryAddress.enterDeliveryAddressButton"/></button>
			</c:otherwise>
		</c:choose>
	</ycommerce:testId>
	
</div>

<div style="display:none">
	<div class="" id="popup_checkout_delivery_address">

		<div class="span-20 last" id="checkout_delivery_address">
			<div class="span-10">
				<div class="item_container_holder" id="create_update_address_form_container_div">
					<single-checkout:deliveryAddressForm />
				</div>
			</div>
			<div class="span-10 last">
				<div class="item_container_holder">
					<div class="title_holder">
						<div class="title">
							<div class="title-top">
								<span></span>
							</div>
						</div>
						<h2><spring:theme code="checkout.summary.deliveryAddress.selectExistingAddress"/></h2>
					</div>
					<ycommerce:testId code="checkout_existingAddresses">
						<div class="item_container delivery_addresses_list">
							<%-- List of delivery addresses is injected here --%>
						</div>
					</ycommerce:testId>
				</div>
			</div>
		</div>

	</div>
</div>