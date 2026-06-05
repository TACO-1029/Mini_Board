package kr.or.kosa.service;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.BoardDao;
import kr.or.kosa.dto.Board;
import kr.or.kosa.dto.Reply;

public class BoardContentService implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
        ActionForward forward = new ActionForward();

        try {
            String idx = request.getParameter("idx");

            if (idx == null || idx.trim().equals("")) {
                forward.setRedirect(true);
                forward.setPath(request.getContextPath() + "/BoardList.do");
                return forward;
            }

            idx = idx.trim();

            String cpage = request.getParameter("cp");
            String pagesize = request.getParameter("ps");

            if (cpage == null || cpage.trim().equals("")) {
                cpage = "1";
            }

            if (pagesize == null || pagesize.trim().equals("")) {
                pagesize = "5";
            }

            BoardDao boardDao = new BoardDao();

            boardDao.getReadNum(idx);
            Board board = boardDao.getContent(Integer.parseInt(idx));
            List<Reply> replylist = boardDao.replylist(idx);

            request.setAttribute("idx", idx);
            request.setAttribute("cpage", cpage);
            request.setAttribute("pagesize", pagesize);
            request.setAttribute("board", board);
            request.setAttribute("replylist", replylist);

            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/board_content.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            forward.setRedirect(true);
            forward.setPath(request.getContextPath() + "/BoardList.do");
        }

        return forward;
    }
}
