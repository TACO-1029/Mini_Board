package kr.or.kosa.service;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import javax.naming.NamingException;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.BoardDao;
import kr.or.kosa.dto.Reply;


public class BoardReplyService implements Action {

  @Override
  public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
    ActionForward forward = new ActionForward();

    try {
      String idx_fk = request.getParameter("idx");

      List<Reply> replyList = replyList(idx_fk);

      request.setAttribute("replyList", replyList);

      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/board_reply.jsp");

    } catch (Exception e) {
      e.printStackTrace();

      forward.setRedirect(false);
      forward.setPath("/WEB-INF/views/error.jsp");
    }

    return forward;
  }

  //서비스 요청(댓글 목록 조회하기)
  public List<Reply> replyList(String idx_fk) throws NamingException {
    return new BoardDao().replylist(idx_fk);
  }

  //서비스 요청(댓글 입력하기)
  public int replyWrite(int idx_fk,String writer,String userid, String content,String pwd) throws NamingException {
    return new BoardDao().replywrite(idx_fk, writer, userid, content, pwd);
  }
}
