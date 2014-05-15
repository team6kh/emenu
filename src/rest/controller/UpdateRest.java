package rest.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import rest.dto.RestDTO;
import restopt.dto.RestOptDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateRest {
	//updateForm관련
	private List<RestOptDTO> list = new ArrayList<RestOptDTO>();
	private RestDTO resultClass = new RestDTO();
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	//생성자(연결)
	public UpdateRest() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
		
		
	//formPro.do
	@RequestMapping("/updateRestForm.do")
	public String updateRestForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		
		//수정에 뿌려줄 레코드1개 select
		resultClass = (RestDTO)sqlMapper.queryForObject("Rest.selectRestOne", rest_num);
		//옵션에 뿌려줄 레코드들 select
		list = (List<RestOptDTO>) sqlMapper.queryForList("Rest.selectRestoptOne", rest_num);
	
		request.setAttribute("list", list);
		request.setAttribute("resultClass", resultClass);
		
		return "/view/rest/updateRest.jsp";
	}
}
