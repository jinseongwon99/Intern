<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Login</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#submit").on("click", function() {
        var $frm = $('.loginAction :input');
        var param = $frm.serialize();
        
        $.ajax({
            url: "/board/loginAction.do",
            type: "POST",
            data: param,
            dataType: "json",
            success: function(data) {
                if (data.success === "Y") {
                    alert(data.message);
                    location.href = "/board/boardList.do"; 
                } else {
                    alert(data.message); 
                }
            },
        });
    });
});
</script>

<style>

.button-container {
    text-align: right;
}
</style>
</head>
<body>
<table align="center">
    <tr>
        <td>
            <table id="topTable" width="380">
                <tr>
                    <td align="left">
                        <a href="/board/boardList.do">List</a>
                    </td>
                </tr>               
            </table>
        </td>
    </tr>
    <tr>    
        <td>
            <form class="loginAction">
                <table id="boardTable" border="1">
                    <tr>
                        <td width="130" align="center">
                            ID
                        </td>
                        <td width="250" align="left">
                            <input type="text" id="userId" name="userId">
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">
                            PW
                        </td>
                        <td width="250" align="left">
                            <input type="password" id="userPw" name="userPw">
                        </td>
                    </tr>    
                </table>
                <div class="button-container">
                   <input type="button" id="submit" value="Login">
               </div>
            </form>
        </td>
    </tr>
</table>    
</body>
</html>
