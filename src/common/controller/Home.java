package common.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import restopt.dto.RestOptDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class Home {
	
	private List<RestOptDTO> listRestOpt = new ArrayList<RestOptDTO>();
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public Home() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/home.do")
	public String home(HttpServletRequest request) throws SQLException {
		
		/* Masonry 리스트 */
    	listRestOpt = (List<RestOptDTO>) sqlMapper.queryForList("Common.listRestOpt");
    	// 리스트를 받아와 섞는다(shuffle)
    	Collections.shuffle(listRestOpt);
    	// 40개만 뽑아온다.
    	listRestOpt = listRestOpt.subList(0, 80);
    	
    	request.setAttribute("listRestOpt", listRestOpt);
    	
		return "/view/common/home.jsp";
	}

}
