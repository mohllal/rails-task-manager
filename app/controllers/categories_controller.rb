# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.sorted
    logger.info("CategoriesController#index - User: #{current_user.id}, Categories: #{@categories.map(&:id)}")
  end

  def show
    category_id = params[:id]
    @category = current_user.categories.find_by(id: category_id)

    if @category
      logger.debug("CategoriesController#show - User: #{current_user.id}, Category: #{@category.id}")
    else
      logger.warn("CategoriesController#show - User: #{current_user.id}, Category not found: #{category_id}")
      redirect_to categories_path, alert: 'Category not found'
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params.merge(user_id: current_user.id))

    if @category.save
      logger.info("CategoriesController#create - Category created: #{@category.id}")
      redirect_to categories_path
    else
      logger.error("CategoriesController#create - Failed to create category: #{category_params}")
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
      logger.info("CategoriesController#update - Category updated: #{@category.id}")
      redirect_to category_path(@category)
    else
      logger.error("CategoriesController#update - Failed to update category: #{category_params}")
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
