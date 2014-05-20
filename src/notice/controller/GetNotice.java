package notice.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

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
public class GetNotice {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	private NoticeDTO resultClass = new NoticeDTO(); // 쿼리 결과 값을 저장할 객체
	private NoticeDTO aClass = new NoticeDTO(); // 이전글 쿼리 결과 값을 저장할 객체
	private NoticeDTO bClass = new NoticeDTO(); // 다음글 쿼리 결과 값을 저장할 객체
	NoticeDTO noticeDTO;
	private int n_count;
	private int rnum;
	private int currentPage = 1;

	private InputStream inputStream;
	private String contentDisposition;
	private long contentLength;
	
	
	
	//DB커넥트 생성자 버전
		public GetNotice() throws IOException{
			reader = Resources.getResourceAsReader("sqlMapConfig.xml");
			sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		}
		
		@RequestMapping(value="/readNotice.do")
		public String readNotice(HttpServletRequest request1, HttpSession session, @ModelAttribute("NoticeDTO") NoticeDTO dto) throws Exception{
			
			// 해당 글의 조회수 +1
			sqlMapper.update("Notice.updateReadCount", dto);
			
			// 게시글의 총 갯수를 가져온다
			resultClass = (NoticeDTO) sqlMapper.queryForObject("Notice.selectNCount");
	        n_count = resultClass.getNotice_num();
	        //System.out.println("n_count="+n_count);
			
	        if(request1.getParameter("currentPage") == null) {
				currentPage = 1;
			}
			else {
				currentPage = Integer.parseInt(request1.getParameter("currentPage"));
			}
	        
			// 해당 번호의 글을 가져온다
			resultClass = (NoticeDTO) sqlMapper.queryForObject("Notice.selectOne", dto.getNotice_num());
			StringBuffer pagingHtml = new StringBuffer();
			pagingHtml.append(resultClass.getNotice_content());
			
			List<NoticeDTO> list = ListNotice.all_list;
			//System.out.println("size=="+list.size());
			for(NoticeDTO dto1 : list){
					if(dto1.getRnum() == dto.getRnum()){
						resultClass = dto1;
					}
		            if(dto1.getRnum() == dto.getRnum()+1){
		                aClass = dto1;
		            }
		            if(dto1.getRnum() == dto.getRnum()-1){
		                bClass = dto1;
		            }
			}
			
			request1.setAttribute("resultClass", resultClass);
			request1.setAttribute("pagingHtml", pagingHtml);
			request1.setAttribute("aClass", aClass);
			request1.setAttribute("bClass", bClass);
			request1.setAttribute("n_count", n_count);
			request1.setAttribute("currentPage", currentPage);
			request1.setAttribute("rnum", dto.getRnum());
			
			return "/view/notice/readNotice.jsp";
		}
		
	}
		
