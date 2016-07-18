

<c:set var="currentPage" value="${jcr:findDisplayableNode(currentNode,renderContext )}"/>
<div class="row">
    <form action="<c:url value="${url.base}${currentPage.url}" context="/"/>" method="GET" class="tagfilterform">
        <input class="tags" name="tags"/>
        <input class="previoustags"  type="hidden" name="previoustags" value="${param['tags']}"/>
        <input type="submit" value="<fmt:message key="mediaportal.add"/>" />
    </form>

    <form action="<c:url value="${url.base}${currentPage.url}" context="/"/>" method="GET" class="resettagform">
        <input type="submit" value="<fmt:message key="mediaportal.reset"/>" />
    </form>

    <ul class="list-inline tags-v2">
        <c:forEach items="${moduleMap.taglist}" var="tag" varStatus="status">
            <c:if test="${not empty tag}">
                <li>
                    <a>${functions:sqlencode(tag)}</a>
                    <a class="removeTag" tag="${functions:sqlencode(tag)}" href="#">X</a>
                </li>
            </c:if>
        </c:forEach>
    </ul>
</div>
<c:if test="${renderContext.editMode}">
    <h1>${currentNode.displayableName}</h1>
</c:if>
<c:set value="${currentNode.properties.source.node}" var="sourceFolder"/>
<c:set value="150" var="colwidth"/>

<c:choose>
    <c:when test="${jcr:isNodeType(currentNode, 'jmix:masonryImageElvisConfig')}">
        <c:set value="${currentNode.properties.colwidth.string}" var="colwidth"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${currentNode.properties.thumbnailType.string eq 'thumbnail'}">
                <c:set value="150" var="colwidth"/>
            </c:when>
            <c:otherwise>
                <c:set value="350" var="colwidth"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
