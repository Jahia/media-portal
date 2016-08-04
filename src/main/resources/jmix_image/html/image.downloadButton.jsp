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
<template:addResources type="javascript" resources="download-image.js"/>
<c:url value='${currentNode.url}' context='/' var="imgURL"/>

<div class="margin-bottom-20">

    <!-- Getting the portalID -->
    <c:if test="${not empty param['portalID']}">
        <jcr:node var="componentNode" uuid="${param['portalID']}"/>
        <jcr:nodeProperty node="${componentNode}" name="downloadFormats" var="dformats"/>
    </c:if>

    <div class="margin-bottom-20">
        <c:choose>
            <c:when test="${empty dformats}">
        <a class="btn rounded btn-block btn-u" href="<c:url value='${currentNode.url}' context='/'/>"  download="${currentNode.displayableName}">
            <i class="fa fa-download"></i>&nbsp; <fmt:message key="mediaportal.download"/>
        </a>
            </c:when>
        <c:otherwise>
        <!-- Download Split button -->
        <div class="btn-group download-button">
            <a class="btn rounded btn-u dropdown-download" href="<c:url value='${imgURL}' context='/'/>" download="${currentNode.displayableName}"> <i class="fa fa-download"></i>&nbsp;&nbsp;<fmt:message key="mediaportal.download"/></a>
            <button type="button" class="btn rounded btn-u dropdown-toggle dropdown-download" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="caret"></span>
            </button>

                <ul class="dropdown-menu triangle-border top">
                    <li>
                        <div class="oDownload-margin">
                            <h5>  <fmt:message key="mediaportal.download.size"/></h5>
                        </div>
                    </li>

                    <!--  Getting the url for the image format   -->
                    <c:set var="firstValue" value="true"/>
                    <c:forTokens items="${dformats.string}" delims="," var="format">
                        <c:set var="separatorPosition" value="${fn:split(imgURL,'.')}" />
                        <c:set var="fileExtension"     value="${separatorPosition[fn:length(separatorPosition)-1]}"/>
                        <c:set var="fileBasePath"      value="${separatorPosition[fn:length(separatorPosition)-2]}"/>

                        <c:choose>
                            <c:when test="${fn:contains(fileBasePath, '_EPF-FORMAT_')}">
                                <c:set var="originalFormat" value="${fn:split(fn:substringAfter(fileBasePath,'FORMAT_'),'_')[1]}"/>
                                <c:url var="imageFormatUrl" value="${fn:substringBefore(fileBasePath, '_EPF')}_EPF-FORMAT_${format}_${originalFormat}.${fileExtension}" context="/"/>
                            </c:when>
                            <c:otherwise>
                                <c:url  var="imageFormatUrl" value='${fileBasePath}_EPF-FORMAT_${format}_${fileExtension}.${fileExtension}' context='/'/>
                            </c:otherwise>
                        </c:choose>

                        <li>
                            <input type="radio"
                                   id="<c:if test="${firstValue}">radio_1</c:if>"
                                   class="radioType"
                                   style="margin: 0 10px 0 10px;"
                                   name="download-format"
                                   data-url="${imageFormatUrl}">
                            <label>${format}</label>
                        </li>
                        <c:set var="firstValue" value="false"/>
                    </c:forTokens>

                    <!--  Download Button    -->
                    <li>
                        <div  class="oDownload-margin" style="float: right;" >
                            <a id="button-download" class="btn rounded btn-block btn-u btn-oDownload" href="#" download="${currentNode.displayableName}">
                                <fmt:message key="mediaportal.download"/>
                            </a>
                        </div>
                    </li>
                </ul>
        </div>
        </c:otherwise>
        </c:choose>
    </div>
</div>
