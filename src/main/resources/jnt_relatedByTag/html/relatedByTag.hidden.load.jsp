<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>


    <c:if test="${not empty param['portalID']}">
        <jcr:node var="portal" uuid="${param['portalID']}"/>
        <jcr:nodeProperty node="${portal}" name="source" var="sourceFolder"/>
        <jcr:nodeProperty node="${portal}" name="thumbnailImg" var="thumbnailImg"/>
        <jcr:nodeProperty node="${portal}" name="itemLimit" var="itemLimit"/>
        <jcr:nodeProperty node="${portal}" name="allowSubDirectories" var="allowSubDirectories"/>
    </c:if>

    <c:set var="rootPath" value="${sourceFolder.node.path}"/>
    <c:if test="${empty rootPath}">
        <c:set var="rootPath" value="${renderContext.site.path}"/>
    </c:if>

    <jcr:nodeProperty node="${currentNode}" name='tagSource' var="tagSource"/>
    <c:choose>
        <c:when test="${tagSource.string == 'bound'}">
            <c:set var="tagSourceNode" value="${ui:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
        </c:when>
        <c:when test="${tagSource.string == 'contentref'}">
            <c:set var="tagSourceNode" value="${currentNode.properties.contentRef.node}"/>
        </c:when>
        <c:otherwise>
            <c:set var="tagSourceNode" value="${currentNode}"/>
        </c:otherwise>
    </c:choose>

    <jcr:nodeProperty node="${tagSourceNode}" name="j:tagList" var="assignedTags"/>
	<jcr:nodeProperty node="${tagSourceNode}" name='j:nbOfResult' var="nbOfResult"/>


    <query:definition var="listQuery" limit="${nbOfResult.long}">

        <c:choose>
            <c:when test="${not empty portal and jcr:isNodeType(portal, 'jmix:masonryImageElvisConfig')}">
                <query:selector nodeTypeName="elvismix:file" selectorName="images"/>
            </c:when>
            <c:otherwise>
                <query:selector nodeTypeName="jmix:image" selectorName="images"/>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${empty allowSubDirectories or allowSubDirectories.boolean}">
                <query:descendantNode path="${rootPath}" selectorName="images"/>
            </c:when>
            <c:otherwise>
                <query:childNode path="${rootPath}" selectorName="images"/>
            </c:otherwise>
        </c:choose>

        <query:or>
            <c:forEach items="${assignedTags}" var="tag" varStatus="status">
                <c:if test="${not empty tag}">
                    <query:equalTo value="${functions:sqlencode(tag.string)}" propertyName="j:tagList"/>
                </c:if>
            </c:forEach>
        </query:or>

    </query:definition>

    <%-- Set variables to store the result --%>
    <c:set target="${moduleMap}" property="editable" value="false" />
    <c:set target="${moduleMap}" property="subNodesView" value="parentDisplayableLink" />
    <c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
    <c:set target="${moduleMap}" property="tagSourceNode" value="${tagSourceNode}" />