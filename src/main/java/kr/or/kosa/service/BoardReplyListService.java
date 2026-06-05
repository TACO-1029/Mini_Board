package kr.or.kosa.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dto.Reply;

public class BoardReplyListService implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			String idx = request.getParameter("idx");
			BoardService service = BoardService.getInBoardService();
			List<Reply> replyList = service.replyList(idx);
			List<Map<String, Object>> result = new ArrayList<>();

			if (replyList != null) {
				for (Reply reply : replyList) {
					Map<String, Object> item = new LinkedHashMap<>();
					item.put("no", reply.getNo());
					item.put("writer", reply.getWriter());
					item.put("content", reply.getContent());
					item.put("writedate", reply.getWritedate());
					item.put("idx_fk", reply.getIdx_fk());
					result.add(item);
				}
			}

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
