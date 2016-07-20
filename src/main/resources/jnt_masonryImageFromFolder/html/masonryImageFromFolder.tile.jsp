<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:include view="hidden.header"/>
<template:addResources type="css" resources="masonryImageFromFolder.css"/>
<template:addResources type="css" resources="tiles.css"/>
<template:addResources type="javascript" resources="masonryImageFromFolder.js"/>

<c:if test="${not renderContext.editMode}">
    <template:addResources type="javascript" resources="jquery.tile.js"/>
    <template:addResources type="javascript" resources="masonryImageFromFolder.tile.js"/>
</c:if>
<%-- Some edit mode styling --%>
<c:if test="${renderContext.editMode}">
    <style> #card-tiles{display: flex;} .thumbnail-img {float: left;} </style>
</c:if>

<%-- We can reuse the code for the views --%>
<template:include view="hidden.tags-elvisConfig" />


<div id="card-tiles">
    <c:choose>
        <c:when test="${jcr:isNodeType(currentNode, 'jmix:masonryImageElvisConfig')}">
            <c:forEach items="${moduleMap.currentList}" var="imageChild">
                <c:if test="${currentNode.properties.thumbnailImg.string eq imageChild.properties.previewFormatName.string}">
                    <template:module node="${imageChild}" view="tile.elvis" editable="false">
                        <template:param name="thumbnailImg" value="${currentNode.properties.thumbnailImg.string}"/>
                        <template:param name="fullPageImg" value="${currentNode.properties.fullPageImg.string}"/>
                        <template:param name="portalID" value="${currentNode.identifier}"/>
                    </template:module>
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <c:forEach items="${moduleMap.currentList}" var="imageChild">
                <c:if test="${not jcr:isNodeType(imageChild, 'elvismix:file')}">
                    <template:module node="${imageChild}" view="tile" editable="false">
                        <template:param name="thumbnailtype" value="${currentNode.properties.thumbnailType.string}" />
                        <template:param name="portalID" value="${currentNode.identifier}"/>
                    </template:module>
                </c:if>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <div class="clear"></div>
</div>
