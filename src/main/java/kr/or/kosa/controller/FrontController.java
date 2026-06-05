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
<<<<<<< HEAD
import kr.or.kosa.service.BoardDeleteService;
import kr.or.kosa.service.BoardWriteService;
=======
import kr.or.kosa.service.BoardReplyDeleteService;
import kr.or.kosa.service.BoardReplyOkService;
import kr.or.kosa.service.BoardReplyService;
>>>>>>> origin/main

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
    } else if (urlCommand.equals("/BoardDelete.do")) {
      action = new BoardDeleteService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardDeleteOk.do")) {
      forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/board_delteok.jsp");
    } else if (urlCommand.equals("/BoardEdit.do")) {
      action = new BoardEditService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardEditOk.do")) {
      forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/board_editok.jsp");
    } else if (urlCommand.equals("/BoardList.do")) {
      action = new BoardListService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardReply.do")) {
      action = new BoardReplyService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardReplyOk.do")) {
      action = new BoardReplyOkService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardReplyDelete.do")) {
      action = new BoardReplyDeleteService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardReplyDeleteOk.do")) {
      forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/boardreply_deleteok.jsp");
    } else if (urlCommand.equals("/BoardWrite.do")) {
      action = new BoardWriteService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardWriteOk.do")) {
      forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/board_writeok.jsp");
    } else if (urlCommand.equals("/BoardRewrite.do")) {
      action = new BoardRewriteService();
      forward = action.execute(request, response);
    } else if (urlCommand.equals("/BoardRewriteOk.do")) {
      forward = new ActionForward();
      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/board_rewriteok.jsp");
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