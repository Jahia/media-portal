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
<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources type="css" resources="jquery.autocomplete.css"/>
<template:addResources type="css" resources="thickbox.css"/>
<template:addResources type="javascript" resources="jquery.autocomplete.js"/>
<template:addResources type="javascript" resources="jquery.bgiframe.min.js"/>
<template:addResources type="javascript" resources="thickbox-compressed.js"/>
<script type="text/javascript">
    $(document).ready(function() {
        $(".newTagInput${currentNode.identifier}").autocomplete("<c:url value='${url.base}${currentNode.properties.source.node.path}.matchingTags.do'/>", {
            multiple:true,
            multipleSeparator:",",
            dataType: "json",
            cacheLength: 1,
            parse: function parse(data) {
                var parsed = [];
                if(data.tags && data.tags.length > 0){
                    for (var i=0; i < data.tags.length; i++) {
                        parsed[parsed.length] = {
                            data: [data.tags[i].name],
                            value: data.tags[i].name,
                            result: data.tags[i].name
                        }
                    }
                }
                return parsed;
            }
        });
    });
</script>
<c:set var="currentPage" value="${jcr:findDisplayableNode(currentNode,renderContext )}"/>

<div class="row">
    <div class="form-group">
        <form action="<c:url value="${url.base}${currentPage.url}" context="/"/>" method="GET" class="tagfilterform">
            <input class="currenttag newTagInput${currentNode.identifier}" type="text"/>
            <input class="tags" type="hidden" name="tags" value=""/>
            <input class="previoustags"  type="hidden" name="previoustags" value="${param['tags']}"/>
            <input type="submit" class="tagButton" value="<fmt:message key="mediaportal.add"/>" />
        </form>

        <form action="<c:url value="${url.base}${currentPage.url}" context="/"/>" method="GET" class="resettagform">
            <input type="submit" class="tagButton" value="<fmt:message key="mediaportal.reset"/>" />
        </form>
    </div>
    <ul class="list-inline tags-v2">
        <c:forEach items="${moduleMap.taglist}" var="tag" varStatus="status">
            <c:if test="${not empty tag}">
                <li>
                    <a   href="#">${functions:sqlencode(tag)}</a>
                    <span class="removeTag boxclose" title="<fmt:message key="jnt_masonryImageFromfolder.tag-elvisConfig.remove"/>" tag="${functions:sqlencode(tag)}"></span>
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


<c:set target="${moduleMap}" property="colwidth" value="${colwidth}" />

