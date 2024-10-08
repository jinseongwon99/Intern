<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>	
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>main</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
	
		   var today = new Date();
		   var yyyy = today.getFullYear();

		    window.setendmin = function(e, input) {
		        const endInput = input.closest('tr').querySelector('.endperiod');
		        if (endInput) {
		            endInput.setAttribute("min", e);
		            validatePeriods(input.closest('tr'));
		            validateBirthdate(); 
		        }
		    };

		    window.setendmax = function(e, input) {
		        const startInput = input.closest('tr').querySelector('.startperiod');
		        if (startInput) {
		            startInput.setAttribute("max", e);
		            validatePeriods(input.closest('tr'));
		            validateBirthdate(); 
		        }
		    };

		    function setInitialMinMax(row) {
		        const startInput = row.querySelector('.startperiod');
		        const endInput = row.querySelector('.endperiod');

		        if (startInput && endInput) {
		            const startValue = startInput.value;    
		            const endValue = endInput.value;

		            if (startValue) {
		                endInput.setAttribute("min", startValue);
		            }
		            if (endValue) {
		                startInput.setAttribute("max", endValue);
		            }
		        }
		    }

		    document.querySelectorAll('#educationTBody tr, #careerTBody tr').forEach(row => {
		        setInitialMinMax(row);
		    });

		    document.addEventListener('input', function(event) {
		        if (event.target.classList.contains('startperiod')) {
		            const endInput = event.target.closest('tr').querySelector('.endperiod');
		            if (endInput) {
		                setendmin(event.target.value, event.target);
		            }
		        }
		        
		        if (event.target.classList.contains('endperiod')) {
		            const startInput = event.target.closest('tr').querySelector('.startperiod');
		            if (startInput) {
		                setendmax(event.target.value, event.target);
		            }
		        }

		        if (event.target.name === 'acqudate') {
		            validateAcqudate(event.target);
		        }
		    });

		    function validatePeriods(row) {
		        const startInput = row.querySelector('.startperiod');
		        const endInput = row.querySelector('.endperiod');

		        if (!startInput || !endInput) return;

		        const startPeriod = startInput.value;
		        const endPeriod = endInput.value;

		        const educationRows = document.querySelectorAll('#educationTBody tr:not(#educationTableRowTemplate)');
		        const careerRows = document.querySelectorAll('#careerTBody tr:not(#careerTableRowTemplate)');

		        let alertShown = false; 

		        const checkOverlap = (otherRow, alertMessage) => {
		            const otherStartInput = otherRow.querySelector('.startperiod');
		            const otherEndInput = otherRow.querySelector('.endperiod');

		            if (otherStartInput && otherEndInput) {
		                const otherStart = otherStartInput.value;
		                const otherEnd = otherEndInput.value;

		                if (startPeriod && endPeriod && otherStart && otherEnd) {
		                    if (startPeriod <= otherEnd && endPeriod >= otherStart) {
		                        if (!alertShown) { 
		                            alert(alertMessage);
		                            alertShown = true; 
		                            startInput.focus();
		                            startInput.value = '';
		                            endInput.value = '';
		                            startInput.setAttribute("max", "");
		                            endInput.setAttribute("min", "");
		                        }
		                    }
		                }
		            }
		        };

		        if (row.closest('#educationTBody')) {
		            educationRows.forEach(eduRow => {
		                if (eduRow !== row) checkOverlap(eduRow, '학력 기간이 겹칩니다. 확인 후 다시 입력해 주세요.');
		            });
		            careerRows.forEach(careerRow => {
		                checkOverlap(careerRow, '학력과 경력이 겹칩니다. 확인 후 다시 입력해 주세요.');
		            });
		        } else if (row.closest('#careerTBody')) {
		            careerRows.forEach(careerRow => {
		                if (careerRow !== row) checkOverlap(careerRow, '경력 기간이 겹칩니다. 확인 후 다시 입력해 주세요.');
		            });
		            educationRows.forEach(eduRow => {
		                checkOverlap(eduRow, '경력과 학력이 겹칩니다. 확인 후 다시 입력해 주세요.');
		            });
		        }
		    }


		    function validateBirthdate() {
		        const birthInput = document.getElementById('birth');
		        const birthDate = new Date(birthInput.value);

		        const checkDates = (rows) => {
		            rows.forEach(row => {
		                const startInput = row.querySelector('.startperiod');
		                const endInput = row.querySelector('.endperiod');

		                if (startInput) {
		                    const startPeriod = startInput.value;
		                    if (startPeriod) {
		                        const startDate = new Date(startPeriod + '-01');	
		                        if (startDate < birthDate) {
		                        	startInput.value = '';
		                            alert('경력 및 학력의 시작일은 생년월일보다 작을 수 없습니다.');
		                            startInput.focus();		                          
			                        endInput.setAttribute("min", "");
		                        }
		                    }
		                }

		                if (endInput) {
		                    const endPeriod = endInput.value;
		                    if (endPeriod) {
		                        const endDate = new Date(endPeriod + '-01');
		                        if (endDate < birthDate) {
		                            endInput.value = '';
		                            alert('경력 및 학력의 종료일은 생년월일보다 작을 수 없습니다.');
		                            endInput.focus();
			                        startInput.setAttribute("max", "");
		                        }
		                    }
		                }
		            });
		        };

		        checkDates(document.querySelectorAll('#educationTBody tr:not(#educationTableRowTemplate)'));
		        checkDates(document.querySelectorAll('#careerTBody tr:not(#careerTableRowTemplate)'));
		    }


		    function validateAcqudate(input) {
		        const birthInput = document.getElementById('birth');
		        const birthDate = new Date(birthInput.value);
		        const acquDateValue = new Date(input.value);
	
		        if (acquDateValue < birthDate) {
		            alert('자격증 취득일은 생년월일보다 작을 수 없습니다.');
		            input.focus();
		            input.value = '';
		        }
		    }

		    document.getElementById('birth').addEventListener('change', validateBirthdate);

		window.add_table = function(type) {
		    const template = document.getElementById(type + 'TableRowTemplate');
		    const newRow = template.cloneNode(true);
		    newRow.style.display = '';	
		    document.getElementById(type + 'TBody').appendChild(newRow);

		    const inputs = newRow.querySelectorAll('input, select');
		    inputs.forEach(input => {
		        input.value = '';
		        input.removeAttribute('id'); 
		    });
		};

	    window.add_educationtable = function() { add_table('education'); };
	    window.add_careertable = function() { add_table('career'); };
	    window.add_certificatetable = function() { add_table('certificate')};
	    
	    function setReadOnlyOrDisabled() {
	        var submitValue = document.querySelector('input[name="submit"]').value;

	        if (submitValue === '제출') {
	            $('input, select, button').prop('readonly', true).prop('disabled', true);
	        }
	    }

	    setReadOnlyOrDisabled();

	    var data = [
	        { "value": "서울", "text": "서울" },
	        { "value": "부산", "text": "부산" },
	        { "value": "인천", "text": "인천" },
	        { "value": "대구", "text": "대구" },
	        { "value": "대전", "text": "대전" },
	        { "value": "광주", "text": "광주" },
	        { "value": "울산", "text": "울산" },
	        { "value": "세종", "text": "세종" },
	        { "value": "경기", "text": "경기" },
	        { "value": "강원", "text": "강원" },
	        { "value": "충북", "text": "충북" },
	        { "value": "충남", "text": "충남" },
	        { "value": "전북", "text": "전북" },
	        { "value": "전남", "text": "전남" },
	        { "value": "경북", "text": "경북" },
	        { "value": "경남", "text": "경남" },
	        { "value": "제주", "text": "제주" }
	    ];

	    function populateSelect(selectElement, selectedValue) {
	        if (selectElement) {
	            selectElement.innerHTML = ''; 

	            data.forEach(function(option) {
	                var optionElement = document.createElement('option');
	                optionElement.value = option.value;
	                optionElement.textContent = option.text;
	                selectElement.appendChild(optionElement);
	            });

	            if (selectedValue === undefined || selectedValue === null || selectedValue === '') {
	                selectedValue = selectElement.options[0].value;
	            }

	            selectElement.value = selectedValue;
	        }
	    }

	    function initializeSelects() {
	        document.querySelectorAll('select[name="schoollocation"]').forEach(function(selectElement) {
	            var selectedValue = selectElement.getAttribute('data-value');    
	            populateSelect(selectElement, selectedValue);
	        });

	        var recruitLocationSelect = document.getElementById('recruitlocation');
	        if (recruitLocationSelect) {
	            var selectedValue = recruitLocationSelect.getAttribute('data-value');
	            populateSelect(recruitLocationSelect, selectedValue);
	        }
	    }

	    initializeSelects();

	    function collectTableData(type) {
	        var tableData = [];
	        document.querySelectorAll('table[id^="' + type + 'Table"]').forEach(function(table) {
	            $(table).find('tbody tr').each(function() {
	                var row = {};
	                if (this.id.includes('Template')) {
	                    return; 
	                }
	                $(this).find('input, select').each(function() {
	                    var name = $(this).attr('name');
	                    if (name) {
	                        row[name] = $(this).val();
	                    }
	                });
	                if (!$.isEmptyObject(row)) {
	                    tableData.push(row);
	                }
	            });
	        });
	        return tableData;
	    }
	    
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
	    function validateFields() {
	        const requiredFields = [
	            { selector: '#seq', name: '순번' },
	            { selector: '#name', name: '이름' },
	            { selector: '#phone', name: '휴대폰 번호' },
	            { selector: '#birth', name: '생년월일' },
	            { selector: '#gender', name: '성별' },
	            { selector: '#email', name: '이메일' },
	            { selector: '#addr', name: '주소' },
	            { selector: '#recruitlocation', name: '희망 근무지' },
	            { selector: '#worktype', name: '근무 형태' }
	        ];


	        for (const field of requiredFields) {
	            if (!$(field.selector).val()) {
	                alert(field.name + "을 입력해주세요.");
	                $(field.selector).focus();
	                return false;
	            }
	        }

	        const educationRows = $('#educationTBody tr:not(#educationTableRowTemplate)');

	        for (let i = 0; i < educationRows.length; i++) {
	            const rowElement = $(educationRows[i]);

	            const fields = [
	                { name: '재학 시작일', field: rowElement.find('.startperiod') },
	                { name: '재학 종료일', field: rowElement.find('.endperiod') },
	                { name: '학교명', field: rowElement.find('.schoolname') },
	                { name: '전공', field: rowElement.find('.major') },
	                { name: '학점', field: rowElement.find('.grade') }
	            ];

	            for (const { name, field } of fields) {
	                if (!field.val()) {
	                    alert(name + '을 입력해주세요.'); 
	                    field.focus();
	                    return false;
	                }
	            }
	        }

	        const careerRows = $('#careerTBody tr:not(#careerTableRowTemplate)');

	        for (let i = 0; i < careerRows.length; i++) {
	            const rowElement = $(careerRows[i]);

	            const fields = [
	                { name: '근무 시작일', field: rowElement.find('.startperiod') },
	                { name: '근무 종료일', field: rowElement.find('.endperiod') },
	                { name: '회사명', field: rowElement.find('input[name="compname"]') },
	                { name: '부서/직급/직책', field: rowElement.find('input[name="task"]') },
	                { name: '지역', field: rowElement.find('input[name="careerlocation"]') }
	            ];


	            const hasAnyInput = fields.some(({ field }) => field.val());

	            if (hasAnyInput) {
	                for (const { name, field } of fields) {
	                    if (!field.val()) {
	                    	alert(name + '을 입력해주세요.');
	                        field.focus();
	                        return false;
	                    }
	                }
	            }
	        }

	        const certificateRows = $('#certificateTBody tr:not(#certificateTableRowTemplate)');

	        for (let i = 0; i < certificateRows.length; i++) {
	            const rowElement = $(certificateRows[i]);

	            const fields = [
	                { name: '자격증명', field: rowElement.find('input[name="qualifiname"]') },
	                { name: '취득일', field: rowElement.find('input[name="acqudate"]') },
	                { name: '발행처', field: rowElement.find('input[name="organizename"]') }
	            ];

	            const hasAnyInput = fields.some(({ field }) => field.val());

	            if (hasAnyInput) {
	                for (const { name, field } of fields) {
	                    if (!field.val()) {
	                        alert(name + '을 입력해주세요.');
	                        field.focus();
	                        return false;
	                    }
	                }
	            }
	        }

	        return true;
	    }

	    function sendData(submitValue) {
	        var data = {
	            recruit: {
	                seq: $('#seq').val(),
	                name: $('#name').val(),
	                phone: $('#phone').val(),
	                birth: $('#birth').val(),
	                gender: $('#gender').val(),
	                email: $('#email').val(),
	                addr: $('#addr').val(),
	                recruitlocation: $('#recruitlocation').val(),
	                worktype: $('#worktype').val(),
	                submit: submitValue
	            },
	            education: collectTableData('education'),
	            career: collectTableData('career'),
	            certificate: collectTableData('certificate')
	        };

	        console.log(submitValue + JSON.stringify(data));

	        $.ajax({
	            url: "/board/resumeAction.do",
	            type: "POST",
	            data: JSON.stringify(data),
	            contentType: "application/json",
	            dataType: "json",
	            success: function(response) {
	                if (response.success === "Y") {
	                    alert(submitValue + ' 했습니다');
	                    location.href = "/board/login.do";
	                }
	            },
	        });
	    }


        $(document).on('input', 'input[name="grade"]', function() {
            var v = $(this).val().replace(/[^0-9.]/g, ''); 
            var parts = v.split('.');
            
            if (parts.length > 2) {
                v = parts[0] + '.' + parts[1].substring(0, 1);
            } else if (parts.length === 2) {
                v = parts[0] + '.' + parts[1].substring(0, 1);
            }

            if (parseFloat(v) > 5.0) {
                v = '5';
            } else if (parseFloat(v) < 0) {
                v = '0';
            }

            $(this).val(v);
        });
        
        $(document).on('input', 'input[name="task"]', function() { 
           
            let v = $(this).val().replace(/[^\u3131-\u3163\uAC00-\uD7A3]/g, '');

            const maxLength = 6; 
            
            if (v.length > maxLength) {
                alert("부서/직급/직책 각각의 항목에 2글자씩 입력해주세요.");
                v = v.slice(0, maxLength); 
            }
       
            $(this).val(v);
        });

        $(document).on('blur', 'input[name="task"]', function() {
            let v = $(this).val();

            if (v.length === 6) {
                let formattedValue = '';
                for (let i = 0; i < v.length; i++) {
                    formattedValue += v[i]; 
                    if ((i + 1) % 2 === 0 && i < v.length - 1) {
                        formattedValue += '/'; 
                    }
                }
                $(this).val(formattedValue); 
            }
        });

        $(document).on('keydown', 'input[name="task"]', function(event) {
            if (event.key === 'Backspace') {
                event.preventDefault();
                const currentValue = $(this).val();

                if (currentValue.endsWith('/')) {
                    $(this).val(currentValue.slice(0, -1)); 
                }
                $(this).val(currentValue.slice(0, -1)); 
            }
        });

        $("#saveButton").on("click", function(event) {
            event.preventDefault();
            if (validateFields() && validateEmail()) {
                sendData("저장");
            }
        });

        $("#submitButton").on("click", function(event) {
            event.preventDefault(); 
            if (validateFields() && validateEmail()) {
                sendData("제출");
            }
        });
        function validateEmail() {
            var email = $("#email").val();
            var regexp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!regexp.test(email) && email !== '') {
                alert("유효한 이메일 주소를 입력하세요 예시: example@domain.com");
                $("#email").focus();
                return false;
            } 	
            return true;
        }
	    window.tableIndexes = {
	        educationIdx: 0,
	        careerIdx: 0,
	        certificateIdx: 0
	    };

	    function add_table(type) {
	        var currentIndex = window.tableIndexes[type + 'Idx'] + 1;
	        var table = document.getElementById(type + 'Table');
	        var templateRow = document.getElementById(type + 'TableRowTemplate');
	        var newRow = templateRow.cloneNode(true);

	        newRow.id = type + 'TableRow' + currentIndex;

	        newRow.style.display = '';

	        newRow.querySelectorAll('input, select').forEach(function(input) {
	            input.value = '';
	            input.checked = false;
	        });

	        newRow.querySelectorAll('select').forEach(function(select) {
	            if (select.options.length > 0) {
	                select.selectedIndex = 0;
	            }
	        });

	        table.querySelector('tbody').appendChild(newRow);
	        window.tableIndexes[type + 'Idx'] = currentIndex;
	    }

	    function del_table(type) {
	        var table = document.getElementById(type + 'Table');
	        var rows = Array.from(table.querySelectorAll('tbody tr')).reverse();
	        var seqList = []; 

	        rows.forEach(function(row) {
	            var checkbox = row.querySelector('input[type="checkbox"]');
	            if (checkbox && checkbox.checked) {
	                var seq = row.querySelector('input[name="' + (type === 'education' ? 'eduseq' : type === 'career' ? 'carseq' : 'certseq') + '"]').value; 
	                if (seq) seqList.push(seq); 
	                row.remove(); 
	            }
	        });

	        if (seqList.length > 0) {
	            fetch('/board/resumeDeleteAction.do', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json',
	                },
	                body: JSON.stringify({ [type + 'seqList']: seqList }),
	            })
	            .then(response => response.json())
	            .then(data => {
	                console.log('성공:', data);
	                checkAndAddRows();
	            })
	            .catch((error) => {
	                console.error('오류:', error);
	            });
	        } else {
	            checkAndAddRows();
	        }
	    }

	    function checkAndAddRows() {
	        function checkAndAddRow(tableId, addButtonId) {
	            var tableBody = document.querySelector('#' + tableId + ' tbody');
	            
	            if (!tableBody) {
	                return; 
	            }            
	            var rows = tableBody.querySelectorAll('tr');
	            if (rows.length === 0 || (rows.length === 1 && rows[0].id.includes('Template'))) {
	                document.getElementById(addButtonId).click();
	            }
	        }
	        checkAndAddRow('educationTable', 'addEducationButton');
	        checkAndAddRow('careerTable', 'addCareerButton');
	        checkAndAddRow('certificateTable', 'addCertificateButton');
	    }

	    $(document).ready(function() {
	        $(document).on('input', '.max-length', function() {
	            var maxLength = $(this).attr('maxlength'); 
	            var input = $(this).val();

	            if (input.length > maxLength) {
	                $(this).val(input.slice(0, maxLength));
	            }
	        });
	    });

	    checkAndAddRows();

	    window.add_educationtable = function() { add_table('education'); }
	    window.del_educationtable = function() { del_table('education'); }
	    window.add_careertable = function() { add_table('career'); }
	    window.del_careertable = function() { del_table('career'); }
	    window.add_certificatetable = function() { add_table('certificate'); }
	    window.del_certificatetable = function() { del_table('certificate'); }

	});
</script>
</head>
<body>
<form class="resume">
    <h2 align="center">입사지원서</h2>
    <table align="center" width="100%" height="100%" border="1">
        <!-- 지원서 기본 정보 -->
        <tr>
            <td>
                <c:choose>
				    <c:when test="${not empty recruitList}">
				        <c:forEach items="${recruitList}" var="recruit" varStatus="status">
				            <table id="recruitTable" border="1" align="center">
				                <tr>
				                    <td width="80px" align="center">이름</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="name" name="name" value="${recruit.name}">
				                    </td>
				                    <td width="80px" align="center">생년월일
				                        <input type="hidden" name="seq" id="seq" value="${recruit.seq}">
				                        <input type="hidden" name="submit" id="submit" value="${recruit.submit}">
				                    </td>
				                    <td width="80px" align="left">
				                        <input type="date" id="birth" name="birth" value="${recruit.birth}">
				                    </td>
				                </tr>
				                <tr>
				                    <td width="80px" align="center">성별</td>
				                    <td width="80px" align="left">
				                        <select id="gender" name="gender">
				                            <option value="남자" ${recruit.gender == '남자' ? 'selected' : ''}>남자</option>
				                            <option value="여자" ${recruit.gender == '여자' ? 'selected' : ''}>여자</option>
				                        </select>
				                    </td>
				                    <td width="80px" align="center">연락처</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="phone" name="phone" value="${recruit.phone}">
				                    </td>
				                </tr>
				                <tr>
				                    <td width="80px" align="center">email</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="email" name="email" value="${recruit.email}" maxlength="50">
				                    </td>
				                    <td width="80px" align="center">주소</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="addr" name="addr" value="${recruit.addr}" maxlength="10">
				                    </td>
				                </tr>
				                <tr>
				                    <td width="80px" align="center">희망근무지</td>
				                    <td width="80px" align="left">
				                        <select id="recruitlocation" name="recruitlocation" data-value="${recruit.recruitlocation}"></select>
				                    </td>
				                    <td width="80px" align="center">근무형태</td>
				                    <td width="80px" align="left">
				                        <select id="worktype" name="worktype">
				                            <option value="계약직" ${recruit.worktype == '계약직' ? 'selected' : ''}>계약직</option>
				                            <option value="정규직" ${recruit.worktype == '정규직' ? 'selected' : ''}>정규직</option>
				                        </select>               
				                    </td>
				                </tr>
				            </table>
				        </c:forEach>
				    </c:when>
				    <c:otherwise>
				        <table id="recruitTable" border="1" align="center">
				            <tr>
				                <td width="80px" align="center">이름</td>
				                <td width="80px" align="left">
				                    <input type="text" id="name" name="name" value="${sessionScope.name}">
				                </td>
				                <td width="80px" align="center">생년월일
				                    <input type="hidden" name="seq" id="seq" value="${sessionScope.seq	}">
				                    <input type="hidden" name="submit" id="submit" >
				                </td>
				                <td width="80px" align="left">
				                    <input type="date" id="birth" name="birth" >
				                </td>
				            </tr>
				            <tr>
				                <td width="80px" align="center">성별</td>
				                <td width="80px" align="left">
				                    <select id="gender" name="gender">
				                        <option value="남자">남자</option>
				                        <option value="여자">여자</option>
				                    </select>
				                </td>
				                <td width="80px" align="center">연락처</td>
				                <td width="80px" align="left">
				                    <input type="text" id="phone" name="phone" value="${sessionScope.phone}">
				                </td>
				            </tr>
				            <tr>
				                <td width="80px" align="center">email</td>
				                <td width="80px" align="left">
				                    <input type="text" id="email" name="email" maxlength="50">
				                </td>	
				                <td width="80px" align="center">주소</td>
				                <td width="80px" align="left">
				                    <input type="text" id="addr" name="addr" maxlength="10">
				                </td>
				            </tr>
				            <tr>
				                <td width="80px" align="center">희망근무지</td>
				                <td width="80px" align="left">
				                    <select id="recruitlocation" name="recruitlocation"></select>
				                </td>
				                <td width="80px" align="center">근무형태</td>
				                <td width="80px" align="left">
				                    <select id="worktype" name="worktype">
				                        <option value="계약직">계약직</option>
				                        <option value="정규직">정규직</option>
				                    </select>               
				                </td>
				            </tr>
				        </table>
				    </c:otherwise>
				</c:choose>
				<c:if test="${recruitList ne null}">
				<c:forEach items="${recruitList}" var="recruit" varStatus="status">
				<table id="=checkTable"  align="center" width="80%" border="1">
					    <thead>
					        <tr>
					            <td width="18%" align="center">학력사항</td>
					            <td width="18%" align="center">경력사항</td>
					            <td width="18%" align="center">희망연봉</td>
					            <td width="18%" align="center">희망근무지/근무형태</td>
					        </tr>
					    </thead>
					    <tbody id="checkTBody">
					      <tr id="checkTableRow">          
				                <td width="80px" align="left">
								     학력: ${!empty sessionScope.totalEducationDuration ? sessionScope.totalEducationDuration : '학력 없음'}
								</td>
					            <td width="80px" align="left">
								     경력: ${!empty sessionScope.totalCareerDuration ? sessionScope.totalCareerDuration : '경력 없음'}
								</td>
					            <td width="80px" align="left">	
					            회사 내규에 따름
					            </td>
					            <td width="80px" align="left">
					            ${recruit.recruitlocation}전체<br>
					            ${recruit.worktype}
					            </td>
					      </tr>
					    </tbody>
			    </table>
			    </c:forEach>
			    </c:if>
			    <!-- 학력 정보 -->
                <h2 align="left">학력</h2>
				<div style="text-align: right; margin-bottom: 10px;">
				    <input type="button" id="addEducationButton" onclick="add_educationtable()" value="추가">
				    <input type="button" onclick="del_educationtable()" value="삭제">
				</div>
				<table id="educationTable" border="1" align="center" width="80%">
				    <thead>
				        <tr>
				            <td width="1.5%" align="center"></td>
				            <td width="18%" align="center">재학기간</td>
				            <td width="3.5%" align="center">구분</td>
				            <td width="18%" align="center">학교명(소재지)</td>
				            <td width="18%" align="center">전공</td>
				            <td width="18%" align="center">학점</td>
				        </tr>
				    </thead>
				    <tbody id="educationTBody">
				        <c:forEach items="${educationList}" var="education" varStatus="status">
				            <tr>
				                <td width="80px" align="center">
				                    <input type="checkbox" class="education-checkbox">
				                </td>
				                <td width="80px" align="left">
				                    <input type="month" class="startperiod" name="startperiod" value="${education.startperiod}" style="width: 93%;"  onChange="setendmin(this.value, this)">
				                    ~
				                    <input type="month" class="endperiod" name="endperiod" value="${education.endperiod}" style="width: 93%;" onChange="setendmax(this.value, this)">
				                </td>
				                <td align="center">
				                    <select class="division" name="division">
				                        <option value="재학" ${education.division == '재학' ? 'selected' : ''}>재학</option>	
				                        <option value="중퇴" ${education.division == '중퇴' ? 'selected' : ''}>중퇴</option>
				                        <option value="졸업" ${education.division == '졸업' ? 'selected' : ''}>졸업</option>
				                    </select>
				                </td>
				                <td width="80px" align="left">
				                    <input type="text" class="schoolname" name="schoolname" value="${education.schoolname}" style="width: 97.5%;" maxlength="10">
				                    <select class="schoollocation" name="schoollocation" data-value="${education.schoollocation}"></select>
				                </td>
				                <td width="80px" align="center">
				                    <input type="text" class="major" name="major" value="${education.major}" style="width: 93%;" maxlength="10">
				                </td>
				                <td width="80px" align="center">
				                    <input type="text" class="grade" name="grade" value="${education.grade}" style="width: 93%;">
				                    <input type="hidden" name="eduseq" class="eduseq" value="${education.eduseq}">
				                </td>
				            </tr>
				        </c:forEach>				
				        <!-- Template -->
				        <tr id="educationTableRowTemplate" style="display: none;">
				            <td width="80px" align="center">
				                <input type="checkbox" class="education-checkbox">
				            </td>
				            <td width="80px" align="left">
				                <input type="month" class="startperiod" name="startperiod" style="width: 93%;"  onChange="setendmin(this.value, this)">
				                ~
				                <input type="month" class="endperiod" name="endperiod" style="width: 93%;" onChange="setendmax(this.value, this)">
				            </td>
				            <td align="center">
				                <select class="division" name="division">
				                    <option value="재학">재학</option>
				                    <option value="중퇴">중퇴</option>
				                    <option value="졸업">졸업</option>
				                </select>
				            </td>
				            <td width="80px" align="left">
				                <input type="text" class="schoolname" name="schoolname" style="width: 97.5%;" maxlength="10">
				                <select class="schoollocation" name="schoollocation"></select>
				            </td>
				            <td width="80px" align="center">
				                <input type="text" class="major" name="major" style="width: 93%;" maxlength="10">
				            </td>
				            <td width="80px" align="center">
				                <input type="text" class="grade" name="grade" style="width: 93%;">
				                <input type="hidden" name="eduseq" class="eduseq">
				            </td>
				        </tr>
				    </tbody>
				</table>
                <!-- 경력 정보 -->
 				<c:set var="isSubmit" value="false" />	
					<c:choose>
					    <c:when test="${not empty recruitList}">
					        <c:forEach items="${recruitList}" var="recruit">
					            <c:if test="${recruit.submit == '제출'}">
					                <c:set var="isSubmit" value="true" />
					            </c:if>
					        </c:forEach>
					    </c:when>
					</c:choose>						
					<c:if test="${isSubmit == 'false' or not empty careerList}">
					    <h2 align="left">경력</h2>
					    <div style="text-align: right; margin-bottom: 10px;">
					        <input type="button" id="addCareerButton" onclick="add_careertable()" value="추가">
					        <input type="button" onclick="del_careertable()" value="삭제">
					    </div>
					    <table id="careerTable" border="1" align="center" width="80%">
					        <thead>
					            <tr>
					                <td width="1.5%" align="center"></td>
					                <td width="21.5%" align="center">근무기간</td>
					                <td width="18%" align="center">회사명</td>
					                <td width="18%" align="center">부서/직급/직책</td>
					                <td width="18%" align="center">지역</td>
					            </tr>
					        </thead>
					        <tbody id="careerTBody">
					            <c:forEach items="${careerList}" var="career">
					                <tr>
					                    <td align="center"><input type="checkbox" class="career-checkbox"></td>
					                    <td align="left">
					                        <input type="month" class="startperiod" name="startperiod" value="${career.startperiod}" style="width: 80%;" onChange="setendmin(this.value, this)">
					                        ~
					                        <input type="month" class="endperiod" name="endperiod" value="${career.endperiod}" style="width: 80%;" onChange="setendmax(this.value, this)">
					                    </td>
					                    <td align="left"><input type="text" name="compname" value="${career.compname}" style="width: 97.5%;" maxlength="10"></td>
					                    <td align="center"><input type="text" id="task" name="task" value="${career.task}" style="width: 93%;" maxlength="10"></td>
					                    <td align="center">
					                        <input type="text" name="careerlocation" value="${career.careerlocation}" style="width: 93%;" maxlength="10">
					                        <input type="hidden" name="carseq" value="${career.carseq}">
					                    </td>
					                </tr>
					            </c:forEach>
					
					            <!-- Hidden Template Row -->
					            <tr id="careerTableRowTemplate" style="display: none;">
					                <td align="center"><input type="checkbox" class="career-checkbox"></td>
					                <td align="left">
					                    <input type="month" class="startperiod" name="startperiod" style="width: 80%;" onChange="setendmin(this.value, this)">
					                    ~
					                    <input type="month" class="endperiod" name="endperiod" style="width: 80%;" onChange="setendmax(this.value, this)">
					                </td>
					                <td align="left"><input type="text" name="compname" style="width: 97.5%;" maxlength="10"></td>
					               <td align="center">
									    <input type="text" name="task" style="width: 93%;" maxlength="10" id="task">
									</td>
					                <td align="center">
					                    <input type="text" name="careerlocation" style="width: 93%;" maxlength="10">
					                    <input type="hidden" name="carseq">
					                </td>
					            </tr>
					        </tbody>
					    </table>
					</c:if>
				<c:set var="isSubmit" value="false" />
					<c:choose>
					    <c:when test="${not empty recruitList}">
					        <c:forEach items="${recruitList}" var="recruit">
					            <c:if test="${recruit.submit == '제출'}">
					                <c:set var="isSubmit" value="true" />
					            </c:if>
					        </c:forEach>
					    </c:when>
					</c:choose>							
					<c:if test="${isSubmit == 'false' or not empty certificateList}">
                <!-- 자격증 정보 -->
                <h2 align="left">자격증</h2>
					<div style="text-align: right; margin-bottom: 10px;">
					    <input type="button" id="addCertificateButton" onclick="add_certificatetable()" value="추가">
					    <input type="button" onclick="del_certificatetable()" value="삭제">
					</div>
					<table id="certificateTable" border="1" align="center" width="80%">
					    <thead>
					        <tr>
					            <td width="1.5%" align="center"></td>
					            <td width="26%" align="center">자격증명</td>
					            <td width="26%" align="center">취득일</td>
					            <td width="26%" align="center">발행처</td>
					        </tr>
					    </thead>
					    <tbody id="certificateTBody">
					        <c:forEach items="${certificateList}" var="certificate" varStatus="status">
					            <tr id="certificateTableRow">
					                <td width="80px" align="center">
					                    <input type="checkbox" class="certificate-checkbox">
					                </td>
					                <td width="80px" align="left">
					                    <input type="text" class="qualifiname" name="qualifiname" value="${certificate.qualifiname}" style="width: 80%;" maxlength="10">
					                </td>
					                <td width="80px" align="left">
					                    <input type="month" class="acqudate" name="acqudate" value="${certificate.acqudate}" style="width: 80%;" >
					                </td>
					                <td width="80px" align="left">
					                    <input type="text" class="organizename" name="organizename" value="${certificate.organizename}" style="width: 80%;" maxlength="10">
					                    <input type="hidden" name="certseq" id="certseq" value="${certificate.certseq}">
					                </td>
					            </tr>
					        </c:forEach>
                        <!-- Hidden Template Row -->
                        <tr id="certificateTableRowTemplate" style="display: none;">
                            <td width="80px" align="center">
                                <input type="checkbox" class="certificate-checkbox">
                            </td>
                            <td width="80px" align="left">
                                <input type="text" class="qualifiname" name="qualifiname" style="width: 80%;" maxlength="10">
                            </td>
                            <td width="80px" align="left">
                                <input type="month" class="acqudate" name="acqudate" style="width: 80%;">
                            </td>
                            <td width="80px" align="left">
                                <input type="text" class="organizename" name="organizename" style="width: 80%;"maxlength="10">
                                <input type="hidden" id="certseq" name="certseq" >
                            </td>
                        </tr>
                    </tbody>
                </table>
                </c:if>
            </td>
        </tr>
    </table>
    <div align="center">
        <input type="button" id="saveButton" value="저장">
        <input type="button" id="submitButton" value="제출"> 
    </div>
</form>
</body>
</html>
