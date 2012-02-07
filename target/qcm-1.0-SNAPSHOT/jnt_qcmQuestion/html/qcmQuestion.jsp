<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:addResources type="javascript" resources="jquery.min.js"/>
<jcr:node var="answerNode" path="${currentNode.path}/answerslist"/>

<div class=qcm_question>
    <h3>
        ${currentNode.propertiesAsString['question']}
    </h3>
	    <div class="addanswers">
	        <c:if test="${renderContext.editMode}">
	        <span>Please, add answers </span>
	        </c:if> 
	        <c:forEach items="${answerNode.nodes}" var="formElement">
        		<template:module node="${formElement}" editable="true"/>
    		</c:forEach>
    		<div class="addaction">
        	<template:module node="${answerNode}" view="hidden.placeholder"/>
    </div>
	    </div>
</div>