package common.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import user.buyer.dto.BuyerDTO;
import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.dto.ModalParamDTO;

@Controller
public class CheckPass {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public CheckPass() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/checkPass.do")
	public String checkPass(HttpServletRequest request, @ModelAttribute ModalParamDTO mp) throws SQLException {
		
		// 구매자 정보 수정/탈퇴
		if (mp.getModalParam_id().equals("updateBuyerForm") || mp.getModalParam_id().equals("deleteBuyer")) {
			
			BuyerDTO buyerDTO = new BuyerDTO();
			buyerDTO.setBuyer_id(mp.getModalParam_key());
			buyerDTO.setBuyer_pw(mp.getModalParam_pass());
			
			buyerDTO = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerPw", buyerDTO);
			
			if (buyerDTO != null) {
				
				// 여기서 설정하는 게 맞는 건가?
				request.setAttribute("buyerDTO", buyerDTO);
				
				if (mp.getModalParam_id().equals("updateBuyerForm")) {					
					return "/user/buyer/update/form.do";
				} else if (mp.getModalParam_id().equals("deleteBuyer")) {
					return "/user/buyer/delete.do";
				}				
			} 
			
		// 판매자 정보 수정/탈퇴
		} else if (mp.getModalParam_id().equals("updateSellerForm") || mp.getModalParam_id().equals("deleteSeller")) {
			
			//System.out.println("판매자 정보 수정/탈퇴");
			//System.out.println(mp.getModalParam_key());
			//System.out.println(mp.getModalParam_pass());
			
			SellerDTO sellerDTO = new SellerDTO();
			sellerDTO.setSeller_id(mp.getModalParam_key());
			sellerDTO.setSeller_pw(mp.getModalParam_pass());
			
			sellerDTO = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerPw", sellerDTO);
			
			if (sellerDTO != null) {
				
				request.setAttribute("sellerDTO", sellerDTO);
				
				if (mp.getModalParam_id().equals("updateSellerForm")) {
					return "/user/seller/update/form.do";
				} else if (mp.getModalParam_id().equals("deleteSeller")) {
					return "/user/seller/delete.do";
				}
			}
		}
		
		return "redirect:/error.do";
		
	}	
}
