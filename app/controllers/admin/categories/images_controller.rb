class Admin::Categories::ImagesController < Admin::CategoriesController
  before_action :set_category

  def create
    respond_to do |format|
      if params[:images]
        begin
          ActiveRecord::Base.transaction do
            params[:images][:link].each do |image|
              @image = Image.new(imageable_id: @category.id, imageable_type: "Category" , link: image)
              @image.save!
            end
          end
          format.html do
            flash[:success] = 'Upload is success!'
            redirect_to admin_category_path(@category)
          end
          format.js
        end     
      else
        @image = @category.images.build
        @image.valid?
        format.html do
          @images = @category.images.reject{ |a| a.id == nil }
          flash.now[:danger] = 'Upload is failed!'
          render "admin/categories/show"
        end
        format.js
      end
      rescue ActiveRecord::RecordInvalid
        format.html do
          @images = @category.images.reject{ |a| a.id == nil }
          flash.now[:danger] = 'Upload is failed!'
          render "admin/categories/show"
        end
        format.js
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Your image is deleted!'
        redirect_to admin_category_path(@category)
      end
      format.js
    end
  end

  private
  def set_category
    @category = Category.find(params[:category_id])
  end
end
