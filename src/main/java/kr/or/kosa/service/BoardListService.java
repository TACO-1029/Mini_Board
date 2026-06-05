package kr.or.kosa.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.BoardDao;
import kr.or.kosa.dto.Board;
import kr.or.kosa.utils.ThePager;

import java.util.List;

public class BoardListService implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
        ActionForward forward = new ActionForward();

        try {
            String ps = request.getParameter("ps");
            String cp = request.getParameter("cp");

            if (ps == null || ps.trim().equals("")) {
                ps = "5";
            }

            if (cp == null || cp.trim().equals("")) {
                cp = "1";
            }

            int pageSize = Integer.parseInt(ps);
            int cPage = Integer.parseInt(cp);

            BoardDao boardDao = new BoardDao();

            int totalBoardCount = boardDao.totalBoardCount();
            List<Board> boardList = boardDao.list(cPage, pageSize);

            int pageCount = 0;
            if (totalBoardCount % pageSize == 0) {
                pageCount = totalBoardCount / pageSize;
            }
            else {
                pageCount = (totalBoardCount / pageSize) + 1;
            }

            int pagerSize = 3;
            ThePager pager = new ThePager(
                    totalBoardCount,
                    cPage,
                    pageSize,
                    pagerSize,
                    "BoardList.do"
            );

            request.setAttribute("list", boardList);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("cPage", cPage);
            request.setAttribute("pageCount", pageCount);
            request.setAttribute("totalBoardCount", totalBoardCount);
            request.setAttribute("pager", pager);

            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/board_list.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/board_list.jsp");
        }
        return forward;
    }
}
