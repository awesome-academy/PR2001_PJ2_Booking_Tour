class Admin::Hotels::ImagesController < Admin::HotelsController
  before_action :set_hotel

  def create
    respond_to do |format|
      if params[:images]
        begin
          ActiveRecord::Base.transaction do
            params[:images][:link].each do |image|
              @image = Image.new(imageable_id: @hotel.id, imageable_type: "Hotel" , link: image)
              @image.save!
            end
          end
          format.html do
            flash[:success] = 'Upload is success!'
            redirect_to admin_hotel_path(@hotel)
          end
          format.js
        end     
      else
        @image = @hotel.images.build
        @image.valid?
        format.html do
          @images = @hotel.images.reject{ |a| a.id == nil }
          flash.now[:danger] = 'Upload is failed!'
          render "admin/hotels/show"
        end
        format.js
      end
      rescue ActiveRecord::RecordInvalid
        format.html do
          @images = @hotel.images.reject{ |a| a.id == nil }
          flash.now[:danger] = 'Upload is failed!'
          render "admin/hotels/show"
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
        redirect_to admin_hotel_path(@hotel)
      end
      format.js
    end
  end

  private
  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end
end
