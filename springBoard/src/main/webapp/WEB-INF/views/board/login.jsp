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
    
    $("#name").on('input', function() {
        var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:"'\\]/g;
        var v = $(this).val();

        v = v.replace(regexp, '');

        if (v.length > 5) {
            v = v.substring(0, 5);
        }

        $(this).val(v);
    });

    $('#phone').on('input', function() {
        var input = $(this).val().replace(/[^0-9]/g, '');

        if (input.length > 11) input = input.slice(0, 11);

        $(this).val(input);
    });

    $("#submit").on("click", function() {
        var name = $("#name").val();
        var phone = $("#phone").val();
        
        if (name === "") {
            alert("이름을 입력해야 합니다.");
            $("#name").focus();
            return;
        }

        if (phone === "") {
            alert("휴대폰 번호를 입력해야 합니다.");
            $("#phone").focus();
            return;
        }

        if (phone.length !== 11) {
            alert("휴대폰 번호는 11자리여야 합니다.");
            $("#phone").focus();
            return;
        }

        var $frm = $('.recruitAction :input');
        var param = $frm.serialize();
        
        $.ajax({
            url: "/board/recruitAction.do",
            type: "POST",
            data: param,
            dataType: "json",
            success: function(data) {
                if (data.success === "Y") {
                    location.href = "/board/main.do"; 
                } else if (data.success === "K") {
                    location.href = "/board/main.do"; 
                }
            },
        });
    });
});

</script>
</head>
<body>
<table align="center">
    <tr>    
        <td>
            <form class="recruitAction">
                <table id="boardTable" border="1">
                    <tr>
                        <td width="100%" align="center">
                            이름
                        </td>
                        <td width="100%" align="left">
                            <input type="text" id="name" name="name">
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" align="center">
                            휴대폰번호
                        </td>
                        <td width="100%" align="left">
                            <input type="text" id="phone" name="phone">
                        </td>
                    </tr>
					<tr>
                        <td  align="center" colspan="2">
                            <input type="button" id="submit" value="입사지원">
                        </td>
                    </tr> 
                </table>
            </form>
        </td>
    </tr>
</table>    
</body>
</html>
