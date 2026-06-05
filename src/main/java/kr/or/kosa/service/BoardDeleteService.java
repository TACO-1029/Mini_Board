package kr.or.kosa.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;

public class BoardDeleteService implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = new ActionForward();

		try {
			String idx = request.getParameter("idx");
			String pwd = request.getParameter("pwd");

			BoardService service = BoardService.getInBoardService();
			int result = service.board_Delete(idx, pwd);

			String msg;
			if (result > 0) {
				msg = "delete success";
			} else if (result == -1) {
				msg = "password fail";
			} else {
				msg = "delete fail";
			}

			request.setAttribute("board_msg", msg);
			request.setAttribute("board_url", request.getContextPath() + "/board/board_list.jsp");

			forward.setRedirect(false);
			forward.setPath("/board/board_deleteok.jsp");
		} catch (Exception e) {
			e.printStackTrace();

			request.setAttribute("board_msg", "delete fail");
			request.setAttribute("board_url", request.getContextPath() + "/board/board_list.jsp");

			forward.setRedirect(false);
			forward.setPath("/board/board_deleteok.jsp");
		}

		return forward;
	}
}
