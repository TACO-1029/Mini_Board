<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, kr.or.kosa.dto.Reply" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 리스트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<jsp:include page="/include/header.jsp"/>
<div class="container mt-5">
	<%
		//덧글 목록 보여주기
		List<Reply> replylist = (List<Reply>) request.getAttribute("replyList"); //참조하는 글번호
		if(replylist != null && replylist.size() > 0){
	%>
		<table width="80%" border="1">
			<tr>
				<th colspan="2">REPLY LIST</th>
			</tr>
		<%	   
			for(Reply reply : replylist){
		%>
			<tr align="left">
				<td width="80%">
					[<%=reply.getWriter()%>] : <%=reply.getContent() %>
					<br> 작성일:<%=reply.getWritedate().toString()%>
				</td>
				<td width="20%">
					<form action="board_replydeleteok.jsp" method="POST" name="replyDel">
						<input type="hidden" name="no" value="<%=reply.getNo()%>"> 
						<input type="hidden" name="idx" value="<%=reply.getIdx_fk()%>"> 
						password :<input type="password" name="delPwd" size="4"> 
						<input type="button" value="삭제" onclick="reply_del(this.form)">
					</form>
				</td>
			</tr>
			<%
			}
			%>
		</table>
		<%
  		} 
		%>
</div>

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 검색 필터
    $("#searchInput").on("keyup", function() {
        let value = $(this).val().toLowerCase();
        $("#empTable tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
</script>

<script type="text/javascript">
	function reply_check() {
		var frm = document.reply;
		if (frm.reply_writer.value == "" || frm.reply_content.value == ""
			|| frm.reply_pwd.value == "") {
					alert("댓글 내용, 작성자, 비밀번호를 모두 입력해야합니다.");
			return false;
		}
	frm.submit();
	}
	function reply_del(frm) {
		//alert("del");
		//var frm = document.replyDel;
		//alert(frm);
		if (frm.delPwd.value == "") {
			alert("비밀번호를 입력하세요");
			frm.delPwd.focus();
			return false;
		}
		frm.submit();
	}
</script>

</body>
</html>
