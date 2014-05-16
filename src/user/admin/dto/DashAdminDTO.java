package user.admin.dto;

import java.util.ArrayList;
import java.util.List;

import user.buyer.dto.BuyerDTO;
import user.seller.dto.SellerDTO;

public class DashAdminDTO {
	
	private int countRest;
	private int countRestOpt;
	private int countPaid;
	private int countReview;
	
	private int countRecipe;
	private int countNotice;
	private int countQna;
	
	private int countBuyer;
	private int countSeller;
	
	private List<BuyerDTO> listBuyer = new ArrayList<BuyerDTO>();
	private List<SellerDTO> listSeller = new ArrayList<SellerDTO>();
	
	public int getCountRest() {
		return countRest;
	}
	public void setCountRest(int countRest) {
		this.countRest = countRest;
	}
	public int getCountRestOpt() {
		return countRestOpt;
	}
	public void setCountRestOpt(int countRestOpt) {
		this.countRestOpt = countRestOpt;
	}
	public int getCountPaid() {
		return countPaid;
	}
	public void setCountPaid(int countPaid) {
		this.countPaid = countPaid;
	}
	public int getCountReview() {
		return countReview;
	}
	public void setCountReview(int countReview) {
		this.countReview = countReview;
	}
	public int getCountRecipe() {
		return countRecipe;
	}
	public void setCountRecipe(int countRecipe) {
		this.countRecipe = countRecipe;
	}
	public int getCountNotice() {
		return countNotice;
	}
	public void setCountNotice(int countNotice) {
		this.countNotice = countNotice;
	}
	public int getCountQna() {
		return countQna;
	}
	public void setCountQna(int countQna) {
		this.countQna = countQna;
	}
	public int getCountBuyer() {
		return countBuyer;
	}
	public void setCountBuyer(int countBuyer) {
		this.countBuyer = countBuyer;
	}
	public int getCountSeller() {
		return countSeller;
	}
	public void setCountSeller(int countSeller) {
		this.countSeller = countSeller;
	}
	public List<BuyerDTO> getListBuyer() {
		return listBuyer;
	}
	public void setListBuyer(List<BuyerDTO> listBuyer) {
		this.listBuyer = listBuyer;
	}
	public List<SellerDTO> getListSeller() {
		return listSeller;
	}
	public void setListSeller(List<SellerDTO> listSeller) {
		this.listSeller = listSeller;
	}
	
}
