class Admin::CategoriesController < Admin::BaseController
  layout "admin"
  before_action :set_category, except: [:new, :index, :create]

  def new
    @category = Category.new
  end

  def index
    @category = Category.new
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @tours = @category.tours
    @images = @category.images
    @image = Image.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created!"
      redirect_to admin_category_url(@category)
    else
      flash.now[:danger] = "Create failed!"
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated!"
      redirect_to admin_category_url(@category)
    else
      flash.now[:danger] = "Update failed!"
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category deleted!"
    redirect_to admin_categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name, :area, :overview, images_attributes: [:id, :link])
  end

  def set_category
    @category = Category.find(params[:id])
  end
end