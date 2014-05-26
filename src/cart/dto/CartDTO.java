package cart.dto;

public class CartDTO {
	
	private int cart_num;
	private int cart_rest_num;
	private String cart_rest_subject;
	private int cart_restopt_num;
	private String cart_restopt_destFile1;
	private String cart_restopt_subject;
	private int cart_restopt_priceplus;
	private String session_id;
	private int cart_amount;
	private int cart_ischeck;

	public int getCart_ischeck() {
		return cart_ischeck;
	}

	public void setCart_ischeck(int cart_ischeck) {
		this.cart_ischeck = cart_ischeck;
	}

	public int getCart_restopt_num() {
		return cart_restopt_num;
	}

	public void setCart_restopt_num(int cart_restopt_num) {
		this.cart_restopt_num = cart_restopt_num;
	}

	public int getCart_num() {
		return cart_num;
	}

	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}

	public int getCart_rest_num() {
		return cart_rest_num;
	}

	public void setCart_rest_num(int cart_rest_num) {
		this.cart_rest_num = cart_rest_num;
	}

	public String getCart_rest_subject() {
		return cart_rest_subject;
	}

	public void setCart_rest_subject(String cart_rest_subject) {
		this.cart_rest_subject = cart_rest_subject;
	}

	public String getCart_restopt_destFile1() {
		return cart_restopt_destFile1;
	}

	public void setCart_restopt_destFile1(String cart_restopt_destFile1) {
		this.cart_restopt_destFile1 = cart_restopt_destFile1;
	}

	public String getCart_restopt_subject() {
		return cart_restopt_subject;
	}

	public void setCart_restopt_subject(String cart_restopt_subject) {
		this.cart_restopt_subject = cart_restopt_subject;
	}

	public int getCart_restopt_priceplus() {
		return cart_restopt_priceplus;
	}

	public void setCart_restopt_priceplus(int cart_restopt_priceplus) {
		this.cart_restopt_priceplus = cart_restopt_priceplus;
	}

	public String getSession_id() {
		return session_id;
	}

	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}

	public int getCart_amount() {
		return cart_amount;
	}

	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	
}
