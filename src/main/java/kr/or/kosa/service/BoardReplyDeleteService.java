package kr.or.kosa.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.naming.NamingException;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.BoardDao;

public class BoardReplyDeleteService implements Action {

  @Override
  public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
    ActionForward forward = new ActionForward();

    try {
      String no = request.getParameter("no");
      String pwd = request.getParameter("pwd");

      int result = replyDelete(no, pwd);
      request.setAttribute("result", result);

      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/boardreply_deleteok.jsp");

    } catch (Exception e) {
      e.printStackTrace();

      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/error.jsp");
    }
    return forward;
  }

  //서비스 요청(댓글 삭제하기)
  public int replyDelete(String no, String pwd) throws NamingException {
    return new BoardDao().replyDelete(no, pwd);
  }

}
