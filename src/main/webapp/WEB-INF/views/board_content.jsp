<%@page import="kr.or.kosa.dto.Board"%>
<%@page import="kr.or.kosa.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>board_content</title>
<link rel="Stylesheet"
	href="<%=request.getContextPath()%>/style/default.css" />
</head>
<body>
	<%
		String idx= request.getParameter("idx"); //글번호 받기
		
		//글 번호를 가지고 오지  않았을 경우 예외처리
		if(idx == null || idx.trim().equals("")){
			response.sendRedirect(request.getContextPath() + "/board/board_list.jsp");
			return; //더 이상 아래 코드가 실행되지 않고 클라이언트에게 바로 코드 전달
		}
		
		idx=idx.trim();
		//http://192.168.0.12:8090/WebServlet_5_Board_Model1_Sample/board/board_content.jsp?idx=19&cp=1&ps=5
		//board_content.jsp?idx=19&cp=1&ps=5  //다시 목록으로 갔을때  ... cp , ps 가지고 ...
		//why: 목록으로 이동시 현재 page 유지하고 싶어요
		String cpage = request.getParameter("cp"); //current page
		String pagesize = request.getParameter("ps"); //pagesize
		
		//List 페이지 처음 호출 ...
		if(cpage == null || cpage.trim().equals("")){
			//default 값 설정
			cpage = "1"; 
		}
	
		if(pagesize == null || pagesize.trim().equals("")){
			//default 값 설정
			pagesize = "5"; 
		}
		
		//상세보기 내용
		BoardService service = BoardService.getInBoardService();
		
		//옵션
		//조회수 증가
		boolean isread = service.addReadNum(idx);
		if(isread)System.out.println("조회증가 : " + isread);
		
		
		//데이터 조회 (1건 (row))
		Board board = service.content(Integer.parseInt(idx));
	
	%>
	<%
		pageContext.include("/include/header.jsp");
	%>
	<div id="pageContainer">
		<div style="padding-top: 30px; text-align: center">
			<center>
				<b>게시판 글내용</b>
				<table width="80%" border="1">
					<tr>
						<td width="20%" align="center"><b> 글번호 </b></td>
						<td width="30%"><%=idx%></td>
						<td width="20%" align="center"><b>작성일</b></td>
						<td><%=board.getWritedate()%></td>
					</tr>
					<tr>
						<td width="20%" align="center"><b>글쓴이</b></td>
						<td width="30%"><%=board.getWriter()%></td>
						<td width="20%" align="center"><b>조회수</b></td>
						<td><%=board.getReadnum()%></td>
					</tr>
					<tr>
						<td width="20%" align="center"><b>홈페이지</b></td>
						<td><%=board.getHomepage()%></td>
						<td width="20%" align="center"><b>첨부파일</b></td>
						<td><%=board.getFilename()%></td>
					</tr>
					<tr>
						<td width="20%" align="center"><b>제목</b></td>
						<td colspan="3"><%=board.getSubject()%></td>
					</tr>
					<tr height="100">
						<td width="20%" align="center"><b>글내용</b></td>
						<td colspan="3">
							<%
								String content = board.getContent();
								if(content != null){
									content = content.replace("\n", "<br>");
								}
								out.print(content);
							%>

						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
						<a href="<%=request.getContextPath()%>/board/board_list.jsp?cp=<%=cpage%>&ps=<%=pagesize%>">목록가기</a> |
						<a href="<%=request.getContextPath()%>/board/board_edit.jsp?idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pagesize%>">편집</a>	|
						<a href="<%=request.getContextPath()%>/board/board_delete.jsp?idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pagesize%>">삭제</a> |
						<a href="<%=request.getContextPath()%>/board/board_rewrite.jsp?idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pagesize%>&subject=<%=board.getSubject()%>">답글</a>
						</td>
					</tr>
				</table>
				<br>
				<!--  꼬리글 달기 테이블 -->
				<form name="reply" id="replyForm" method="POST">
						<!-- hidden 태그  값을 숨겨서 처리  -->
						<input type="hidden" name="idx" value="<%=idx%>"> 
						<input type="hidden" name="userid" value=""><!-- 추후 필요에 따라  -->
						<!-- hidden data -->
						<table width="80%" border="1">
							<tr>
								<th colspan="2">덧글 쓰기</th>
							</tr>
							<tr>
								<td align="left">작성자 :
								 	<input type="text" name="reply_writer"><br /> 
								 	내&nbsp;&nbsp;용 : 
								 	<textarea name="reply_content" rows="2" cols="50"></textarea>
								</td>
								<td align="left">
									비밀번호:
									<input type="password" name="reply_pwd" size="4"> 
									<input type="button" value="등록" onclick="reply_check()">
								</td>
							</tr>
						</table>
				</form>
				<br>
				<!-- 꼬리글 목록 테이블 -->
				<table width="80%" border="1">
					<thead>
						<tr>
							<th colspan="2">REPLY LIST</th>
						</tr>
					</thead>
					<tbody id="replyTableBody">
						<tr>
							<td colspan="2" align="center">댓글을 불러오는 중입니다.</td>
						</tr>
					</tbody>
				</table>
			</center>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		var boardIdx = "<%=idx%>";

		$(function() {
			loadReplyList();
		});

		function loadReplyList() {
			$.getJSON("BoardReplyList.do?idx=" + boardIdx, function(data) {
				renderReplyRows(data);
			});
		}

		function renderReplyRows(data) {
			var rows = "";

			if (!data || data.length === 0) {
				rows = "<tr><td colspan='2' align='center'>등록된 댓글이 없습니다.</td></tr>";
			} else {
				$.each(data, function(i, reply) {
					rows += "<tr align='left'>"
						+ "<td width='80%'>"
						+ "[" + escapeHtml(reply.writer) + "] : " + escapeHtml(reply.content)
						+ "<br> 작성일:" + escapeHtml(reply.writedate)
						+ "</td>"
						+ "<td width='20%'>"
						+ "<form name='replyDel' method='POST'>"
						+ "<input type='hidden' name='no' value='" + reply.no + "'>"
						+ "<input type='hidden' name='idx' value='" + boardIdx + "'>"
						+ "password :<input type='password' name='delPwd' size='4'> "
						+ "<input type='button' value='삭제' onclick='reply_del(this.form)'>"
						+ "</form>"
						+ "</td>"
						+ "</tr>";
				});
			}

			$("#replyTableBody").html(rows);
		}

		function reply_check() {
			var frm = document.reply;

			if (frm.reply_writer.value === "" || frm.reply_content.value === ""
				|| frm.reply_pwd.value === "") {
				alert("댓글 내용, 작성자, 비밀번호를 모두 입력해야합니다.");
				return false;
			}

			$.ajax({
				url: "BoardReply.do",
				type: "POST",
				data: $("#replyForm").serialize(),
				dataType: "json",
				success: function(data) {
					if (data.result > 0) {
						alert("댓글 등록 성공");
						frm.reply_writer.value = "";
						frm.reply_content.value = "";
						frm.reply_pwd.value = "";
						loadReplyList();
					} else {
						alert("댓글 등록 실패");
					}
				},
				error: function() {
					alert("댓글 등록 실패");
				}
			});

			return false;
		}

		function reply_del(frm) {
			if (frm.delPwd.value === "") {
				alert("비밀번호를 입력하세요");
				frm.delPwd.focus();
				return false;
			}

			$.ajax({
				url: "BoardReplyDelete.do",
				type: "POST",
				data: $(frm).serialize(),
				dataType: "json",
				success: function(data) {
					if (data.result > 0) {
						alert("댓글 삭제 성공");
						loadReplyList();
					} else if (data.result === 0) {
						alert("비밀번호가 일치하지 않습니다.");
					} else if (data.result === -1) {
						alert("삭제할 댓글을 찾을 수 없습니다.");
					} else {
						alert("댓글 삭제 실패");
					}
				},
				error: function() {
					alert("댓글 삭제 실패");
				}
			});

			return false;
		}

		function escapeHtml(value) {
			if (value === null || value === undefined) {
				return "";
			}

			return String(value)
				.replace(/&/g, "&amp;")
				.replace(/</g, "&lt;")
				.replace(/>/g, "&gt;")
				.replace(/"/g, "&quot;")
				.replace(/'/g, "&#039;");
		}
	</script>
</body>
</html>





