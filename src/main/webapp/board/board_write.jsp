<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판 글쓰기</title>
	<script type="text/javascript" src="../ckeditor/ckeditor.js" ></script>
	<link rel="Stylesheet" href="../style/default.css" />
	<style type="text/css">
		.write-wrap {
			max-width: 860px;
			margin: 34px auto 48px;
			padding: 0 24px;
		}

		.write-title {
			margin-bottom: 18px;
			border-bottom: 2px solid #5e73bb;
			padding-bottom: 12px;
			text-align: left;
		}

		.write-title h2 {
			margin: 0;
			color: #26345f;
			font-size: 22px;
			font-weight: bold;
		}

		.write-title p {
			margin: 6px 0 0;
			color: #777;
			font-size: 12px;
		}

		.write-form {
			border: 1px solid #d8dfef;
			background: #fff;
			padding: 24px 28px;
		}

		.write-table {
			width: 100%;
			border-collapse: collapse;
			table-layout: fixed;
		}

		.write-table th,
		.write-table td {
			border-bottom: 1px solid #e8edf7;
			padding: 12px 10px;
			text-align: left;
			vertical-align: middle;
		}

		.write-table th {
			width: 120px;
			color: #243664;
			font-size: 13px;
			font-weight: bold;
			background: #f5f7fc;
		}

		.write-table input[type="text"],
		.write-table input[type="password"],
		.write-table input[type="file"],
		.write-table textarea {
			box-sizing: border-box;
			width: 100%;
			border: 1px solid #c9d2e6;
			padding: 8px 10px;
			color: #333;
			font-size: 13px;
			line-height: 1.5;
		}

		.write-table input[type="password"] {
			max-width: 240px;
		}

		.write-table textarea {
			min-height: 220px;
			resize: vertical;
		}

		.required {
			color: #d54444;
		}

		.write-actions {
			padding-top: 22px;
			text-align: center;
		}

		.write-actions input {
			min-width: 96px;
			height: 36px;
			border: 1px solid #5e73bb;
			background: #5e73bb;
			color: #fff;
			font-weight: bold;
			cursor: pointer;
		}

		.write-actions input[type="reset"] {
			margin-left: 8px;
			border-color: #b7bfd4;
			background: #f4f6fb;
			color: #47506a;
		}
	</style>
	<SCRIPT type="text/javascript">
function check(){
    if(!bbs.subject.value){
        alert("제목을 입력하세요");
        bbs.subject.focus();
        return false;
    }
    if(!bbs.writer.value){
        
        alert("이름을 입력하세요");
        bbs.writer.focus();
        return false;
    }
   /*  if(!bbs.content.value){            
        alert("글 내용을 입력하세요");
        bbs.content.focus();
        return false;
    } */
    if(!bbs.pwd.value){            
        alert("비밀번호를 입력하세요");
        bbs.pwd.focus();
        return false;
    }
 
    document.bbs.submit();
 
}
</SCRIPT>
</head>
<body>
	 <%
        pageContext.include("/include/header.jsp");
     %>

    <div id="pageContainer">
        <div class="write-wrap">
            <div class="write-title">
                <h2>게시판 글쓰기</h2>
                <p>제목, 글쓴이, 비밀번호는 꼭 입력해주세요.</p>
            </div>
            <!-- form 시작 ---------->
            <form name="bbs" class="write-form" action="<%=request.getContextPath()%>/BoardWriteOk.do" method="POST">
                <table class="write-table">
                    <tr>
                        <th>제목 <span class="required">*</span></th>
                        <td><input type="text" name="subject"></td>
                    </tr>
                    <tr>
                        <th>글쓴이 <span class="required">*</span></th>
                        <td><input type="text" name="writer"></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td><input type="text" name="email"></td>
                    </tr>
                    <tr>
                        <th>홈페이지</th>
                        <td><input type="text" name="homepage" value="http://"></td>
                    </tr>
                    <tr>
                        <th>글내용</th>
                        <td><textarea rows="10" cols="60" name="content" class="ckeditor"></textarea></td>
                    </tr>
                    <tr>
                        <th>비밀번호 <span class="required">*</span></th>
                        <td><input type="password" name="pwd"></td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td><input type="file" name="filename"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="write-actions">
                            <input type="button" value="글쓰기" onclick="check();" /> 
                            <input type="reset"  value="다시쓰기" />
                        </td>
                    </tr>
                </table>
              </form>
            
        </div>
    </div>
</body>
</html>
