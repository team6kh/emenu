package notice.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import notice.dto.NoticeDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class InsertNotice {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	private StringBuffer pagingHtml = new StringBuffer();
	private int currentPage = 1; // 현재 페이지
	private int notice_num; // 현재 글 고유 번호

	Calendar today = Calendar.getInstance(); // 오늘 날짜 구하기.
	
	//DB커넥트 생성자 버전
		public InsertNotice() throws IOException{
			reader = Resources.getResourceAsReader("sqlMapConfig.xml");
			sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		}
		//.DB커넥트 생성자 버전 끝
		
				@RequestMapping("/insertNoticeForm.do")
				public String insertNoticeForm(HttpServletRequest request1){
					
					if(request1.getParameter("currentPage") == null) {
						currentPage = 1;
					}
					else {
						currentPage = Integer.parseInt(request1.getParameter("currentPage"));
					}
					
					//System.out.println(currentPage);
					request1.setAttribute("currentPage", currentPage);
					
					return "/view/notice/insertNoticeForm.jsp";
				}
				
				@RequestMapping(value="/insertNotice.do",method=RequestMethod.POST)
				public String insertRecipe(MultipartHttpServletRequest request, HttpSession session, @ModelAttribute("NoticeDTO") NoticeDTO dto) throws Exception{
					
					dto.setNotice_reg_date(today.getTime());

					// 등록 쿼리 수행.
					sqlMapper.insert("Notice.insertNotice", dto);
					
					return "listNotice.do";


				}
}
