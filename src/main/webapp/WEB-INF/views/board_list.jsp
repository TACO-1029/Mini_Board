<%@page import="kr.or.kosa.utils.ThePager"%>
<%@page import="kr.or.kosa.dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.kosa.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>
<link rel="Stylesheet" href="<%=request.getContextPath()%>/style/default.css" />
<style type="text/css">
	.list-wrap {
		max-width: 860px;
		margin: 34px auto 48px;
		padding: 0 24px;
	}

	.list-title {
		margin-bottom: 18px;
		border-bottom: 2px solid #5e73bb;
		padding-bottom: 12px;
		text-align: left;
	}

	.list-title h2 {
		margin: 0;
		color: #26345f;
		font-size: 22px;
		font-weight: bold;
	}

	.list-title p {
		margin: 6px 0 0;
		color: #777;
		font-size: 12px;
	}

	.list-toolbar {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 12px;
		border: 1px solid #d8dfef;
		border-bottom: 0;
		background: #f5f7fc;
		padding: 12px 16px;
		color: #47506a;
		font-size: 13px;
	}

	.list-toolbar select {
		border: 1px solid #c9d2e6;
		background: #fff;
		padding: 6px 8px;
		color: #333;
		font-size: 13px;
	}

	.list-toolbar .total-count {
		font-weight: bold;
		color: #26345f;
	}

	.write-link {
		display: inline-block;
		min-width: 78px;
		height: 32px;
		box-sizing: border-box;
		border: 1px solid #5e73bb;
		background: #5e73bb;
		color: #fff;
		font-weight: bold;
		line-height: 30px;
		text-align: center;
		text-decoration: none;
	}

	.write-link:hover {
		background: #4a5fa2;
		color: #fff;
	}

	.list-table {
		width: 100%;
		border-collapse: collapse;
		table-layout: fixed;
		border: 1px solid #d8dfef;
		background: #fff;
	}

	.list-table th,
	.list-table td {
		border-bottom: 1px solid #e8edf7;
		padding: 12px 10px;
		color: #333;
		font-size: 13px;
		vertical-align: middle;
	}

	.list-table th {
		color: #243664;
		font-weight: bold;
		background: #f5f7fc;
		text-align: center;
	}

	.list-table tbody tr:hover {
		background: #f8faff;
	}

	.list-table .subject-cell {
		text-align: left;
	}

	.list-table .subject-cell a {
		color: #26345f;
		font-weight: bold;
		text-decoration: none;
	}

	.list-table .subject-cell a:hover {
		color: #5e73bb;
		text-decoration: underline;
	}

	.empty-row {
		text-align: center;
		color: #777;
	}

	.list-pagination {
		margin-top: 18px;
		text-align: center;
		color: #47506a;
		font-size: 13px;
	}

	.list-pagination a {
		display: inline-block;
		margin: 0 3px;
		color: #26345f;
		text-decoration: none;
	}

	.list-pagination a:hover {
		color: #5e73bb;
		text-decoration: underline;
	}

	.list-pagination .current-page {
		display: inline-block;
		margin: 0 3px;
		color: #d54444;
		font-weight: bold;
	}

	.pager-output {
		margin-top: 10px;
	}
</style>
</head>
<body>
	<c:import url="/include/header.jsp" />
	<%
		List<Board> list = (List<Board>) request.getAttribute("list");
		int pageSize = (Integer) request.getAttribute("pageSize");
		int cPage = (Integer) request.getAttribute("cPage");
		int pageCount = (Integer) request.getAttribute("pageCount");
		int totalBoardCount = (Integer) request.getAttribute("totalBoardCount");
		ThePager pager = (ThePager) request.getAttribute("pager");
				%>
	<c:set var="pagesize" value="<%=pageSize%>" />
	<c:set var="cpage" value="<%=cPage%>" />
	<c:set var="pagecount" value="<%=pageCount%>" />

	<div id="pagecontainer">
		<div class="list-wrap">
			<div class="list-title">
				<h2>게시판 목록</h2>
				<p>등록된 게시글을 확인하고 상세 내용을 볼 수 있습니다.</p>
			</div>
			<div class="list-toolbar">
				<form name="list">
					PageSize설정:
					<select name="ps" onchange="this.form.submit()">
						<c:forEach var="i" begin="5" end="20" step="5">
							<c:choose>
								<c:when test="${pagesize == i}">
									<option value="${i}" selected>${i}건</option>
								</c:when>
								<c:otherwise>
									<option value="${i}">${i}건</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</form>
				<div>
					<span class="total-count">총 게시물 수 : <%= totalBoardCount %></span>
					<a class="write-link" href="<%=request.getContextPath()%>/BoardWrite.do">글쓰기</a>
				</div>
			</div>
			<table class="list-table">
				<thead>
					<tr>
						<th width="10%">순번</th>
						<th width="40%">제목</th>
						<th width="20%">글쓴이</th>
						<th width="20%">날짜</th>
						<th width="10%">조회수</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터가 한건도 없는 경우  -->
					<%
						if(list == null || list.size() == 0){
							out.print("<tr><td class='empty-row' colspan='5'>데이터가 없습니다</td></tr>");
						}
					%>
					<!-- forEach()  목록 출력하기  -->
					<c:forEach var="board" items="<%=list %>">
						<tr>
							<td align="center">${board.idx}</td>
							<td class="subject-cell">
								<c:forEach var="i" begin="1" end="${board.depth}" step="1">
									&nbsp;&nbsp;&nbsp;
								</c:forEach>
								<c:if test="${board.depth > 0}">
									<img src="${pageContext.request.contextPath}/images/re.gif">
								</c:if>
								<a href="${pageContext.request.contextPath}/BoardContent.do?idx=${board.idx}&cp=${cpage}&ps=${pagesize}">
									<c:choose>
										<c:when test="${board.subject != null && fn:length(board.subject) > 10}">
											${fn:substring(board.subject,0,10)}...
										</c:when>
										<c:otherwise>
											${board.subject}
										</c:otherwise>
									</c:choose>
								</a>
							</td>
							<td align="center">${board.writer}</td>
							<td align="center">${board.writedate}</td>
							<td align="center">${board.readnum}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="list-pagination">
				<c:if test="${cpage > 1}">
					<a href="BoardList.do?cp=${cpage-1}&ps=${pagesize}">이전</a>
				</c:if>
				<c:forEach var="i" begin="1" end="${pagecount}" step="1">
					<c:choose>
						<c:when test="${cpage==i}">
							<span class="current-page">[${i}]</span>
						</c:when>
						<c:otherwise>
							<a href="BoardList.do?cp=${i}&ps=${pagesize}">[${i}]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${cpage < pagecount}">
					<a href="BoardList.do?cp=${cpage+1}&ps=${pagesize}">다음</a>
				</c:if>
				<div class="pager-output">
					<%= pager.toString() %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
