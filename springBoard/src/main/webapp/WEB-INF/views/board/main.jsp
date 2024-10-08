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
		                if (eduRow !== row) checkOverlap(eduRow, '�з� �Ⱓ�� ��Ĩ�ϴ�. Ȯ�� �� �ٽ� �Է��� �ּ���.');
		            });
		            careerRows.forEach(careerRow => {
		                checkOverlap(careerRow, '�з°� ����� ��Ĩ�ϴ�. Ȯ�� �� �ٽ� �Է��� �ּ���.');
		            });
		        } else if (row.closest('#careerTBody')) {
		            careerRows.forEach(careerRow => {
		                if (careerRow !== row) checkOverlap(careerRow, '��� �Ⱓ�� ��Ĩ�ϴ�. Ȯ�� �� �ٽ� �Է��� �ּ���.');
		            });
		            educationRows.forEach(eduRow => {
		                checkOverlap(eduRow, '��°� �з��� ��Ĩ�ϴ�. Ȯ�� �� �ٽ� �Է��� �ּ���.');
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
		                            alert('��� �� �з��� �������� ������Ϻ��� ���� �� �����ϴ�.');
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
		                            alert('��� �� �з��� �������� ������Ϻ��� ���� �� �����ϴ�.');
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
		            alert('�ڰ��� ������� ������Ϻ��� ���� �� �����ϴ�.');
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

	        if (submitValue === '����') {
	            $('input, select, button').prop('readonly', true).prop('disabled', true);
	        }
	    }

	    setReadOnlyOrDisabled();

	    var data = [
	        { "value": "����", "text": "����" },
	        { "value": "�λ�", "text": "�λ�" },
	        { "value": "��õ", "text": "��õ" },
	        { "value": "�뱸", "text": "�뱸" },
	        { "value": "����", "text": "����" },
	        { "value": "����", "text": "����" },
	        { "value": "���", "text": "���" },
	        { "value": "����", "text": "����" },
	        { "value": "���", "text": "���" },
	        { "value": "����", "text": "����" },
	        { "value": "���", "text": "���" },
	        { "value": "�泲", "text": "�泲" },
	        { "value": "����", "text": "����" },
	        { "value": "����", "text": "����" },
	        { "value": "���", "text": "���" },
	        { "value": "�泲", "text": "�泲" },
	        { "value": "����", "text": "����" }
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
	            { selector: '#seq', name: '����' },
	            { selector: '#name', name: '�̸�' },
	            { selector: '#phone', name: '�޴��� ��ȣ' },
	            { selector: '#birth', name: '�������' },
	            { selector: '#gender', name: '����' },
	            { selector: '#email', name: '�̸���' },
	            { selector: '#addr', name: '�ּ�' },
	            { selector: '#recruitlocation', name: '��� �ٹ���' },
	            { selector: '#worktype', name: '�ٹ� ����' }
	        ];


	        for (const field of requiredFields) {
	            if (!$(field.selector).val()) {
	                alert(field.name + "�� �Է����ּ���.");
	                $(field.selector).focus();
	                return false;
	            }
	        }

	        const educationRows = $('#educationTBody tr:not(#educationTableRowTemplate)');

	        for (let i = 0; i < educationRows.length; i++) {
	            const rowElement = $(educationRows[i]);

	            const fields = [
	                { name: '���� ������', field: rowElement.find('.startperiod') },
	                { name: '���� ������', field: rowElement.find('.endperiod') },
	                { name: '�б���', field: rowElement.find('.schoolname') },
	                { name: '����', field: rowElement.find('.major') },
	                { name: '����', field: rowElement.find('.grade') }
	            ];

	            for (const { name, field } of fields) {
	                if (!field.val()) {
	                    alert(name + '�� �Է����ּ���.'); 
	                    field.focus();
	                    return false;
	                }
	            }
	        }

	        const careerRows = $('#careerTBody tr:not(#careerTableRowTemplate)');

	        for (let i = 0; i < careerRows.length; i++) {
	            const rowElement = $(careerRows[i]);

	            const fields = [
	                { name: '�ٹ� ������', field: rowElement.find('.startperiod') },
	                { name: '�ٹ� ������', field: rowElement.find('.endperiod') },
	                { name: 'ȸ���', field: rowElement.find('input[name="compname"]') },
	                { name: '�μ�/����/��å', field: rowElement.find('input[name="task"]') },
	                { name: '����', field: rowElement.find('input[name="careerlocation"]') }
	            ];


	            const hasAnyInput = fields.some(({ field }) => field.val());

	            if (hasAnyInput) {
	                for (const { name, field } of fields) {
	                    if (!field.val()) {
	                    	alert(name + '�� �Է����ּ���.');
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
	                { name: '�ڰ�����', field: rowElement.find('input[name="qualifiname"]') },
	                { name: '�����', field: rowElement.find('input[name="acqudate"]') },
	                { name: '����ó', field: rowElement.find('input[name="organizename"]') }
	            ];

	            const hasAnyInput = fields.some(({ field }) => field.val());

	            if (hasAnyInput) {
	                for (const { name, field } of fields) {
	                    if (!field.val()) {
	                        alert(name + '�� �Է����ּ���.');
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
	                    alert(submitValue + ' �߽��ϴ�');
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
                alert("�μ�/����/��å ������ �׸� 2���ھ� �Է����ּ���.");
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
                sendData("����");
            }
        });

        $("#submitButton").on("click", function(event) {
            event.preventDefault(); 
            if (validateFields() && validateEmail()) {
                sendData("����");
            }
        });
        function validateEmail() {
            var email = $("#email").val();
            var regexp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!regexp.test(email) && email !== '') {
                alert("��ȿ�� �̸��� �ּҸ� �Է��ϼ��� ����: example@domain.com");
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
	                console.log('����:', data);
	                checkAndAddRows();
	            })
	            .catch((error) => {
	                console.error('����:', error);
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
    <h2 align="center">�Ի�������</h2>
    <table align="center" width="100%" height="100%" border="1">
        <!-- ������ �⺻ ���� -->
        <tr>
            <td>
                <c:choose>
				    <c:when test="${not empty recruitList}">
				        <c:forEach items="${recruitList}" var="recruit" varStatus="status">
				            <table id="recruitTable" border="1" align="center">
				                <tr>
				                    <td width="80px" align="center">�̸�</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="name" name="name" value="${recruit.name}">
				                    </td>
				                    <td width="80px" align="center">�������
				                        <input type="hidden" name="seq" id="seq" value="${recruit.seq}">
				                        <input type="hidden" name="submit" id="submit" value="${recruit.submit}">
				                    </td>
				                    <td width="80px" align="left">
				                        <input type="date" id="birth" name="birth" value="${recruit.birth}">
				                    </td>
				                </tr>
				                <tr>
				                    <td width="80px" align="center">����</td>
				                    <td width="80px" align="left">
				                        <select id="gender" name="gender">
				                            <option value="����" ${recruit.gender == '����' ? 'selected' : ''}>����</option>
				                            <option value="����" ${recruit.gender == '����' ? 'selected' : ''}>����</option>
				                        </select>
				                    </td>
				                    <td width="80px" align="center">����ó</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="phone" name="phone" value="${recruit.phone}">
				                    </td>
				                </tr>
				                <tr>
				                    <td width="80px" align="center">email</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="email" name="email" value="${recruit.email}" maxlength="50">
				                    </td>
				                    <td width="80px" align="center">�ּ�</td>
				                    <td width="80px" align="left">
				                        <input type="text" id="addr" name="addr" value="${recruit.addr}" maxlength="10">
				                    </td>
				                </tr>
				                <tr>
				                    <td width="80px" align="center">����ٹ���</td>
				                    <td width="80px" align="left">
				                        <select id="recruitlocation" name="recruitlocation" data-value="${recruit.recruitlocation}"></select>
				                    </td>
				                    <td width="80px" align="center">�ٹ�����</td>
				                    <td width="80px" align="left">
				                        <select id="worktype" name="worktype">
				                            <option value="�����" ${recruit.worktype == '�����' ? 'selected' : ''}>�����</option>
				                            <option value="������" ${recruit.worktype == '������' ? 'selected' : ''}>������</option>
				                        </select>               
				                    </td>
				                </tr>
				            </table>
				        </c:forEach>
				    </c:when>
				    <c:otherwise>
				        <table id="recruitTable" border="1" align="center">
				            <tr>
				                <td width="80px" align="center">�̸�</td>
				                <td width="80px" align="left">
				                    <input type="text" id="name" name="name" value="${sessionScope.name}">
				                </td>
				                <td width="80px" align="center">�������
				                    <input type="hidden" name="seq" id="seq" value="${sessionScope.seq	}">
				                    <input type="hidden" name="submit" id="submit" >
				                </td>
				                <td width="80px" align="left">
				                    <input type="date" id="birth" name="birth" >
				                </td>
				            </tr>
				            <tr>
				                <td width="80px" align="center">����</td>
				                <td width="80px" align="left">
				                    <select id="gender" name="gender">
				                        <option value="����">����</option>
				                        <option value="����">����</option>
				                    </select>
				                </td>
				                <td width="80px" align="center">����ó</td>
				                <td width="80px" align="left">
				                    <input type="text" id="phone" name="phone" value="${sessionScope.phone}">
				                </td>
				            </tr>
				            <tr>
				                <td width="80px" align="center">email</td>
				                <td width="80px" align="left">
				                    <input type="text" id="email" name="email" maxlength="50">
				                </td>	
				                <td width="80px" align="center">�ּ�</td>
				                <td width="80px" align="left">
				                    <input type="text" id="addr" name="addr" maxlength="10">
				                </td>
				            </tr>
				            <tr>
				                <td width="80px" align="center">����ٹ���</td>
				                <td width="80px" align="left">
				                    <select id="recruitlocation" name="recruitlocation"></select>
				                </td>
				                <td width="80px" align="center">�ٹ�����</td>
				                <td width="80px" align="left">
				                    <select id="worktype" name="worktype">
				                        <option value="�����">�����</option>
				                        <option value="������">������</option>
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
					            <td width="18%" align="center">�з»���</td>
					            <td width="18%" align="center">��»���</td>
					            <td width="18%" align="center">�������</td>
					            <td width="18%" align="center">����ٹ���/�ٹ�����</td>
					        </tr>
					    </thead>
					    <tbody id="checkTBody">
					      <tr id="checkTableRow">          
				                <td width="80px" align="left">
								     �з�: ${!empty sessionScope.totalEducationDuration ? sessionScope.totalEducationDuration : '�з� ����'}
								</td>
					            <td width="80px" align="left">
								     ���: ${!empty sessionScope.totalCareerDuration ? sessionScope.totalCareerDuration : '��� ����'}
								</td>
					            <td width="80px" align="left">	
					            ȸ�� ���Կ� ����
					            </td>
					            <td width="80px" align="left">
					            ${recruit.recruitlocation}��ü<br>
					            ${recruit.worktype}
					            </td>
					      </tr>
					    </tbody>
			    </table>
			    </c:forEach>
			    </c:if>
			    <!-- �з� ���� -->
                <h2 align="left">�з�</h2>
				<div style="text-align: right; margin-bottom: 10px;">
				    <input type="button" id="addEducationButton" onclick="add_educationtable()" value="�߰�">
				    <input type="button" onclick="del_educationtable()" value="����">
				</div>
				<table id="educationTable" border="1" align="center" width="80%">
				    <thead>
				        <tr>
				            <td width="1.5%" align="center"></td>
				            <td width="18%" align="center">���бⰣ</td>
				            <td width="3.5%" align="center">����</td>
				            <td width="18%" align="center">�б���(������)</td>
				            <td width="18%" align="center">����</td>
				            <td width="18%" align="center">����</td>
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
				                        <option value="����" ${education.division == '����' ? 'selected' : ''}>����</option>	
				                        <option value="����" ${education.division == '����' ? 'selected' : ''}>����</option>
				                        <option value="����" ${education.division == '����' ? 'selected' : ''}>����</option>
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
				                    <option value="����">����</option>
				                    <option value="����">����</option>
				                    <option value="����">����</option>
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
                <!-- ��� ���� -->
 				<c:set var="isSubmit" value="false" />	
					<c:choose>
					    <c:when test="${not empty recruitList}">
					        <c:forEach items="${recruitList}" var="recruit">
					            <c:if test="${recruit.submit == '����'}">
					                <c:set var="isSubmit" value="true" />
					            </c:if>
					        </c:forEach>
					    </c:when>
					</c:choose>						
					<c:if test="${isSubmit == 'false' or not empty careerList}">
					    <h2 align="left">���</h2>
					    <div style="text-align: right; margin-bottom: 10px;">
					        <input type="button" id="addCareerButton" onclick="add_careertable()" value="�߰�">
					        <input type="button" onclick="del_careertable()" value="����">
					    </div>
					    <table id="careerTable" border="1" align="center" width="80%">
					        <thead>
					            <tr>
					                <td width="1.5%" align="center"></td>
					                <td width="21.5%" align="center">�ٹ��Ⱓ</td>
					                <td width="18%" align="center">ȸ���</td>
					                <td width="18%" align="center">�μ�/����/��å</td>
					                <td width="18%" align="center">����</td>
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
					            <c:if test="${recruit.submit == '����'}">
					                <c:set var="isSubmit" value="true" />
					            </c:if>
					        </c:forEach>
					    </c:when>
					</c:choose>							
					<c:if test="${isSubmit == 'false' or not empty certificateList}">
                <!-- �ڰ��� ���� -->
                <h2 align="left">�ڰ���</h2>
					<div style="text-align: right; margin-bottom: 10px;">
					    <input type="button" id="addCertificateButton" onclick="add_certificatetable()" value="�߰�">
					    <input type="button" onclick="del_certificatetable()" value="����">
					</div>
					<table id="certificateTable" border="1" align="center" width="80%">
					    <thead>
					        <tr>
					            <td width="1.5%" align="center"></td>
					            <td width="26%" align="center">�ڰ�����</td>
					            <td width="26%" align="center">�����</td>
					            <td width="26%" align="center">����ó</td>
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
        <input type="button" id="saveButton" value="����">
        <input type="button" id="submitButton" value="����"> 
    </div>
</form>
</body>
</html>
