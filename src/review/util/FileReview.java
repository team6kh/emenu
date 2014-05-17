package review.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileReview
{
    
    // 아래 변수들은 메서드를 호출할 때 필요한 값들입니다.
    
    // 두 메서드에 공통으로 필요한 변수
    private String fileUploadPath; // 파일 저장할 경로
    
    // uploadFiles 메서드(파일을 서버에 저장할 때)를 위해 필요한 변수
    private List<MultipartFile> files = new ArrayList<MultipartFile>(); // 첨부파일들
    
    private String fileRename; // 서버에 저장할 파일명 규칙 ex) review_0
    
    private String saveFileName; // 리턴값(서버에 저장된 파일명들을 연결한 값)을 저장할 변수 ex)
                                 // review_0_0.jpg review_0_1.png
    
    // deleteFiles 메서드(파일을 서버에서 삭제할 때)를 위해 필요한 변수
    private String filesName; // 삭제할 파일명들(서버에 저장된 파일명)
    
    // 첨부파일을 업로드하는 메서드
    // 파일을 업로드경로에 저장하고, 변경한 파일명들을 " "(구분자)로 연결한 String 타입의 값으로 리턴
    public String uploadFiles(List<MultipartFile> files, String fileUploadPath,
            String fileRename) throws Exception
    {
        
        // 각 파일명을 연결할 때, 앞에 null 이 들어가지 않도록 "" 으로 초기화
        saveFileName = "";
        
        // 각 파일을 순차적으로 꺼내는 반복문
        for (int i = 0; i < files.size(); i++)
        {
            if (!files.get(i).isEmpty())
            {
                String fileName = files.get(i).getOriginalFilename();
                
                // 파일의 확장자 알아내기
                String fileExt = fileName
                        .substring(fileName.lastIndexOf('.') + 1,
                                   fileName.length());
                
                // 파일명 변경
                fileName = fileRename + "_" + i;
                
                // 새로운 파일 객체를 생성(복사 받을 대상)
                File destFile = new File(fileUploadPath + fileName + "."
                        + fileExt);
                
                // get(i)로 업로드한 파일을 순차적으로 가져와서 destFile객체에 저장한다.
                // 즉 destFile객체에 파일을 복사해준다. (지정된 경로로 파일 저장)
                files.get(i).transferTo(destFile);
                
                // DB 테이블에 저장하기 위해 변경한 파일이름들을 연결
                saveFileName += fileName + "." + fileExt + " ";
            }
        }
        return saveFileName;
    }
    
    // 저장된 파일을 삭제하는 메서드
    public void deleteFiles(String filesName, String fileUploadPath)
    {
        
        // 구분자 "공백"으로 각각의 파일명들 분리
        String[] fileName = filesName.split(" ");
        
        // 반복문을 이용하여 파일명을 순차적으로 꺼낸다.
        for (int i = 0; i < fileName.length; i++)
        {
            
            // 파일 저장 경로와 파일이름을 이용하여 새로운 파일 객체를 만들고
            File deleteFile = new File(fileUploadPath + fileName[i]);
            // 파일을 삭제한다.
            deleteFile.delete();
        }
    }
}
