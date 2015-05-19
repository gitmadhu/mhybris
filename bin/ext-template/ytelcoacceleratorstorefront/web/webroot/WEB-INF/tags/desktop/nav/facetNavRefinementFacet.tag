<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="facetData" required="true" type="de.hybris.platform.commerceservices.search.facetdata.FacetData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<c:if test="${not empty facetData.values}">
	<div class="item">
		<div class="category" >
			<spring:theme code="text.toggleFacet" var="toggleFacetText"/>
			<a href="#" onclick="$(this).closest('div.item').find('div.facetValues').slideToggle();$(this).toggleClass('toggleArrow');return false;" title="${toggleFacetText}">
				<h4><spring:theme code="search.nav.facetTitle" arguments="${facetData.name}"/></h4>							
			</a>
			<a href="#" onclick="$(this).closest('div.item').find('div.facetValues').slideToggle();$(this).toggleClass('toggleArrow');return false;" title="${toggleFacetText}">							
				<span class="dropdown">				
					<span class="dropdown-img" ></span>						
				</span>
			</a>
		</div>

		<ycommerce:testId code="facetNav_facet${facetData.name}_links">
			<div class="facetValues">
				<c:if test="${not empty facetData.topValues}">
					<div class="topFacetValues">
						<ul class="facet_block ${facetData.multiSelect ? '' : 'indent'}">
							<c:forEach items="${facetData.topValues}" var="facetValue">
								<li>
									<c:if test="${facetData.multiSelect}">
										<form action="#" method="get">
											<input type="hidden" name="q" value="${facetValue.query.query.value}"/>
											<input title="${facetValue.name}" type="hidden" name="text" value="${searchPageData.freeTextSearch}"/>
											<label class="facet_block-label" title="${facetValue.name}">
												<input type="checkbox" ${facetValue.selected ? 'checked="checked"' : ''} onchange="$(this).closest('form').submit()"/>
												${facetValue.name}
											</label>
											<spring:theme code="search.nav.facetValueCount" arguments="${facetValue.count}"/>
										</form>
									</c:if>
									<c:if test="${not facetData.multiSelect}">
										<c:url value="${facetValue.query.url}" var="facetValueQueryUrl"/>
										<a href="${facetValueQueryUrl}&amp;text=${searchPageData.freeTextSearch}" title="${facetValue.name}">${facetValue.name}</a>
										<spring:theme code="search.nav.facetValueCount" arguments="${facetValue.count}"/>
									</c:if>
								</li>
							</c:forEach>
						</ul>						
						<span class="more">
							<a href="#" title="<spring:theme code="search.nav.facetShowMore_${facetData.code}" />" onclick="$(this).closest('div.topFacetValues').hide().siblings('div.allFacetValues').show();return false;"><spring:theme code="search.nav.facetShowMore_${facetData.code}" /></a>
						</span>
					</div>
				</c:if>
				<div class="allFacetValues" style="${not empty facetData.topValues ? 'display:none' : ''}">
					<ul class="facet_block ${facetData.multiSelect ? '' : 'indent'}">
						<c:forEach items="${facetData.values}" var="facetValue">
							<li>
								<c:if test="${facetData.multiSelect}">
									<form action="#" method="get">
										<input type="hidden" name="q" value="${facetValue.query.query.value}"/>
										<input type="hidden" name="text" value="${searchPageData.freeTextSearch}"/>
										<label class="facet_block-label" title="${facetValue.name}">
											<input type="checkbox" title="${facetValue.name}" ${facetValue.selected ? 'checked="checked"' : ''} onchange="$(this).closest('form').submit()"/>
											${facetValue.name}
										</label>
										<spring:theme code="search.nav.facetValueCount" arguments="${facetValue.count}"/>
									</form>
								</c:if>
								<c:if test="${not facetData.multiSelect}">
									<c:url value="${facetValue.query.url}" var="facetValueQueryUrl"/>
									<a href="${facetValueQueryUrl}" 
										<c:if test="${!(facetValue.name eq 'false') and !(facetValue.name eq 'true')}">
											title="${facetValue.name}"
										</c:if>
										<c:if test="${facetValue.name eq 'true'}">
											title="<spring:theme code="search.nav.facetValueTrue"/>"
										</c:if>
										<c:if test="${facetValue.name eq 'false'}">
											title="<spring:theme code="search.nav.facetValueFalse"/>"
										</c:if>	
									>

									<c:if test="${facetValue.name eq 'true'}">
										<spring:theme code="search.nav.facetValueTrue"/>
									</c:if>
									<c:if test="${facetValue.name eq 'false'}">
										<spring:theme code="search.nav.facetValueFalse"/>
									</c:if>
									<c:if test="${!(facetValue.name eq 'false') and !(facetValue.name eq 'true')}">
										${facetValue.name}
									</c:if>									

									</a>
									<spring:theme code="search.nav.facetValueCount" arguments="${facetValue.count}"/>
								</c:if>
							</li>
						</c:forEach>
					</ul>					
					<c:if test="${not empty facetData.topValues}">
						<span class="more">
							<a href="#" onclick="$(this).closest('div.allFacetValues').hide().siblings('div.topFacetValues').show();return false;"><spring:theme code="search.nav.facetShowLess_${facetData.code}" /></a>
						</span>
					</c:if>
				</div>
			</div>
		</ycommerce:testId>
	</div>
</c:if>
