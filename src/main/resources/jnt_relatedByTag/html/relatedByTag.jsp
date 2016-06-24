<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:include view="hidden.header"/>

<div class="headline"><h2><fmt:message key="mediaportal.similarphotos"/></h2></div>
<c:choose>
    <c:when test="${not empty moduleMap.currentList && functions:length(moduleMap.currentList) > 0}">
        <ul class="list-inline blog-photostream margin-bottom-50">
            <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}">
                <c:if test="${subchild != moduleMap.tagSourceNode}">
                    <template:module node="${subchild}" view="relatedByTag"/>
                </c:if>
            </c:forEach>
        </ul>
    </c:when>
    <c:when test="${not empty moduleMap.emptyListMessage}">
        ${moduleMap.emptyListMessage}
    </c:when>
</c:choose>
<c:if test="${moduleMap.editable and renderContext.editMode && !resourceReadOnly}">
    <template:module path="*"/>
</c:if>
<div class="clear"></div>
<template:include view="hidden.footer"/>