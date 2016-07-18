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
    <template:addResources type="javascript" resources="masonry.pkgd.min.js"/>
    <template:addResources type="javascript" resources="masonryImageFromFolder.js"/>
    <template:addResources type="javascript" resources="imagesloaded.pkgd.js"/>
    <template:addResources type="css" resources="masonryImageFromFolder.css"/>

<%-- We can reuse the code for the views --%>
<template:module view="hidden.tags-elvisConfig"></template:module>

<template:addResources><style>.masonryGrid-item, .masonryGrid img  {width: ${colwidth}px;}</style></template:addResources>

<%-- How many items to show at first? --%>
<c:set value="20" var="startItems"/>
<%-- How many items to load? lets --%>
<c:set value="10" var="loadItems"/>

<div class="grid" colwidth="${colwidth}">
    <c:choose>
<c:when test="${jcr:isNodeType(currentNode, 'jmix:masonryImageElvisConfig')}">
    <c:forEach items="${moduleMap.currentList}" var="imageChild">
<c:if test="${currentNode.properties.thumbnailImg.string eq imageChild.properties.previewFormatName.string}">
    <template:module node="${imageChild}" view="masonry.elvis" editable="false">
    <template:param name="thumbnailImg" value="${currentNode.properties.thumbnailImg.string}"/>
    <template:param name="fullPageImg" value="${currentNode.properties.fullPageImg.string}"/>
    <template:param name="portalID" value="${currentNode.identifier}"/>
    </template:module>
</c:if>
</c:forEach>
</c:when>
<c:otherwise>
    <c:forEach items="${moduleMap.currentList}" var="imageChild" end="${startItems}">
        <c:if test="${not jcr:isNodeType(imageChild, 'elvismix:file')}">
            <template:module node="${imageChild}" view="masonry" editable="false">
                <template:param name="thumbnailtype" value="${currentNode.properties.thumbnailType.string}" />
                <template:param name="portalID" value="${currentNode.identifier}"/>
            </template:module>
        </c:if>
    </c:forEach>
    <template:addResources>
        <script type="text/javascript">
            var start = ${startItems}
            var finish = ${loadItems}
            var docLoading = false;

            //Create an array with the path/url from the items of the list
            //Then append the result HTML from each url, from a start-end using an offset
            function getNext(begin, offset, $containerElement){
                var end = begin + offset;
                var url = ["0"<c:forEach items="${moduleMap.currentList}" var="itemIn" begin="${startItems}" >,"${url.base}${itemIn.path}.masonry.html.ajax"</c:forEach>];
                //Check if our array length is greater than the next index
                if (url.length > begin) {
                    for (i = begin; i < end; i++) {
                        if (i<url.length) {
                            $.ajax({
                                type: "GET",
                                url: url[i],
                                async: true,
                                success: function (content) {
                                    var $content = $( content );
                                    // add jQuery object
                                    $containerElement.append( $content ).masonry( 'appended', $content );
                                    //Resize, fix for chrome
                                    $containerElement.masonry('layout');
                                    //Stop flag
                                    docLoading = false;
                                    start = end;
                                },
                                error: function (ajaxContext) {
                                    console.log("Error getting the next item at the url: "+url[i])
                                    docLoading =true;
                                }
                            });
                        } else {
                            docLoading = true;
                        }
                    }
                }
                return true;
            }
        </script>
    </template:addResources>
</c:otherwise>
</c:choose>

    </div>
<div class="clear"></div>
<div class="clear"></div>
<template:addResources>
    <script>
        $(document).ready(function() {
            var $grid = $('.grid').masonry({
                // specify itemSelector so stamps do get laid out
                itemSelector: '.masonryGrid-item',
                columnWidth: 150
            });
            // layout Isotope after each image loads
            $grid.imagesLoaded().progress( function() {
                $grid.masonry();
            });
            $(window).scroll(function () {
                if (!docLoading && $(window).scrollTop() + $(window).height() == $(document).height()) {
                    //stop flag
                    docLoading = true;
                    //Get next series of items to show
                    getNext(start, finish, $grid);
                }
            });
        });
    </script>
</template:addResources>