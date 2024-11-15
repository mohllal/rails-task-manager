class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.sorted
  end

  def show
    category_id = params[:id]
    @category = current_user.categories.find_by(id: category_id)
    redirect_to categories_path, alert: 'Category not found' unless @category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params.merge(user_id: current_user.id))

    if @category.save
      redirect_to categories_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    category_id = params[:id]
    @category = Category.find(category_id)
  end

  def update
    category_id = params[:id]
    @category = Category.find(category_id)

    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      render('edit')
    end
  end

  def delete
    category_id = params[:id]
    @category = Category.find(category_id)
  end

  def destroy
    category_id = params[:id]
    @category = Category.find(category_id)
    @category.destroy
    redirect_to categories_path
  end

private

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
