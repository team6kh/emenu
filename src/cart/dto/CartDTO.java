package cart.dto;

public class CartDTO {
	
	int cart_num;
	int cart_rest_num;
	String cart_rest_subject;
	int cart_restopt_num;
	String cart_restopt_destFile1;
	String cart_restopt_subject;
	int cart_restopt_priceplus;
	String session_id;

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
	
}
