package rest.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import rest.dto.RestDTO;
import restopt.dto.RestOptDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.Constants;


@Controller
public class DeleteRest {
	//삭제관련
	private RestDTO paramClass = new RestDTO();
	private RestDTO resultClass = new RestDTO();
	private RestOptDTO paramClass1 = new RestOptDTO();
	private List<RestOptDTO> list = new ArrayList<RestOptDTO>();
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	//생성자(연결)
	public DeleteRest() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	//deleteRest.do
	@RequestMapping("/deleteRest.do")
	public String deleteRest(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		String session_id = (String) session.getAttribute("session_id");
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		
		/*
		//상품 매인,컨텐트 사진 삭제
		FileUpload fileUpload = new FileUpload();
		resultClass = (RestDTO)sqlMapper.queryForObject("Rest.selectRestOne", rest_num);
		String main_fileName = resultClass.getRest_main_savname();
		String content_fileName = resultClass.getRest_content_savname();
		String main_fileUploadPath = Constants.COMMON_FILE_PATH + Constants.REST_MAIN_FILE_PATH;
		String content_fileUploadPath = Constants.COMMON_FILE_PATH + Constants.REST_CONTENT_FILE_PATH;
		fileUpload.deleteFiles(main_fileName, main_fileUploadPath);
		fileUpload.deleteFiles(content_fileName, content_fileUploadPath);
		*/
		
		//상품레코드 제거
		paramClass.setRest_num(rest_num);
		paramClass.setRest_writer_id(session_id);
		sqlMapper.delete("Rest.deleteRestBoard", paramClass);
		
		//옵션사진 제거
		//옵션을 불러옴
		list = (List<RestOptDTO>) sqlMapper.queryForList("Rest.selectRestoptOne", rest_num);
		
		/*
		//옵션사진 삭제
		for(int i=0; i<list.size(); i++){
			if (list.get(i).getRestopt_orgname() != null) {
				String filesName = list.get(i).	getRestopt_savname();
				String rest_optfileUploadPath = Constants.COMMON_FILE_PATH + Constants.REST_MENU_FILE_PATH;
				fileUpload.deleteFiles(filesName, rest_optfileUploadPath);
			}
		}
		*/
		
		//옵션레코드 제거
		sqlMapper.delete("Rest.deleteRestoptBoard", rest_num);
		
		//카트레코드 제거
		sqlMapper.delete("Rest.deleteCartBoard", paramClass);
		
		/*
		식당이 없어져도 리뷰글은 존재한다.
		만약, 리뷰글을 삭제하고 싶을 경우 주석을 해제하세요.  
		sqlMapper.delete("Rest.deleteReviewtBoard", getRest_num());
		*/
		
		return "redirect:/listRest.do";
	}

}
