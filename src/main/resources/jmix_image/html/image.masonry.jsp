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

    <c:choose>
        <c:when test="${thumbnailtype eq 'thumbnail'}">
            <c:set value="${currentNode.thumbnailUrls.thumbnail}" var="thumbnailURL"/>
        </c:when>
        <c:otherwise>
            <c:set value="${currentNode.thumbnailUrls.thumbnail2}" var="thumbnailURL"/>
        </c:otherwise>
    </c:choose>



<div class="masonryGrid-item">
    <a href="<c:url value='${url.base}${currentNode.path}.image-temp.html?portalID=${portalID}' context='/'/>" title="${currentNode.displayableName}" >
        <c:if test="${fn:length(currentNode.thumbnails) ne 0}">
                <img class="img-responsive" src="<c:url value='${thumbnailURL}' context='/'/>" alt="${currentNode.displayableName}">
        </c:if>
    </a>
</div>