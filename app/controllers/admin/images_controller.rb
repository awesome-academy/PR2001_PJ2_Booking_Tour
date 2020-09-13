# frozen_string_literal: true

class Admin::ImagesController < Admin::BaseController
  before_action :set_tour

  def create
    respond_to do |format|
      if params[:images]
        begin
          ActiveRecord::Base.transaction do
            params[:images][:link].each do |image|
              @image = Image.new(tour_id: @tour.id, link: image)
              @image.save!
            end
          end
          format.html do
            flash[:success] = 'Upload is success!'
            redirect_to admin_tour_path(@tour)
          end
          format.js
        end     
      else
        @image = @tour.images.build
        @image.valid?
        format.html do
          @images = @tour.images.reject{ |a| a.id == nil }
          @tour_detail = TourDetail.new
          @tour_details = @tour.tour_details
          flash.now[:danger] = 'Upload is failed!'
          render "admin/tours/show"
        end
        format.js
      end
      rescue ActiveRecord::RecordInvalid
        format.html do
          @images = @tour.images.reject{ |a| a.id == nil }
          @tour_detail = TourDetail.new
          @tour_details = @tour.tour_details
          flash.now[:danger] = 'Upload is failed!'
          render "admin/tours/show"
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
        redirect_to admin_tour_path(@tour)
      end
      format.js
    end
  end

  private

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end
end
