class RecipesController < ApplicationController
  def create
    if not user_signed_in? 
      redirect_to "/"
    end
    @user = current_user
    @recipe = @user.recipes.build(post_params)
    @recipe.save
    
    redirect_to "/recipes"
  end

  def new
    if not user_signed_in? 
      redirect_to "/"
    end
  end

  def edit
     if not user_signed_in? 
      redirect_to "/"
     end
     
     recipe_id = params["id"]
     @recipe = Recipe.find(recipe_id)
     
     if @recipe.user_id != current_user.id
       redirect_to "/"
     end
  end

  def show
    @recipes = Recipe.all()
  end

  def update
     if not user_signed_in? 
      redirect_to "/"
    end
    
    recipe_id = params["id"]
    
    @recipe = Recipe.find(params[:id])
    
    if @recipe.user_id != current_user.id
      redirect_to "/"
    end
    
    @recipe.update(params[:recipe].permit(:name, :estimated_time, :ingredients, :notes, :instructions))
    
    redirect_to recipe_show_path
  end

  def destroy
     if not user_signed_in? 
      redirect_to "/"
    end
    
    recipe_id = params["id"]
    @recipe = Recipe.find(recipe_id)
     
     if @recipe.user_id != current_user.id
       redirect_to "/"
     end
    Recipe.destroy(recipe_id)
    
    redirect_to "/recipes"
  end
  
  def read
    recipe_id = params["id"]
    @recipe = Recipe.find(recipe_id)
  end
  
  private
    def post_params
      params.require(:recipe).permit(:name, :estimated_time, :ingredients, :notes, :instructions)
    end
end
