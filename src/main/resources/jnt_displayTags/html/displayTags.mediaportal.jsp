<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="uiComponents" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="acl" type="java.lang.String"--%>
<template:addResources type="css" resources="pagetagging.css"/>
<template:addResources type="css" resources="tagged.css"/>
<template:addResources type="css" resources="masonryImageFromFolder.css"/>


<c:set var="boundComponent"
       value="${uiComponents:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
<c:if test="${not empty boundComponent}">
    <c:set var="nodeLocked" value="${not jcr:hasPermission(boundComponent, 'jcr:modifyProperties_default') or jcr:isLockedAndCannotBeEdited(boundComponent)}"/>
    <div id="tagThisPage${boundComponent.identifier}" class="tagthispage">

        <jcr:nodeProperty node="${boundComponent}" name="j:tagList" var="assignedTags"/>
        <c:if test="${not nodeLocked}">
            <template:tokenizedForm allowsMultipleSubmits="true">
                <form id="deleteTagForm_${fn:replace(boundComponent.identifier, "-", "_")}" action="<c:url value="${url.base}${boundComponent.path}"/>.removeTag.do" method="post">
                    <input type="hidden" name="tag">
                    <input type="hidden" name="unescape">
                </form>
            </template:tokenizedForm>
            <script type="text/javascript">
                function deleteTag_${fn:replace(boundComponent.identifier, "-", "_")} (htmlDeleteLink) {
                    var tagItem = $(htmlDeleteLink).parent();
                    var tag = htmlDeleteLink.dataset.tag;
                    $.post("<c:url value="${url.base}${boundComponent.path}"/>.removeTag.do", {"tag":tag, "unescape":true, "form-token": $('#deleteTagForm_${fn:replace(boundComponent.identifier, "-", "_")}').find("input[name='form-token']").val()}, function(result) {
                        tagItem.hide();
                        if(result.size == "0"){
                            var spanNotYetTag = $('<span><fmt:message key="label.tags.notag"/></span>').attr('class', 'notaggeditem${boundComponent.identifier}');
                            $("#jahia-tags-${boundComponent.identifier}").append(spanNotYetTag)
                        }
                    }, "json");
                    return false;
                }
            </script>
        </c:if>
        <div class="tagged">
            <div class="headline"><h2><fmt:message key="label.tags"/></h2></div>
                <c:choose>
                    <c:when test="${not empty assignedTags}">
                        <ul class="list-inline tags-v2 margin-bottom-20">
                            <c:forEach items="${assignedTags}" var="tag" varStatus="status">
                                <li>
                                    <a href="#"> ${fn:escapeXml(tag.string)} </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <span class="notaggeditem${boundComponent.identifier}"><fmt:message
                                key="label.tags.notag"/></span>
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
</c:if>
