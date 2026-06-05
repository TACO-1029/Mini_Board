package kr.or.kosa.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;

public class BoardReplyOkService implements Action {

  @Override
  public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
    ActionForward forward = new ActionForward();

    try {
      int idx_fk = Integer.parseInt(request.getParameter("idx"));
      String writer = request.getParameter("writer");
      String userid = request.getParameter("userid");
      String content = request.getParameter("content");
      String pwd = request.getParameter("pwd");

      BoardReplyService replyService = new BoardReplyService();
      int result = replyService.replyWrite(idx_fk, writer, userid, content, pwd);

      request.setAttribute("result", result);

      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/board_replyok.jsp");

    } catch (Exception e) {
      e.printStackTrace();

      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/error.jsp");
    }

    return forward;
  }
}
