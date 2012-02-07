<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="answerSpanClass" value="qcm_answer"/>

<c:if test="${renderContext.editMode}">
	<c:set var="answerSpanClass" value="qcm_answer_${currentNode.properties.goodAnswer.string}"/>
	<c:set var="disabled" value='disabled="disabled"' />
</c:if>

<span class="${answerSpanClass}">
	<input type="radio" id="${currentNode.parent.parent.name}_qcmAnswer" name="${currentNode.parent.parent.name}" value="${currentNode.UUID}" class="QcmAnswer" ${disabled}/> ${currentNode.properties.label.string}
</span>
<br />