package notice.controller;

import java.io.IOException;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import notice.dto.NoticeDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateNotice {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	private NoticeDTO paramClass; // 파라미터를 저장할 객체
	private NoticeDTO resultClass = new NoticeDTO(); // 쿼리 결과 값을 저장할 객체

	private int currentPage; // 현재 페이지
	private int notice_num;

	//DB커넥트 생성자 버전
	public UpdateNotice() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	@RequestMapping(value="/updateNoticeForm.do")
	public String updateNoticeFrom(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute("NoticeDTO") NoticeDTO dto) throws Exception{
		
		resultClass = (NoticeDTO) sqlMapper.queryForObject("Notice.selectOne", dto.getNotice_num());
		StringBuffer pagingHtml = new StringBuffer();
		pagingHtml.append(resultClass.getNotice_content());
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("resultClass", resultClass);
		
		return "insertNoticeForm.do";
	}
	
	//updateNotice.do
		@RequestMapping(value="/updateNotice.do")
		public String updateNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute("NoticeDTO") NoticeDTO dto) throws Exception{
			
			// 일단 항목만 수정한다.
			sqlMapper.update("Notice.updateNotice", dto);

			// 수정이 끝나면 view 페이지로 이동.
			resultClass = (NoticeDTO) sqlMapper.queryForObject("Notice.selectOne", dto.getNotice_num());
			
			request.setAttribute("resultClass", resultClass);
			
			return "/readNotice.do";
		}
}
