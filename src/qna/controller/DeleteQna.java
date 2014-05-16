package qna.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import qna.dto.QnaDTO;


@Controller
public class DeleteQna {
	
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

	public DeleteQna() throws Exception{
	reader = Resources.getResourceAsReader("sqlMapConfig.xml");
	sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
	reader.close();
	}
	
	@RequestMapping("/deleteQna.do")
	public String deleteQna(HttpServletRequest request, @ModelAttribute QnaDTO paramClass) throws Exception{
		
		sqlMapper.queryForObject("Qna.getQna", Integer.parseInt(request.getParameter("qna_num")));	
		sqlMapper.delete("Qna.deleteQna", paramClass);
		return "/listQna.do";

 }
}
