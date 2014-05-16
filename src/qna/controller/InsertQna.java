package qna.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import qna.dto.QnaDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class InsertQna {
	
	public static Reader reader;
	public static SqlMapClient sqlMapper; 

	QnaDTO paramClass;    
	QnaDTO resultClass;

	private int currentPage;
	private int qna_num;
	Calendar today = Calendar.getInstance();

	public InsertQna() throws Exception
	{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	
	// Qna 게시판 글 쓰기 폼으로 가기
	@RequestMapping("/insertQnaForm.do")
	public String insertQnaForm(HttpServletRequest request, HttpSession session) throws Exception{
		
		resultClass = new QnaDTO();
		
		request.setAttribute("resultClass", resultClass);
		
		return "/view/qna/insertQna.jsp";
	}
	
	// 글쓰기 DB 처리
	@RequestMapping("/insertQna.do")
	public String insertQna(HttpServletRequest request, @ModelAttribute QnaDTO paramClass) throws Exception{
		
		sqlMapper.insert("Qna.insertQna", paramClass);
		return "redirect:/listQna.do";
	}
	
	

	
}
