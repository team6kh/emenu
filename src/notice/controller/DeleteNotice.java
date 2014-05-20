package notice.controller;

import java.io.IOException;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class DeleteNotice {
	
	SqlMapClientTemplate ibatis = null;
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	private notice.dto.NoticeDTO paramClass = new notice.dto.NoticeDTO(); // 파라미터를 저장할 객체
	private notice.dto.NoticeDTO resultClass = new notice.dto.NoticeDTO(); // 쿼리 결과 값을 저장할 객체
	
	private int currentPage; // 현재 페이지
	private int notice_num;
	
	public DeleteNotice() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute("NoticeDTO") notice.dto.NoticeDTO dto) throws Exception{
		
		// 해당 번호의 글을 가져온다.
		resultClass = (notice.dto.NoticeDTO) sqlMapper.queryForObject("Notice.selectOne", dto.getNotice_num());

		// 삭제 쿼리 수행.
		sqlMapper.update("Notice.deleteNotice", dto);
		
		return "listNotice.do";
	}
}
