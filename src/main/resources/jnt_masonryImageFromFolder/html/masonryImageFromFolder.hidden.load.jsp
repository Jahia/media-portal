<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<jcr:nodeProperty node="${currentNode}" name="source" var="sourceFolder"/>
<jcr:nodeProperty node="${currentNode}" name="thumbnailImg" var="thumbnailImg"/>
<jcr:nodeProperty node="${currentNode}" name="itemLimit" var="itemLimit"/>

<query:definition var="listQuery" limit="${itemLimit.string}">
    <c:choose>
        <c:when test="${currentNode.properties.allowSubDirectories.boolean}">
            <query:descendantNode path="${sourceFolder.node.path}" selectorName="images"/>
        </c:when>
        <c:otherwise>
            <query:childNode path="${sourceFolder.node.path}" selectorName="images"/>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${jcr:isNodeType(currentNode, 'jmix:masonryImageElvisConfig')}">
            <query:selector nodeTypeName="elvismix:file" selectorName="images"/>
        </c:when>
        <c:otherwise>
            <query:selector nodeTypeName="jmix:image" selectorName="images"/>
        </c:otherwise>
    </c:choose>
</query:definition>

<c:set target="${moduleMap}" property="editable" value="false" />
<c:set target="${moduleMap}" property="emptyListMessage"><fmt:message key="label.noNewsFound"/></c:set>
<c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
