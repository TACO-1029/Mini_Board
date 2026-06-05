<%@page import="kr.or.kosa.dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글내용</title>
<link rel="Stylesheet"
	href="<%=request.getContextPath()%>/style/default.css" />
<style type="text/css">
	.content-wrap {
		max-width: 860px;
		margin: 34px auto 48px;
		padding: 0 24px;
	}

	.content-title {
		margin-bottom: 18px;
		border-bottom: 2px solid #5e73bb;
		padding-bottom: 12px;
		text-align: left;
	}

	.content-title h2 {
		margin: 0;
		color: #26345f;
		font-size: 22px;
		font-weight: bold;
	}

	.content-title p {
		margin: 6px 0 0;
		color: #777;
		font-size: 12px;
	}

	.content-table,
	.reply-table {
		width: 100%;
		border-collapse: collapse;
		table-layout: fixed;
		border: 1px solid #d8dfef;
		background: #fff;
	}

	.content-table th,
	.content-table td,
	.reply-table th,
	.reply-table td {
		border-bottom: 1px solid #e8edf7;
		padding: 12px 10px;
		color: #333;
		font-size: 13px;
		vertical-align: middle;
	}

	.content-table th,
	.reply-table th {
		color: #243664;
		font-weight: bold;
		background: #f5f7fc;
		text-align: center;
	}

	.content-table .content-body {
		min-height: 120px;
		line-height: 1.7;
		text-align: left;
		word-break: break-all;
	}

	.content-actions {
		padding: 18px 0 24px;
		text-align: center;
	}

	.content-actions a,
	.reply-button {
		display: inline-block;
		min-width: 70px;
		height: 32px;
		box-sizing: border-box;
		border: 1px solid #5e73bb;
		background: #5e73bb;
		color: #fff;
		font-weight: bold;
		line-height: 30px;
		text-align: center;
		text-decoration: none;
		cursor: pointer;
	}

	.content-actions a:hover,
	.reply-button:hover {
		background: #4a5fa2;
		color: #fff;
	}

	.reply-section {
		margin-top: 10px;
	}

	.reply-title {
		margin: 0 0 10px;
		color: #26345f;
		font-size: 16px;
		text-align: left;
	}

	.reply-form-table {
		margin-bottom: 18px;
	}

	.reply-form-table input[type="text"],
	.reply-form-table input[type="password"],
	.reply-form-table textarea,
	.reply-table input[type="password"] {
		box-sizing: border-box;
		border: 1px solid #c9d2e6;
		padding: 8px 10px;
		color: #333;
		font-size: 13px;
		line-height: 1.5;
	}

	.reply-form-table input[type="text"],
	.reply-form-table textarea {
		width: 100%;
	}

	.reply-form-table textarea {
		min-height: 70px;
		resize: vertical;
	}

	.reply-form-table input[type="password"],
	.reply-table input[type="password"] {
		width: 110px;
	}

	.reply-table tbody tr:hover {
		background: #f8faff;
	}

	.reply-content-cell {
		text-align: left;
		line-height: 1.7;
		word-break: break-all;
	}

	.reply-date {
		color: #777;
		font-size: 12px;
	}

	.reply-empty {
		text-align: center;
		color: #777;
	}
</style>
</head>
<body>
	<%
		String idx = (String) request.getAttribute("idx");
		String cpage = (String) request.getAttribute("cpage");
		String pagesize = (String) request.getAttribute("pagesize");
		Board board = (Board) request.getAttribute("board");
	%>
	<%
		pageContext.include("/include/header.jsp");
	%>
	<div id="pageContainer">
		<div class="content-wrap">
			<div class="content-title">
				<h2>게시판 글내용</h2>
				<p>게시글 상세 내용을 확인하고 댓글을 남길 수 있습니다.</p>
			</div>
				<table class="content-table">
					<tr>
						<th width="20%">글번호</th>
						<td width="30%"><%=idx%></td>
						<th width="20%">작성일</th>
						<td><%=board.getWritedate()%></td>
					</tr>
					<tr>
						<th width="20%">글쓴이</th>
						<td width="30%"><%=board.getWriter()%></td>
						<th width="20%">조회수</th>
						<td><%=board.getReadnum()%></td>
					</tr>
					<tr>
						<th width="20%">홈페이지</th>
						<td><%=board.getHomepage()%></td>
						<th width="20%">첨부파일</th>
						<td><%=board.getFilename()%></td>
					</tr>
					<tr>
						<th width="20%">제목</th>
						<td colspan="3"><%=board.getSubject()%></td>
					</tr>
					<tr>
						<th width="20%">글내용</th>
						<td colspan="3" class="content-body">
							<%
								String content = board.getContent();
								if(content != null){
									content = content.replace("\n", "<br>");
								}
								out.print(content);
							%>
						</td>
					</tr>
				</table>
				<div class="content-actions">
					<a href="<%=request.getContextPath()%>/BoardList.do?cp=<%=cpage%>&ps=<%=pagesize%>">목록</a>
					<a href="<%=request.getContextPath()%>/board/board_edit.jsp?idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pagesize%>">편집</a>
					<a href="<%=request.getContextPath()%>/BoardDelete.do?idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pagesize%>">삭제</a>
					<a href="<%=request.getContextPath()%>/BoardRewrite.do?idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pagesize%>&subject=<%=board.getSubject()%>">답글</a>
				</div>
				<div class="reply-section">
				<h3 class="reply-title">덧글 쓰기</h3>
				<!--  꼬리글 달기 테이블 -->
				<form name="reply" id="replyForm" method="POST">
						<input type="hidden" name="idx" value="<%=idx%>">
						<input type="hidden" name="userid" value="">
						<table class="content-table reply-form-table">
							<tr>
								<th width="20%">작성자</th>
								<td width="45%">
								 	<input type="text" name="reply_writer">
								</td>
								<th width="15%">비밀번호</th>
								<td>
									<input type="password" name="reply_pwd" size="4">
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									<textarea name="reply_content" rows="2" cols="50"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<input type="button" class="reply-button" value="등록" onclick="reply_check()">
								</td>
							</tr>
						</table>
				</form>
				<h3 class="reply-title">REPLY LIST</h3>
				<!-- 꼬리글 목록 테이블 -->
				<table class="reply-table">
					<thead>
						<tr>
							<th colspan="2">REPLY LIST</th>
						</tr>
					</thead>
					<tbody id="replyTableBody">
						<tr>
							<td colspan="2" class="reply-empty">댓글을 불러오는 중입니다.</td>
						</tr>
					</tbody>
				</table>
				</div>
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
				rows = "<tr><td colspan='2' class='reply-empty'>등록된 댓글이 없습니다.</td></tr>";
			} else {
				$.each(data, function(i, reply) {
					rows += "<tr>"
						+ "<td width='80%' class='reply-content-cell'>"
						+ "[" + escapeHtml(reply.writer) + "] : " + escapeHtml(reply.content)
						+ "<br><span class='reply-date'>작성일:" + escapeHtml(reply.writedate) + "</span>"
						+ "</td>"
						+ "<td width='20%' align='center'>"
						+ "<form name='replyDel' method='POST'>"
						+ "<input type='hidden' name='no' value='" + reply.no + "'>"
						+ "<input type='hidden' name='idx' value='" + boardIdx + "'>"
						+ "password :<input type='password' name='delPwd' size='4'> "
						+ "<input type='button' class='reply-button' value='삭제' onclick='reply_del(this.form)'>"
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
