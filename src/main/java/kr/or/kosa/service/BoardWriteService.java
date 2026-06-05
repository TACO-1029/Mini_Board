package kr.or.kosa.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dto.Board;

// FrontController에서 action.execute(request, response)로 호출되는 클래스
public class BoardWriteService implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = new ActionForward();

		try {
			// 1. 파라미터 받기 (JSP의 useBean 역할을 Java에서 직접 수행)
			String subject = request.getParameter("subject");
			String writer = request.getParameter("writer");
			String email = request.getParameter("email");
			String homepage = request.getParameter("homepage");
			String content = request.getParameter("content");
			String pwd = request.getParameter("pwd");
			// 첨부파일 처리는 cos.jar 또는 Servlet 3.0의 Part 등을 사용해야 하나, 여기서는 텍스트 파라미터 기준으로 작성합니다.

			// 2. DTO에 데이터 세팅
			Board board = Board.builder()
					.subject(subject)
					.writer(writer)
					.email(email)
					.homepage(homepage)
					.content(content)
					.pwd(pwd)
					.build();

			// 3. Service 로직 호출
			BoardService service = BoardService.getInBoardService();
			int result = service.writeOk(board);

			// 4. 결과에 따른 분기 처리 및 데이터 저장
			String msg = "";
			String url = "";
			if (result > 0) {
				msg = "글쓰기 성공!";
				url = request.getContextPath() + "/board/board_list.jsp";
			} else {
				msg = "글쓰기 실패!";
				url = request.getContextPath() + "/BoardWrite.do";
			}

			// View에서 쓸 수 있도록 request 객체에 데이터 담기
			request.setAttribute("board_msg", msg);
			request.setAttribute("board_url", url);

			// 5. 이동 경로 및 방식 설정 (FrontController로 전달됨)
			forward.setRedirect(false); // request에 데이터를 담았으므로 무조건 forward 방식을 써야 합니다.
			forward.setPath("/board/board_writeok.jsp"); // 결과를 띄워줄 순수 View 페이지 경로

		} catch (Exception e) {
			e.printStackTrace();

			request.setAttribute("board_msg", "글쓰기 실패!");
			request.setAttribute("board_url", request.getContextPath() + "/BoardWrite.do");

			forward.setRedirect(false);
			forward.setPath("/board/board_writeok.jsp");
		}

		return forward;
	}
}
