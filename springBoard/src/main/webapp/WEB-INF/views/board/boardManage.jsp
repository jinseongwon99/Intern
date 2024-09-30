<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardUpdate</title>
</head>
<script type="text/javascript">
    $j(document).ready(function() {
        function handleRequest(actionUrl, successMessage) {
            var $frm = $j('.boardManage :input');
            var param = $frm.serialize();
            
            $j.ajax({
                url: actionUrl,
                dataType: "json",
                type: "POST",
                data: param,
                success: function(data, textStatus, jqXHR) {
                    alert(successMessage);
                    alert("메세지:" + data.success);
                    location.href = "/board/boardList.do"; //"/board/boardList.do?pageNo="
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert("실패");
                }
            });
        }

        $j("#update").on("click", function() {
            handleRequest("/board/boardUpdateAction.do", "수정완료");
        });

        $j("#delete").on("click", function() {
            handleRequest("/board/boardDeleteAction.do", "삭제완료");
        });
    });
</script>
<body>
<form class="boardManage">
	<table align="center">
		<tr>
			<td align="right">
			<input id="update" type="button" value="수정">
			<input id="delete" type="button" value="삭제">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						<input name="boardType" type="hidden" value="${board.boardType}"> 
						<input name="boardNum" type="hidden" value="${board.boardNum}">
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
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