<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$j(document).ready(function() {
    function checkSelectAll() {
        const checkboxes = $('input[name="type"]');
        const selectAll = $('input[name="selectall"]');
        selectAll.prop('checked', checkboxes.length === $('input[name="type"]:checked').length);
    }

    function ListData(pageNo) {
        const selectType = $('input[name="type"]:checked').map(function() {
            return $(this).val();
        }).get().join(',');

        $j.ajax({
            url: '/board/boardList.do',
            type: 'GET',
            data: { type: selectType, pageNo: pageNo },
            success: function(response) {
                $('#boardTable').html($(response).find('#boardTable').html());
                $('#pagination').html($(response).find('#pagination').html());
                $('#topTable').html($(response).find('#topTable').html());  
            },
            error: function(jqXHR, textStatus) {
                alert("조회 실패: " + textStatus);
            }
        });
    }

    $j('input[name="selectall"]').on('change', function() {
        $('input[name="type"]').prop('checked', this.checked);
    });

    $j('input[name="type"]').on('change', checkSelectAll);

    $j('#submitFilter').on('click', function() {
        const pageNoToSend = ($('#currentPageNo').val() > 1) ? '1' : $('#currentPageNo').val();
        ListData(pageNoToSend);
    });

    $j(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        ListData($(this).data('page'));
    });

    checkSelectAll();
});
</script>

  <%
    String sessionId = (String) session.getAttribute("userid");
    %>
    
</head>
<body>
<table align="center">
    <tr>
        <td>
            <table id="topTable" width="435">
                <tr>
                    <c:choose>
                        <c:when test="${userid == null}">
                            <td align="left">
                                <a href="/board/loginPage.do">login</a>
                                <a href="/board/joinPage.do">join</a>
                            </td>
                        </c:when>
                        <c:otherwise>
                            <td align="left">
                                ${userid}
                            </td>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table id="boardTable" border="1">
                <tr>
                    <td width="80" align="center">Type</td>
                    <td width="40" align="center">No</td>
                    <td width="300" align="center">Title</td>
                </tr>
                <c:forEach items="${boardList}" var="list">
                    <tr>
                        <td align="center">
                            <c:forEach items="${codeList}" var="code">
                                <c:choose>
                                    <c:when test="${list.boardType == code.codeId}">
                                        ${code.codeName}
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </td>
                        <td>${list.boardNum}</td>
                        <td>
                            <a href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </td>
    </tr>
    <tr>
        <td align="right">
            <a href="/board/boardWrite.do">글쓰기</a>
             <%if(sessionId != null) { %>
			<a href="${pageContext.request.contextPath}/board/logout.do">로그아웃</a>									
			<%} %>
        </td>
    </tr>
    <tr>
        <td align="left">
            <form id="filterForm">
                <input type="hidden" id="currentPageNo" value="${pageNo}">
                <input type="hidden" id="selectTypeParam" name="type" value="${selectTypeParamParam}">
                <input type="checkbox" value="selectall" name="selectall"> 전체
                <c:forEach var="code" items="${codeList}">
                    <input type="checkbox" name="type" value="${code.codeId}"
                        <c:if test="${fn:contains(selectTypeParam, code.codeId)}">checked</c:if>>
                    ${code.codeName}
                </c:forEach>
                <input type="button" id="submitFilter" value="조회">
            </form>
        </td>
    </tr>
    <tr>
        <td align="center">
            <div id="pagination">
                <c:if test="${currentGroup > 0}">
                    <a href="#" data-page="${endPage - 5}" class="page-link">&lt;</a>
                </c:if>

                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == pageNo}">
                            <strong>${i}</strong>
                        </c:when>
                        <c:otherwise>
                            <a href="#" data-page="${i}" class="page-link">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${endPage < totalPages}">
                    <a href="#" data-page="${endPage + 1}" class="page-link">&gt;</a>
                </c:if>
            </div>
        </td>
    </tr> 
</table>
</body>
</html>
