class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, except: [:new, :index, :create]

  def index
    @category = Category.new
    @categories = Category.all
  end

  def show
    @tours = @category.tours
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created!"
      redirect_to admin_categories_url
    else
      flash.now[:danger] = "Create failed!"
      @categories = Category.all
      render "admin/categories/index"
    end
  end

  def edit
    @categories = Category.all
    render "admin/categories/index"  
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated!"
      redirect_to admin_categories_url
    else
      flash.now[:danger] = "Update failed!"
      @categories = Category.all
      render "admin/categories/index"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category deleted!"
    redirect_to admin_categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name, :area)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end