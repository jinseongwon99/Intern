<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    var idCheckStatus = null;

    $('#userId').keyup(function(event) {

        if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
            var regexp = /[\u3130-\u318F\uAC00-\uD7AF]/g;
            var v = $(this).val();
            if (regexp.test(v)) {
                $(this).val(v.replace(regexp, ''));
            }
        }

  
        idCheckStatus = null;
    });
    $('#idcheck').on('click', function() {
        var userId = $('#userId').val();
        if (!userId) {  
            alert("���̵� �Է����ּ���.");
            $('#userId').focus(); 
            return;  
        }

        $.ajax({
            url: "/board/idCheckAction.do",
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({ userId: userId }), 
            success: function(data) {
                idCheckStatus = data.success === 'Y' ? 1 : 2; 
                alert(idCheckStatus === 1 ? "���̵� �ߺ��˴ϴ�." : "��� ������ ���̵��Դϴ�.");
                if(idCheckStatus === 1){
                    $('#userId').focus();
                }
            },       
        });
    });

    $('#submit').on('click', function(event) {
        event.preventDefault(); 

        if (idCheckStatus === null) {
            alert("�ߺ� Ȯ���� ���� ������ �ּ���.");
            $('#userId').focus();
            return;
        }

        if (idCheckStatus === 1) {
            alert("���̵� �ߺ��˴ϴ�.");
            $('#userId').focus();
            return;
        }

        var pw = $('#userPw').val();
        var pwCheck = $('#user_pw_check').val();
        var phone1 = $('#userPhone1').val();
        var phone2 = $('#userPhone2').val();
        var phone3 = $('#userPhone3').val();
        var phone = phone1 + '-' + phone2 + '-' + phone3;
        var addr1 = $('#userAddr1').val();
        var name = $('#userName').val();
        
        var isValid = true;
        var errorMessage = '';

        if (!pw) {
            errorMessage = '��й�ȣ�� �Է��� �ֽʽÿ�.';
            $('#userPw').focus(); 
        } else if (!/^.{6,12}$/.test(pw)) {
            errorMessage = '��й�ȣ�� 6�ڸ� �̻� 12�ڸ� ���Ϸ� �Է��ؾ� �մϴ�.';
            $('#userPw').focus(); 
        } else if (pw !== pwCheck) {
            errorMessage = '��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.';
            $('#user_pw_check').focus(); 
        } else if (!name) {
            errorMessage = '�̸��� �Է����ּ���.';
            $('#userName').focus(); 
        } else if (!/^\d{1}-\d{4}-\d{4}$/.test(phone)) {

          	 if (phone2.length !== 4) {
          		phoneErrorMessage = '��ȭ��ȣ�� XXX-XXXX-XXXX �������� �Է��ؾ� �մϴ�.';
                $('#userPhone2').focus();
            } else if (phone3.length !== 4) {
                phoneErrorMessage = '��ȭ��ȣ�� XXX-XXXX-XXXX �������� �Է��ؾ� �մϴ�.';
                $('#userPhone3').focus();
            }

            if (phoneErrorMessage) {
                alert(phoneErrorMessage);
                isValid = false;
            }
        } else if (addr1 && !/^\d{3}-\d{3}$/.test(addr1)) {
            errorMessage = '�����ȣ�� XXX-XXX �������� �Է��ؾ� �մϴ�.';
            $('#userAddr1').focus(); 
        }

        if (errorMessage) {
            alert(errorMessage);
            isValid = false;
        }

        if (isValid) {
            var param = $('.joinPage').serialize(); 
            $.ajax({
                url: "/board/joinAction.do",
                dataType: "json", 
                type: "POST", 
                data: param, 
                success: function(data) {
                    alert("���ԿϷ�");
                    location.href = "/board/boardList.do"; 
                },
                error: function() {
                    alert("���� ����"); 
                }
            });
        }
    });

    $('#userAddr1').on('input', function() {
        var input = $(this).val().replace(/[^0-9]/g, ''); 
        if (input.length > 6) input = input.slice(0, 6);
        $(this).val(input.length > 3 ? input.slice(0, 3) + '-' + input.slice(3) : input);
    });

    $("#userName").keyup(function(event) {
        var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:"'\\]/g;
        var v = $(this).val();

        v = v.replace(regexp, '');

        if (v.length > 5) {
            v = v.substring(0, 5);
        }

        $(this).val(v);
    });

});

function ChkByte(obj, maxByte) {
    const str = obj.value;
    let rbyte = 0;
    let rlen = 0;

    for (let i = 0; i < str.length; i++) {
        const one_char = str.charAt(i);
        rbyte += (escape(one_char).length > 4) ? 3 : 1;

        if (rbyte <= maxByte) {
            rlen = i + 1;
        } else {
            break;
        }
    }

    if (rbyte > maxByte) {
        obj.value = str.substring(0, rlen);
        fnChkByte(obj, maxByte);
    }

    document.getElementById('byteInfo').innerText = rbyte;
}


function ChkAddr2(obj) {
	ChkByte(obj, 150);
}

function ChkCompany(obj) {
	ChkByte(obj, 60);
}

</script>
</head>
<body>
<form class="joinPage" action="/board/joinAction.do" method="post">
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
                <table id="boardTable" border="1">
                    <tr>
                        <td width="130" align="center">
                            id    
                        </td>
                        <td width="250" align="left">
                            <input id="userId" name="userId" type="text" maxlength="15"></input>
                            <input id="idcheck" type="button" value="�ߺ�Ȯ��">
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">
                            pw
                        </td>
                        <td width="250" align="left">
                            <input id="userPw" name="userPw" type="password" maxlength='12'></input>
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">
                            pw check
                        </td>
                        <td width="250" align="left">
                            <input id="user_pw_check" name="user_pw_check" type="password" maxlength='12'></input>
                        </td>
                    </tr>    
                    <tr>
                        <td width="130" align="center">
                            name
                        </td>
                        <td width="250" align="left">
                            <input id="userName" name="userName" type="text"></input>
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">
                            phone
                        </td>
                        <td width="250" align="left">
                            <select id="userPhone1" name="userPhone1">
							    <c:forEach var="phone" items="${phoneList}">
							        <option value="${phone.codeId}">${phone.codeName}</option>
							    </c:forEach>
							</select> -
							<input id="userPhone2" name="userPhone2" type="text" maxlength="4" style="width: 28px;"> -
							<input id="userPhone3" name="userPhone3" type="text" maxlength="4" style="width: 28px;">
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">	
                            postNo
                        </td>	
                        <td width="250" align="left">
                            <input id="userAddr1" name="userAddr1" type="text"></input>
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">
                            address
                        </td>
                        <td width="250" align="left">
                            <input id="userAddr2" name="userAddr2" type="text" onkeyup="ChkAddr2(this);"></input>
                        </td>
                    </tr>
                    <tr>
                        <td width="130" align="center">
                            company
                        </td>
                        <td width="250" align="left">
                            <input id="userCompany" name="userCompany" type="text" onkeyup="ChkCompany(this);"></input>
                        </td>
                    </tr>            
                </table>
            </td>
        </tr>
        <tr>
            <td align="right">
                <input type="button" id="submit" value="����">
            </td>
        </tr>
    </table>
</form>
</body>
</html>

