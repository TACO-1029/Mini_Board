package kr.or.kosa.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;

public class BoardReplyService implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Integer> result = new HashMap<>();
		int row = 0;

		try {
			int idx = Integer.parseInt(request.getParameter("idx"));
			String writer = request.getParameter("reply_writer");
			String content = request.getParameter("reply_content");
			String pwd = request.getParameter("reply_pwd");
			String userid = request.getParameter("userid");

			if (userid == null) {
				userid = "";
			}

			BoardService service = BoardService.getInBoardService();
			row = service.replyWrite(idx, writer, userid, content, pwd);
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
