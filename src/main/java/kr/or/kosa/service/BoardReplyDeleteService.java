package kr.or.kosa.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;

public class BoardReplyDeleteService implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Integer> result = new HashMap<>();
		int row = 0;

		try {
			String no = request.getParameter("no");
			String delPwd = request.getParameter("delPwd");

			BoardService service = BoardService.getInBoardService();
			row = service.replyDelete(no, delPwd);
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			result.put("result", row);

			Gson gson = new Gson();
			String json = gson.toJson(result);

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

}
