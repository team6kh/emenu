package restopt.dto;

public class RestOptDTO {

    private int restopt_num; //옵션 시퀀스
    private int restopt_rest_num; //rest테이블의 시퀀스넘
    private String restopt_subject; //옵션명
    private int restopt_priceplus; //옵션가
    private int restopt_amount; //옵션 수량
    private String restopt_destFile1; //옵션의 사진 경로 // jsp의 img src 태그사용 용도
    private String restopt_orgname; //옵션 사진 파일 오리지날
    private String restopt_savname; //옵션 사진 파일 세이브

    public int getRestopt_amount() {
        return restopt_amount;
    }
    public void setRestopt_amount(int restopt_amount) {
        this.restopt_amount = restopt_amount;
    }
    public int getRestopt_num() {
        return restopt_num;
    }
    public void setRestopt_num(int restopt_num) {
        this.restopt_num = restopt_num;
    }
    public int getRestopt_rest_num() {
        return restopt_rest_num;
    }
    public void setRestopt_rest_num(int restopt_rest_num) {
        this.restopt_rest_num = restopt_rest_num;
    }
    public String getRestopt_subject() {
        return restopt_subject;
    }
    public void setRestopt_subject(String restopt_subject) {
        this.restopt_subject = restopt_subject;
    }
    public int getRestopt_priceplus() {
        return restopt_priceplus;
    }
    public void setRestopt_priceplus(int restopt_priceplus) {
        this.restopt_priceplus = restopt_priceplus;
    }
    public String getRestopt_destFile1() {
        return restopt_destFile1;
    }
    public void setRestopt_destFile1(String restopt_destFile1) {
        this.restopt_destFile1 = restopt_destFile1;
    }
    public String getRestopt_orgname() {
        return restopt_orgname;
    }
    public void setRestopt_orgname(String restopt_orgname) {
        this.restopt_orgname = restopt_orgname;
    }
    public String getRestopt_savname() {
        return restopt_savname;
    }
    public void setRestopt_savname(String restopt_savname) {
        this.restopt_savname = restopt_savname;
    }

}