class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category_id = params[:id]
    @category = Category.find(category_id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render('new')
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
    params.require(:category).permit(:name)
  end
end
