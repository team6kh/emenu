package user.verification.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import user.verification.dto.EvDTO;

@Controller
public class InsertEv {
	
	private Calendar today = Calendar.getInstance(); // 오늘 날짜 구하기
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public InsertEv() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/verification/insert.do")
	public String insertEv(HttpServletRequest request, @ModelAttribute EvDTO evDTO) throws SQLException {
		
		String ev_requested = (String) request.getAttribute("ev_requested");
		String ev_code = (String) request.getAttribute("ev_code");
		
		//System.out.println("ev_requested:"+ev_requested);
		//System.out.println("ev_code:"+ev_code);
		
		evDTO.setEv_requested(ev_requested);
		evDTO.setEv_code(ev_code);
		evDTO.setEv_reg_date(today.getTime());
		
		sqlMapper.insert("Ev.insertEv", evDTO);
		
		//System.out.println("user_id:"+request.getParameter("user_id"));
		request.setAttribute("actionStatus", "evRequested");
		
		return "/user/get.do";
		
	}
}
