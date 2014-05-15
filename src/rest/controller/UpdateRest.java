package rest.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import rest.dto.RestDTO;
import restopt.dto.RestOptDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.Constants;

@Controller
public class UpdateRest {
	//updateForm관련
	private List<RestOptDTO> list = new ArrayList<RestOptDTO>();
	private RestDTO resultClass = new RestDTO();
	
	//update관련
	private RestDTO paramClass = new RestDTO();
	private RestOptDTO paramClass1 = new RestOptDTO();
	//매인사진
	private String orgName;
	private String saveName;
	private String fileUploadPath1 = Constants.COMMON_FILE_PATH + Constants.REST_MAIN_FILE_PATH;
	//컨텐트사진
	private String orgName1;
	private String saveName1;	
	private String fileUploadPath2 = Constants.COMMON_FILE_PATH + Constants.REST_CONTENT_FILE_PATH;
	//옵션사진
	private String optfileUploadPath = Constants.COMMON_FILE_PATH + Constants.REST_MENU_FILE_PATH;
	//옵션명
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
	//옵션가
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
		
		
	//updateRestForm.do
	@RequestMapping("/updateRestForm.do")
	public String updateRestForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		//수정에 뿌려줄 레코드1개 select
		resultClass = (RestDTO)sqlMapper.queryForObject("Rest.selectRestOne", rest_num);
		//옵션에 뿌려줄 레코드들 select
		list = (List<RestOptDTO>) sqlMapper.queryForList("Rest.selectRestoptOne", rest_num);
	
		request.setAttribute("rest_num", rest_num);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("list", list);
		request.setAttribute("resultClass", resultClass);
		
		return "/view/rest/updateRest.jsp";
	}
	
	
	
	//updateRest.do
	@RequestMapping(value="/updateRest.do",method=RequestMethod.POST)
	public String updateRest(MultipartHttpServletRequest request, HttpServletRequest request1, HttpServletResponse response1, HttpSession session) throws Exception{
		
		int rest_num = Integer.parseInt(request1.getParameter("rest_num"));
		int currentPage = Integer.parseInt(request1.getParameter("currentPage"));
		
		String rest_subject = request1.getParameter("rest_subject");
		String rest_localcategory = request1.getParameter("rest_localcategory");
		String rest_typecategory = request1.getParameter("rest_typecategory");
		
		//1. 상품글 업데이트 시작
		//상품글 일반항목 업데이트
		paramClass.setRest_num(rest_num);
		paramClass.setRest_subject(rest_subject);
		paramClass.setRest_localcategory(rest_localcategory);
		paramClass.setRest_typecategory(rest_typecategory);
		sqlMapper.update("Rest.updateRestone", paramClass);
		
		//상품글 파일 업데이트
		//매인화면, 컨텐트 사진 업로드 및 DB등록
		System.out.println("null떠야 정상인데.. : "+request.getFile("upload1"));
		if(request.getFile("upload1") != null && request.getFile("upload2") != null){
			System.out.println("여기에 들어오면 안됨!!");
			//매인사진
			MultipartFile mainfile = request.getFile("upload1"); // 업로드된 원본
			orgName = mainfile.getOriginalFilename(); // 업로드되는 실제 파일 이름이다.
			saveName = "main_"+rest_num+"_"+orgName;//main_seq_org.ext
			
			File rest_destFile1 = new File(fileUploadPath1+saveName); //이과정을 거치면 saveName의 복사 대상이 생김
			mainfile.transferTo(rest_destFile1);  // 위에서 만든 복사대상에 복사본을 만듬. (이걸로 복사 끝)
			
			//컨텐트사진
			MultipartFile contentfile = request.getFile("upload2"); // 업로드된 원본
			orgName1 = contentfile.getOriginalFilename(); // 업로드되는 실제 파일 이름이다.
			saveName1 = "content_"+rest_num+"_"+orgName1;//content_seq_org.ext
			
			File rest_destFile2 = new File(fileUploadPath2+saveName1); //이과정을 거치면 saveName의 복사 대상이 생김
			contentfile.transferTo(rest_destFile2);  // 위에서 만든 복사대상에 복사본을 만듬. (이걸로 복사 끝)

			//글넘버
			paramClass.setRest_num(rest_num);
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
		//상품글 업데이트 완료
		
		

		
		//2. 옵션글 업데이트 시작
		//업데이트 전 기존옵션을 불러옴
		list = (List<RestOptDTO>) sqlMapper.queryForList("Rest.selectRestoptOne", rest_num);
		int listsize = list.size(); //기존 옵션의 개수 (index 0 to size)
		
		//옵션사진 삭제용
		//FileUpload fileUpload = new FileUpload();
		
		//옵션명 변수초기화
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
		
		//옵션가 변수초기화
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
		
		
		//2.1
		//수정시, 사용자가 옵션을 감소했을 경우
		//옵션 감소시 제거 유지 및 추가시 레코드 유지.
		
		//이전 옵션의 개수 이내의 인덱스를 판단.
		if(0<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject1 != null && restopt_priceplus1 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(0).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(0).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(1<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject2 != null && restopt_priceplus2 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(1).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(1).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(2<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject3 != null && restopt_priceplus3 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(2).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(2).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(3<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject4 != null && restopt_priceplus4 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(3).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(3).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(4<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject5 != null && restopt_priceplus5 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(4).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(4).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(5<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject6 != null && restopt_priceplus6 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(5).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(5).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(6<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject7 != null && restopt_priceplus7 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(6).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(6).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(7<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject8 != null && restopt_priceplus8 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(7).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(7).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(8<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject9 != null && restopt_priceplus9 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(8).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(8).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(9<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject10 != null && restopt_priceplus10 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(9).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(9).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(10<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject11 != null && restopt_priceplus11 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(10).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(10).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(11<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject12 != null && restopt_priceplus12 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(11).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(11).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(12<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject13 != null && restopt_priceplus13 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(12).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(12).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(13<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject14 != null && restopt_priceplus14 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(13).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(13).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		if(14<listsize){
			//사용자가 입력한 옵션이 없으면, 
			if(restopt_subject15 != null && restopt_priceplus15 != 0){
				paramClass1.setRestopt_rest_num(rest_num);
				//수정시에 사용자가 옵션을 감소시킨것으로 판단
				//즉, 있을 필요가 없는 레코드이니 해당 레코드 삭제처리
				if(list.get(14).getRestopt_subject() != null){
					paramClass1.setRestopt_subject(list.get(14).getRestopt_subject());
					sqlMapper.delete("Rest.deleteRestoptOne", paramClass1);
				}
			}
		}
		
		//2.2
		//사용자가 옵션을 수정했을 경우 레코드 update
		//else// 사용자가 옵션을 추가했을 경우 insert
		
		if(restopt_subject1 != null && restopt_priceplus1 != 0){
			paramClass1.setRestopt_rest_num(rest_num);
			paramClass1.setRestopt_subject(restopt_subject1);
			paramClass1.setRestopt_priceplus(restopt_priceplus1);
			
			//수정시에 파일 업로드 했을경우를 판단
			if(request.getFile("optupload1") != null){ 
				if(0<listsize){//기존파일 삭제를 위해 레코드를 인덱스 단위로 판단
					if (list.get(0).getRestopt_savname() != null) {
						String filesName = list.get(0).getRestopt_savname(); //기존 파일명을 가져옴
						//fileUpload.deleteFiles(filesName, optfileUploadPath1); //해당경로, 기존파일명을 삭제함.
					}
				}
				//새롭게 업로드된 것 저장
				//옵션 사진 파일 이름과 확장자 설정.
				MultipartFile file = request.getFile("optupload1"); // 업로드된 원본
				String orgName = file.getOriginalFilename(); // 업로드되는 실제 파일 이름이다.
				String saveName = "menu1_" + orgName+Integer.toString((int)(Math.random() * 999999));
																											
				File restopt_destFile1 = new File(optfileUploadPath+saveName); //이과정을 거치면 saveName의 복사 대상이 생김
				file.transferTo(restopt_destFile1);  // 위에서 만든 복사대상에 복사본을 만듬. (이걸로 복사 끝)
				
				//매인사진파일 DTO에 set
				paramClass1.setRestopt_destFile1(restopt_destFile1.getPath().replace('\\', '/').substring(26));
				paramClass1.setRestopt_orgname(orgName);
				paramClass1.setRestopt_savname(saveName);
			}else{//수정시에 파일 업로드 하지 않았을 경우
				if(0<listsize){
					paramClass1.setRestopt_destFile1(list.get(0).getRestopt_destFile1());
					paramClass1.setRestopt_orgname(list.get(0).getRestopt_orgname());
					paramClass1.setRestopt_savname(list.get(0).getRestopt_savname());
				}
			}
			if(0<listsize){ 
				// 기존 옵션레코드가 있었을 경우 update
				if(list.get(0).getRestopt_num() != 0){
					sqlMapper.update("Rest.updateRestopt", paramClass1);
				}
			}else{ //옵션을 새로 추가하가한 경우 insert
				sqlMapper.insert("Rest.insertRestopt", paramClass1);
			}
			
		}
			
		
		
		return "redirect:readRest.do?rest_num="+rest_num+"&currentPage="+currentPage;
	}
}
