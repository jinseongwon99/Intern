<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 0 auto;
    }
    td {
        text-align: center;
        vertical-align: middle;
    }
    label {
        font-size: 25px;
        color: #000;
        vertical-align: middle;
    }
    input[type=radio] {
        vertical-align: middle;
        margin: 5px;
    }
    button {
        background-color: skyblue;
        color: white;
        border: none;
        padding: 10px 30px;
    }
    .result-container {
        display: flex;
        justify-content: center;
    }
    
	.good{
		accent-color: green;
	}
	.bad{
		accent-color: purple;
	}
	.none{
		accent-color: gray;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    let currentStatus = ${mbtiStatus};

    function collectAnswers() {
        let answers = {};

        $("input[type=radio]:checked").each(function() {
            let name = $(this).attr('name'); 
            let id = $(this).attr('id');     
            let value = $(this).val();       

            answers[name] = {
                id: id,
                value: value
            };
        });

        return answers;    
    }

    function checkMbti() {
        let answers = collectAnswers();
        let currentStatus = ${mbtiStatus};

        $.ajax({
            url: '/board/mbtiCheck.do',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                answers: answers,
                mbtiStatus: currentStatus
            }),
            success: function(response) {
                pageMbti();
            },
        });
    }

    function pageMbti() {
        $.ajax({
            url: '/board/mbtiPage.do',
            type: 'GET',
            data: { status: currentStatus },
            success: function(response) {
                $('#mbtiPage').html(response);
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }
        });
    }

    function radioCheck() {
        let allAnswered = true;

        $("tr").each(function() {
            let $row = $(this);
            if ($row.find("input[type=radio]").length > 0) {
                let answered = $row.find("input[type=radio]:checked").length > 0;
                if (!answered) {
                    allAnswered = false;
                    return false; 
                }
            }
        });

        if (!allAnswered) {
            alert("모든 질문에 대해 답변을 선택해 주세요.");
        }

        return allAnswered;
    }

    $('#nextButton').click(function() {
        if (radioCheck()) {
            currentStatus++;
            checkMbti(); 
        }
    });

});

function scrollToDisagree(index) {
    let disagreeLabel = document.getElementById('disagree_' + index);
    if (disagreeLabel) {
        let offset = disagreeLabel.getBoundingClientRect().bottom + window.scrollY;
        window.scrollTo({
            top: offset + 20,
            behavior: 'smooth'
        });
    }
}

</script>
</head>
<body>
<form class="mbtiPage" id="mbtiPage">
    <table>
    <c:set var="startIndex" value="0" />
    <c:set var="endIndex" value="5" />

    <c:choose>
        <c:when test="${mbtiStatus == 1}">
            <c:set var="startIndex" value="5" />
            <c:set var="endIndex" value="10" />
        </c:when>
        <c:when test="${mbtiStatus == 2}">
            <c:set var="startIndex" value="10" />
            <c:set var="endIndex" value="15" />
        </c:when>
        <c:when test="${mbtiStatus == 3}">
            <c:set var="startIndex" value="15" />
            <c:set var="endIndex" value="20" />
        </c:when>
    </c:choose>
    <c:if test="${mbtiStatus < 4}">
        <c:forEach var="Question" items="${QuestionList.subList(startIndex, endIndex)}" varStatus="status">
            <tr>
                <td colspan="2">
                    <h2>${Question.boardComment}</h2>
                </td>
            </tr>
            <tr>
				<td colspan="2">
				    <label>동의</label>
				    <input type='radio' name='answer_${status.index}' class= "good"  id="${Question.boardType}" style="width:100px;height:100px;border:1px;" value="7" onclick="scrollToDisagree(${status.index})" />
				    <input type='radio' name='answer_${status.index}' class= "good"  id="${Question.boardType}" style="width:80px;height:80px;border:1px;" value="6" onclick="scrollToDisagree(${status.index})" />
				    <input type='radio' name='answer_${status.index}' class= "good"  id="${Question.boardType}" style="width:60px;height:60px;border:1px;" value="5" onclick="scrollToDisagree(${status.index})" />
				    <input type='radio' name='answer_${status.index}' class= "none"  id="${Question.boardType}" style="width:40px;height:40px;border:1px;" value="4" onclick="scrollToDisagree(${status.index})" />
				    <input type='radio' name='answer_${status.index}' class= "bad"  id="${Question.boardType}" style="width:60px;height:60px;border:1px;" value="3" onclick="scrollToDisagree(${status.index})" />
				    <input type='radio' name='answer_${status.index}' class= "bad"  id="${Question.boardType}" style="width:80px;height:80px;border:1px;" value="2" onclick="scrollToDisagree(${status.index})" />
				    <input type='radio' name='answer_${status.index}' class= "bad"  id="${Question.boardType}" style="width:100px;height:100px;border:1px;" value="1" onclick="scrollToDisagree(${status.index})" />
				    <label id="disagree_${status.index}" style="margin-left:10px;">비동의</label>
				</td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${mbtiStatus == 4}">
	    <tr>
	        <td colspan="2">
	        <h1>당신의 성격 유형은:</h1>
	           <div class="result-container">
	               <h2 id="e_i_result">${sessionScope.E_I}</h2>
	               <h2 id="n_s_result">${sessionScope.N_S}</h2>
	               <h2 id="f_t_result">${sessionScope.F_T}</h2>
	               <h2 id="j_p_result">${sessionScope.J_P}</h2>
	           </div>
	        </td>
	    </tr>
	</c:if>
    <tr>
        <td>
            <c:choose>
                <c:when test="${mbtiStatus < 3}">
                    <button type="button" id="nextButton">다음</button>
                </c:when>
                <c:when test="${mbtiStatus == 3}">
                    <button type="button" id="nextButton">완료</button>
                </c:when>
            </c:choose>
        </td>
    </tr>
</table>
</form>
</body>
</html>
