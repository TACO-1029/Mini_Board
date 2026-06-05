package kr.or.kosa.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.service.BoardContentService;
import kr.or.kosa.service.BoardDeleteService;
import kr.or.kosa.service.BoardListService;
import kr.or.kosa.service.BoardReplyDeleteService;
import kr.or.kosa.service.BoardReplyListService;
import kr.or.kosa.service.BoardReplyService;
import kr.or.kosa.service.BoardWriteService;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FrontController() {
		super();
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());

		System.out.println("urlCommand = " + urlCommand);

		Action action = null;
		ActionForward forward = null;

		if (urlCommand.equals("/BoardContent.do")) {
			action = new BoardContentService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardList.do")) {
			action = new BoardListService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardReplyList.do")) {
			action = new BoardReplyListService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardReply.do")) {
			action = new BoardReplyService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardReplyDelete.do")) {
			action = new BoardReplyDeleteService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardWrite.do")) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/board/board_write.jsp");
		} else if (urlCommand.equals("/BoardWriteOk.do")) {
			action = new BoardWriteService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardDelete.do")) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/board/board_delete.jsp");
		} else if (urlCommand.equals("/BoardDeleteOk.do")) {
			action = new BoardDeleteService();
			forward = action.execute(request, response);
		} else if (urlCommand.equals("/BoardRewrite.do")) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/board/board_rewrite.jsp");
		} else if (urlCommand.equals("/BoardRewriteOk.do")) {
			action = new BoardRewriteService();
			forward = action.execute(request, response);
		}

		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

}
