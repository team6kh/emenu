package rest.controller;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import rest.dto.RestDTO;
import restopt.dto.RestOptDTO;
import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.Constants;

@Controller
public class InsertRest {
	private RestDTO paramClass = new RestDTO();
	private RestDTO resultClass = new RestDTO();
	private RestOptDTO paramClass1 = new RestOptDTO();
	private RestOptDTO resultClass1 = new RestOptDTO();
	private SellerDTO sellerDTO = new SellerDTO();
	
	private int seq_num;
	Calendar today = Calendar.getInstance();

	//insertRest.jsp에서 사용자가 입력한 옵션명 파라미터
	private String restopt_subject1;
	private String restopt_subject2;
	private String restopt_subject3;
	private String restopt_subject4;
	private String restopt_subject5;
	private String restopt_subject6;
	private String restopt_subject7;
	private String restopt_subject8;
	private String restopt_subject9;
	private String restopt_subject10;
	private String restopt_subject11;
	private String restopt_subject12;
	private String restopt_subject13;
	private String restopt_subject14;
	private String restopt_subject15;

	//insertRest.jsp에서 사용자가 입력한 옵션가 파라미터
	private int restopt_priceplus1;
	private int restopt_priceplus2;
	private int restopt_priceplus3;
	private int restopt_priceplus4;
	private int restopt_priceplus5;
	private int restopt_priceplus6;
	private int restopt_priceplus7;
	private int restopt_priceplus8;
	private int restopt_priceplus9;
	private int restopt_priceplus10;
	private int restopt_priceplus11;
	private int restopt_priceplus12;
	private int restopt_priceplus13;
	private int restopt_priceplus14;
	private int restopt_priceplus15;

	//옵션사진
	private String optfileUploadPath = Constants.COMMON_FILE_PATH + Constants.REST_MENU_FILE_PATH;

	//매인사진
	private String orgName;
	private String saveName;
	private String fileUploadPath1 = Constants.COMMON_FILE_PATH + Constants.REST_MAIN_FILE_PATH;

	//컨텐트사진
	private String orgName1;
	private String saveName1;	
	private String fileUploadPath2 = Constants.COMMON_FILE_PATH + Constants.REST_CONTENT_FILE_PATH;
	
	//판매자가 글을 썻는지 안썻는지 판단하기 위한 변수
	//판매자 1명당 1개의 상품글을 올릴 수 있도록 하기 위함.
	Integer count;
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	
	//생성자(연결)
	public InsertRest() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
		
		
	//insertRestForm.do
	@RequestMapping("/insertRestForm.do")
	public String insertRestFrom(HttpServletRequest request) throws Exception{
		request.setAttribute("rest_num", "insert");
		return "/view/rest/insertRest.jsp";
	}
	
	
	//insertRest.do
	@RequestMapping(value="/insertRest.do",method=RequestMethod.POST)
	public String insertRestFromPro(MultipartHttpServletRequest request, HttpServletRequest request1, HttpServletResponse response1, HttpSession session) throws Exception{
		
		String session_id = (String) session.getAttribute("session_id");
		
		sellerDTO.setSeller_id(session_id);
		sellerDTO = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerId", sellerDTO);
		
		
		String rest_subject = request1.getParameter("rest_subject");
		String rest_localcategory = request1.getParameter("rest_localcategory");
		String rest_typecategory = request1.getParameter("rest_typecategory");
		
		paramClass.setRest_subject(rest_subject);
		paramClass.setRest_localcategory(rest_localcategory);
		paramClass.setRest_typecategory(rest_typecategory);
		paramClass.setRest_writer_id(session_id);
		paramClass.setRest_writer_name(sellerDTO.getSeller_name()); 
		paramClass.setRest_writer_telnum(sellerDTO.getSeller_telnum());
		paramClass.setRest_writer_mobilenum(sellerDTO.getSeller_mobilenum());
		paramClass.setRest_writer_address(sellerDTO.getSeller_rest_address());
		paramClass.setRest_writer_email(sellerDTO.getSeller_email());
		paramClass.setRest_reg_date(today.getTime());
		//상품글 insert
		sqlMapper.insert("Rest.insertRest", paramClass);
		
		//상품글 insert후 현재 최대시퀀스 값을 가짐
		resultClass = (RestDTO) sqlMapper.queryForObject("Rest.selectLastNum");
		seq_num = (int)(resultClass.getRest_num());
		
		
		restopt_subject1 = request1.getParameter("restopt_subject1");
		restopt_subject2 = request1.getParameter("restopt_subject2");
		restopt_subject3 = request1.getParameter("restopt_subject3");
		restopt_subject4 = request1.getParameter("restopt_subject4");
		restopt_subject5 = request1.getParameter("restopt_subject5");
		restopt_subject6 = request1.getParameter("restopt_subject6");
		restopt_subject7 = request1.getParameter("restopt_subject7");
		restopt_subject8 = request1.getParameter("restopt_subject8");
		restopt_subject9 = request1.getParameter("restopt_subject9");
		restopt_subject10 = request1.getParameter("restopt_subject10");
		restopt_subject11 = request1.getParameter("restopt_subject11");
		restopt_subject12 = request1.getParameter("restopt_subject12");
		restopt_subject13 = request1.getParameter("restopt_subject13");
		restopt_subject14 = request1.getParameter("restopt_subject14");
		restopt_subject15 = request1.getParameter("restopt_subject15");
		
		if(null==request1.getParameter("restopt_priceplus1")){
			restopt_priceplus1 = 0;
		}else{
			restopt_priceplus1 = Integer.parseInt(request1.getParameter("restopt_priceplus1"));
		}
		
		if(null==request1.getParameter("restopt_priceplus2")){
			restopt_priceplus2 = 0;
		}else{
			restopt_priceplus2 = Integer.parseInt(request1.getParameter("restopt_priceplus2"));
		}
		
		if(null==request1.getParameter("restopt_priceplus3")){
			restopt_priceplus3 = 0;
		}else{
			restopt_priceplus3 = Integer.parseInt(request1.getParameter("restopt_priceplus3"));
		}
		
		if(null==request1.getParameter("restopt_priceplus4")){
			restopt_priceplus4 = 0;
		}else{
			restopt_priceplus4 = Integer.parseInt(request1.getParameter("restopt_priceplus4"));
		}

		if(null==request1.getParameter("restopt_priceplus5")){
			restopt_priceplus5 = 0;
		}else{
			restopt_priceplus5 = Integer.parseInt(request1.getParameter("restopt_priceplus5"));
		}
		
		if(null==request1.getParameter("restopt_priceplus6")){
			restopt_priceplus6 = 0;
		}else{
			restopt_priceplus6 = Integer.parseInt(request1.getParameter("restopt_priceplus6"));
		}
		
		if(null==request1.getParameter("restopt_priceplus7")){
			restopt_priceplus7 = 0;
		}else{
			restopt_priceplus7 = Integer.parseInt(request1.getParameter("restopt_priceplus7"));
		}
		
		if(null==request1.getParameter("restopt_priceplus8")){
			restopt_priceplus8 = 0;
		}else{
			restopt_priceplus8 = Integer.parseInt(request1.getParameter("restopt_priceplus8"));
		}
		
		if(null==request1.getParameter("restopt_priceplus9")){
			restopt_priceplus9 = 0;
		}else{
			restopt_priceplus9 = Integer.parseInt(request1.getParameter("restopt_priceplus9"));
		}
		
		if(null==request1.getParameter("restopt_priceplus10")){
			restopt_priceplus10 = 0;
		}else{
			restopt_priceplus10 = Integer.parseInt(request1.getParameter("restopt_priceplus10"));
		}
		
		if(null==request1.getParameter("restopt_priceplus11")){
			restopt_priceplus11 = 0;
		}else{
			restopt_priceplus11 = Integer.parseInt(request1.getParameter("restopt_priceplus11"));
		}
		
		if(null==request1.getParameter("restopt_priceplus12")){
			restopt_priceplus12 = 0;
		}else{
			restopt_priceplus12 = Integer.parseInt(request1.getParameter("restopt_priceplus12"));
		}
		
		if(null==request1.getParameter("restopt_priceplus13")){
			restopt_priceplus13 = 0;
		}else{
			restopt_priceplus13 = Integer.parseInt(request1.getParameter("restopt_priceplus13"));
		}

		if(null==request1.getParameter("restopt_priceplus14")){
			restopt_priceplus14 = 0;
		}else{
			restopt_priceplus14 = Integer.parseInt(request1.getParameter("restopt_priceplus14"));
		}

		if(null==request1.getParameter("restopt_priceplus15")){
			restopt_priceplus15 = 0;
		}else{
			restopt_priceplus15 = Integer.parseInt(request1.getParameter("restopt_priceplus15"));
		}
		
		
		// num, rest_num, 옵션명, 옵션가 insert
									//  											//
		if(restopt_subject1 != null && restopt_priceplus1 != 0){
			
			paramClass1.setRestopt_rest_num(seq_num);
																						//
			paramClass1.setRestopt_subject(restopt_subject1);
			 																					//
			paramClass1.setRestopt_priceplus(restopt_priceplus1);
									
															//
			if(request.getFile("optupload1") != null){ 
																						//
				MultipartFile file = request.getFile("optupload1"); // 업로드된 원본
				String orgName = file.getOriginalFilename(); // 업로드되는 실제 파일 이름이다.
															//
				String saveName = "menu1_"+orgName;
																											
				File restopt_destFile1 = new File(optfileUploadPath+saveName); //이과정을 거치면 saveName의 복사 대상이 생김
				file.transferTo(restopt_destFile1);  // 위에서 만든 복사대상에 복사본을 만듬. (이걸로 복사 끝)
				
				//매인사진파일 DTO에 set
				paramClass1.setRestopt_destFile1(restopt_destFile1.getPath().replace('\\', '/').substring(26));
				paramClass1.setRestopt_orgname(orgName);
				paramClass1.setRestopt_savname(saveName);
			}
			sqlMapper.insert("Rest.insertRestopt", paramClass1);
		}
		
		
		
		//매인화면, 컨텐트 사진 업로드 및 DB등록
		if(request.getFile("upload1") != null && request.getFile("upload2") != null){
			//매인사진
			MultipartFile mainfile = request.getFile("upload1"); // 업로드된 원본
			orgName = mainfile.getOriginalFilename(); // 업로드되는 실제 파일 이름이다.
			saveName = "main_"+seq_num+"_"+orgName;//main_seq_org.ext
			
			File rest_destFile1 = new File(fileUploadPath1+saveName); //이과정을 거치면 saveName의 복사 대상이 생김
			mainfile.transferTo(rest_destFile1);  // 위에서 만든 복사대상에 복사본을 만듬. (이걸로 복사 끝)
			
			//컨텐트사진
			MultipartFile contentfile = request.getFile("upload2"); // 업로드된 원본
			orgName1 = contentfile.getOriginalFilename(); // 업로드되는 실제 파일 이름이다.
			saveName1 = "content_"+seq_num+"_"+orgName1;//content_seq_org.ext
			
			File rest_destFile2 = new File(fileUploadPath2+saveName1); //이과정을 거치면 saveName의 복사 대상이 생김
			contentfile.transferTo(rest_destFile2);  // 위에서 만든 복사대상에 복사본을 만듬. (이걸로 복사 끝)
			

			//글넘버
			paramClass.setRest_num(seq_num);
			//매인사진파일 DTO에 set
			paramClass.setRest_destFile1(rest_destFile1.getPath().replace('\\', '/').substring(26));
			paramClass.setRest_main_orgname(orgName);
			paramClass.setRest_main_savname(saveName);
			//컨텐트사진파일 DTO에 set
			paramClass.setRest_destFile2(rest_destFile2.getPath().replace('\\', '/').substring(26));
			paramClass.setRest_content_orgname(orgName1); 
			paramClass.setRest_content_savname(saveName1);

			//파일 정보 업데이트.
			sqlMapper.update("Rest.updateFile", paramClass);
		}
		
		//setAttribute 하기
		
		
		return "/view/rest/listRest.jsp"; //이전버전 리다이렉트 액션썻음
	}
}
