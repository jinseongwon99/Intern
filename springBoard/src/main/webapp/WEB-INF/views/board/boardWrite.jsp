<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
<script type="text/javascript">
    $j(document).ready(function(){
        $j("#submit").on("click", function(){
            var $frm = $j('.boardWrite :input');
            var param = $frm.serialize();
            
            $j.ajax({
                url: "/board/boardWriteAction.do",
                dataType: "json",
                type: "POST",
                data: param,
                success: function(data, textStatus, jqXHR) {
                    alert("작성완료");
                    alert("메세지:" + data.success);
                    location.href = "/board/boardList.do"; /* "/board/boardList.do?pageNo=" */
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("실패");
                }
            });
        });
    });
    
    <%
    String sessionId = (String) session.getAttribute("userid");
    %>
</script>
</head>
<body>
<form class="boardWrite">
  	  <table align="center">
			        <tr>
			            <td align="right">
			                <input id="submit" type="button" value="작성">
							<input id="submit" type="button" value="행추가">
			            </td>
			        </tr>
			        <tr>
			            <td>
			                <table border="1">
			                  <tr>
			            <td width="120" align="center">Type</td>
			            <td>
			                <select name="boardType">
			                    <c:forEach var="code" items="${codeList}">
			                        <option value="${code.codeId}">${code.codeName}</option>
			                    </c:forEach>
			                </select>
			            </td>
			        </tr>
                    <tr>
                        <td width="120" align="center">Title</td>
                        <td width="400">
                            <input name="boardTitle" type="text" size="50" value="${board.boardTitle}">
                        </td>
                    </tr>
                    <tr>
                        <td height="300" align="center">Comment</td>
                        <td valign="top">
                            <textarea name="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">Writer</td>
                        <td>
                        <input name="Creator" type="text" size="50" value="${userid}" readonly="readonly">                           
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="right">
                <a href="/board/boardList.do">List</a>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
