<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>

    <c:set var="statement" value="${' '}" />
    <c:set var="sign" value="'" />	
    <c:set var="operator" value="" />
    <c:set var="startQuery" value="0" />

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

	<jcr:nodeProperty node="${currentNode}" name='j:type' var="type"/>		

	<jcr:nodeProperty node="${currentNode}" name='j:nbOfResult' var="nbOfResult"/>
	<c:forEach items="${assignedTags}" var="tag" varStatus="status">
            <c:if test="${not empty tag}">
            	  <c:set var="statement" value="${statement}${operator}${'tags.[j:tagList]= '}${sign}${functions:sqlencode(tag.string)}${sign}${' '}" />
            	  <c:set var="operator" value="${'or '}" />
            	  <c:set var="startQuery" value="1" />
            </c:if>
    </c:forEach>

    <c:choose>
        <c:when test="${startQuery == '1' && not empty type && not empty nbOfResult}">
            <query:definition var="listQuery"
               statement="select * from [${type.string}] as tags where isdescendantnode(tags, '${functions:sqlencode(renderContext.site.path)}') and ${statement} order by tags.[jcr:lastModified] desc"
               limit="${nbOfResult.long}"/>
        </c:when>
    <c:otherwise>
        <c:remove var="listQuery"/>
    </c:otherwise>
    </c:choose>
             
    <%-- Set variables to store the result --%>
    <c:set target="${moduleMap}" property="editable" value="false" />
    <c:set target="${moduleMap}" property="subNodesView" value="parentDisplayableLink" />
    <c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
    <c:set target="${moduleMap}" property="tagSourceNode" value="${tagSourceNode}" />