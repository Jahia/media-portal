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
<c:url value='${currentNode.url}' context='/' var="imgURL"/>
<c:choose>
    <c:when test="${not empty fullPageImg}">
        <c:set var="thumbnailFormat" value="FORMAT_${thumbnailImg}"/>
        <c:set var="fullPageFormat" value="FORMAT_${fullPageImg}"/>
        <c:set var="fullPageImagePath" value="${fn:replace(currentNode.path, thumbnailFormat, fullPageFormat)}" />
    </c:when>
    <c:otherwise>
        <c:set value="${fn:split(currentNode.path,'.')}" var="separatorPosition" />
        <c:set var="fileExtension" value="${separatorPosition[fn:length(separatorPosition)-1]}"/>
        <c:set var="fullPageImagePath"
               value="${fn:substring(currentNode.path,0, fn:indexOf(currentNode.path,'_EPF-'))}.${fileExtension}" />
    </c:otherwise>
</c:choose>

<div class="thumbnail-img">
    <a href="<c:url value='${url.base}${fullPageImagePath}.image-temp.html?portalID=${portalID}' context='/'/>" title="${imageChild.displayableName}" data-gallery>
        <img class="img-responsive" src="${imgURL}" alt="${imageChild.displayableName}">
    </a>
</div>

