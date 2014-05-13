package recipe.dto;

public class RecipeCommandDTO {
	
	private int recipeCommand_num;
	private String recipeCommand_writer;
	private String recipeReadCount_writer;
	
	public int getRecipeCommand_num() {
		return recipeCommand_num;
	}
	public void setRecipeCommand_num(int recipeCommand_num) {
		this.recipeCommand_num = recipeCommand_num;
	}
	public String getRecipeCommand_writer() {
		return recipeCommand_writer;
	}
	public void setRecipeCommand_writer(String recipeCommand_writer) {
		this.recipeCommand_writer = recipeCommand_writer;
	}
	public String getRecipeReadCount_writer() {
		return recipeReadCount_writer;
	}
	public void setRecipeReadCount_writer(String recipeReadCount_writer) {
		this.recipeReadCount_writer = recipeReadCount_writer;
	}

}
