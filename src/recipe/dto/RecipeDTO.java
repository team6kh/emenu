package recipe.dto;

import java.util.Date;

public class RecipeDTO {
	
	private int recipe_num;
	private String recipe_foodkind;
	private String recipe_subject;
	private String recipe_foodsubject;
	private String recipe_method;
	private int recipe_time;
	private int recipe_price;
	private String recipe_memberwriter;
	private String recipe_writer;
	private String recipe_password;
	private String recipe_content;
	private String recipe_orgfile;
	private String recipe_file;
	private int recipe_readcount;
	private int recipe_recommend;
	private Date recipe_reg_date;

	public int getRecipe_num() {
		return recipe_num;
	}

	public void setRecipe_num(int recipe_num) {
		this.recipe_num = recipe_num;
	}

	public String getRecipe_foodkind() {
		return recipe_foodkind;
	}

	public void setRecipe_foodkind(String recipe_foodkind) {
		this.recipe_foodkind = recipe_foodkind;
	}

	public String getRecipe_subject() {
		return recipe_subject;
	}

	public void setRecipe_subject(String recipe_subject) {
		this.recipe_subject = recipe_subject;
	}

	public String getRecipe_foodsubject() {
		return recipe_foodsubject;
	}

	public void setRecipe_foodsubject(String recipe_foodsubject) {
		this.recipe_foodsubject = recipe_foodsubject;
	}

	public String getRecipe_method() {
		return recipe_method;
	}

	public void setRecipe_method(String recipe_method) {
		this.recipe_method = recipe_method;
	}

	public int getRecipe_time() {
		return recipe_time;
	}

	public void setRecipe_time(int recipe_time) {
		this.recipe_time = recipe_time;
	}

	public int getRecipe_price() {
		return recipe_price;
	}

	public void setRecipe_price(int recipe_price) {
		this.recipe_price = recipe_price;
	}

	public String getRecipe_memberwriter() {
		return recipe_memberwriter;
	}

	public void setRecipe_memberwriter(String recipe_memberwriter) {
		this.recipe_memberwriter = recipe_memberwriter;
	}

	public String getRecipe_writer() {
		return recipe_writer;
	}

	public void setRecipe_writer(String recipe_writer) {
		this.recipe_writer = recipe_writer;
	}

	public String getRecipe_password() {
		return recipe_password;
	}

	public void setRecipe_password(String recipe_password) {
		this.recipe_password = recipe_password;
	}

	public String getRecipe_content() {
		return recipe_content;
	}

	public void setRecipe_content(String recipe_content) {
		this.recipe_content = recipe_content;
	}

	public String getRecipe_orgfile() {
		return recipe_orgfile;
	}

	public void setRecipe_orgfile(String recipe_orgfile) {
		this.recipe_orgfile = recipe_orgfile;
	}

	public String getRecipe_file() {
		return recipe_file;
	}

	public void setRecipe_file(String recipe_file) {
		this.recipe_file = recipe_file;
	}

	public int getRecipe_recommend() {
		return recipe_recommend;
	}

	public void setRecipe_recommend(int recipe_recommend) {
		this.recipe_recommend = recipe_recommend;
	}

	public Date getRecipe_reg_date() {
		return recipe_reg_date;
	}

	public void setRecipe_reg_date(Date recipe_reg_date) {
		this.recipe_reg_date = recipe_reg_date;
	}

	public int getRecipe_readcount() {
		return recipe_readcount;
	}

	public void setRecipe_readcount(int recipe_readcount) {
		this.recipe_readcount = recipe_readcount;
	}

}