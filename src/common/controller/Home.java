package common.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import restopt.dto.RestOptDTO;
import cart.dto.CartDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class Home {
	
	private List<RestOptDTO> listRestOpt = new ArrayList<RestOptDTO>();
	
	private List<CartDTO> listCart = new ArrayList<CartDTO>();
	//private List<CartDTO> listCartPadding = new ArrayList<CartDTO>();
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public Home() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/home.do")
	public String home(HttpServletRequest request, HttpSession session) throws SQLException {		
		
		/* Masonry 리스트 */
    	listRestOpt = (List<RestOptDTO>) sqlMapper.queryForList("Common.listRestOpt");
    	// 리스트를 받아와 섞는다(shuffle)
    	Collections.shuffle(listRestOpt);
    	// 40개만 뽑아온다.
    	listRestOpt = listRestOpt.subList(0, 80);    	
    	
    	request.setAttribute("listRestOpt", listRestOpt);
    	
    	
    	String session_type = (String) session.getAttribute("session_type");
    	String session_id = (String) session.getAttribute("session_id");
    	
    	if (session_type != null && session_id != null && session_type.equals("buyer") ) {
    		// 현재 로그인된 구매자의 카트리스트
    		listCart = sqlMapper.queryForList("Cart.selectCartBoard", session_id);
    		//int size = listCart.size();
    		//listCartPadding = listCart.subList(size-4, size);
    		//listCart = listCart.subList(0, size-4);
    		request.setAttribute("listCart", listCart); 
    		//request.setAttribute("listCartPadding", listCartPadding);
    	}    	
    	
		return "/view/common/home.jsp";
	}

}
