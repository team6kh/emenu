package qna.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import qna.dto.QnaDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class GetQna {
	
	public static SqlMapClient sqlMapper;

	private QnaDTO paramClass = new QnaDTO();

	private QnaDTO resultClass = new QnaDTO();

	private int qna_num;

	private String qna_category;
	private String searchText;
	private String qna_checkreply;

	private List<QnaDTO> list = new ArrayList<QnaDTO>();
	private List<QnaDTO> topList = new ArrayList<QnaDTO>();
	public static Reader reader;
	
	public GetQna() throws Exception{
	reader = Resources.getResourceAsReader("sqlMapConfig.xml");
	sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
	reader.close();
	}
	
	@RequestMapping("/getQna.do")
	public String getQna(HttpServletRequest request) throws Exception{
		
		sqlMapper.update("Qna.updateReadCount", Integer.parseInt(request.getParameter("qna_num")));		
		// 상세보기 조회
		resultClass = (QnaDTO) sqlMapper.queryForObject("Qna.getQna",Integer.parseInt(request.getParameter("qna_num")));
		// resultClass.setQna_content(resultClass.getQna_content().replaceAll("\n","<br/>"));
		request.setAttribute("resultClass", resultClass);
		return "/view/qna/viewQna.jsp";
	}
	
	
}
