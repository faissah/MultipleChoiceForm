<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources type="css" resources="qcm.css"/>
<template:addResources>

<script type="text/javascript">
    jQuery.ajaxSettings.traditional = true;
    $.ajaxSetup({
        accepts: {
            script: "application/json"
        },
        cache:false
    })

    function doQcm(answers) {

        var answersList = document.getElementById('form_${currentNode.name}').getElementsByClassName('QcmAnswer');
        answerUUIDs = null;
        var data = {};
        
        for (i=0; i< answersList.length; i++) {
            answer = answersList[i];
            if (answer.checked) {
            	if (answerUUIDs == null)
            		answerUUIDs = answer.value;
            	else
            		answerUUIDs = answerUUIDs.concat(","+answer.value);
            }
        }


        if (answerUUIDs == null) {
            alert("Please select an answer");
        }
        data["answerUUIDs"] = answerUUIDs;
        $.post("<c:url value='${url.base}${currentNode.path}.qcmSubmit.do'/>", data, function(result) {

            var answers = result.goodanswers;

            statDivTest = document.getElementById("resultsContainer_${currentNode.name}");
            if (statDivTest != null) {
                statDivTest.parentNode.removeChild(statDivTest);
            }


            var statDiv = document.createElement("div");
            statDiv.id = "resultsContainer_${currentNode.name}";
            statDiv.innerHTML = "your mark is "+ answers;
            

            document.getElementById("results_${currentNode.name}").appendChild(statDiv);
        }, "json");


    }

</script>
</template:addResources>

	<div class=qcm>
		<h2>${currentNode.properties["qcmFormName"].string}</h2>
		
	    <div id="qcmForm_${currentNode.identifier}">
	        <c:if test="${not renderContext.editMode}">
	        <div id="formContainer_${currentNode.name}">
	            <form id="form_${currentNode.name}" name="form_${currentNode.name}" method="post" >
	                <input type="hidden" name="jcrReturnContentType" value="json"/>
                </c:if>
		
		        <c:forEach items="${currentNode.nodes}" var="qcmQuestion">
			    	<c:if test="${jcr:isNodeType(qcmQuestion,'jnt:qcmQuestion')}">
			        	<template:module node="${qcmQuestion}" view="default"/>
			    	</c:if>
			    </c:forEach>
			    <c:if test="${renderContext.editMode}">
		    		<template:module path="*"/>
				</c:if>
				
               	<c:if test="${not renderContext.editMode}">
                <div class="validation"></div>
                <br />
                <input class="button" type="button" value="Submit" onclick="doQcm($('${currentNode.name}_voteAnswer').value);" />
            </form>
        </div>
        </c:if>
        <div id="results_${currentNode.name}"></div>     
    </div>
