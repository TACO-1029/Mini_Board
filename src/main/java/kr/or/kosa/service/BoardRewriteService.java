package kr.or.kosa.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dto.Board;

public class BoardRewriteService implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = new ActionForward();

		try {
			String idx = request.getParameter("idx");
			String cpage = request.getParameter("cp");
			String pagesize = request.getParameter("ps");

			Board board = Board.builder()
					.idx(Integer.parseInt(idx))
					.subject(request.getParameter("subject"))
					.writer(request.getParameter("writer"))
					.email(request.getParameter("email"))
					.homepage(request.getParameter("homepage"))
					.content(request.getParameter("content"))
					.pwd(request.getParameter("pwd"))
					.filename(request.getParameter("filename"))
					.build();

			BoardService service = BoardService.getInBoardService();
			int result = service.rewriteok(board);

			String msg;
			String url;
			if (result > 0) {
				msg = "rewrite insert success";
				url = request.getContextPath() + "/board/board_list.jsp";
				if (cpage != null && pagesize != null) {
					url += "?cp=" + cpage + "&ps=" + pagesize;
				}
			} else {
				msg = "rewrite insert fail";
				url = request.getContextPath() + "/board/board_content.jsp?idx=" + idx;
			}

			request.setAttribute("board_msg", msg);
			request.setAttribute("board_url", url);

			forward.setRedirect(false);
			forward.setPath("/board/redirect.jsp");
		} catch (Exception e) {
			e.printStackTrace();

			request.setAttribute("board_msg", "rewrite insert fail");
			request.setAttribute("board_url", request.getContextPath() + "/board/board_list.jsp");

			forward.setRedirect(false);
			forward.setPath("/board/redirect.jsp");
		}

		return forward;
	}

}
