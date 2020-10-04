class CreateBooking
  attr_reader :tour, :user, :booking_params, :coupon_code, :booking_tour_id

  def initialize(tour, user, booking_params, coupon_code, booking_tour_id) 
    @user = user
    @booking_params = booking_params
    @tour = tour
    @coupon_code = coupon_code
    @booking_tour_id = booking_tour_id
  end

  def perform
    booking_tour = user.booking_tours.build(booking_params)
    set_price_tour(booking_tour)
    price = (booking_params[:quantity].to_i * tour.price * (1 - tour.coupon / 100.to_f))
    price += HotelTour.get_by_hotel_id(booking_params[:option].to_i).get_by_tour_id(tour.id)[0].extra_fee * booking_tour.quantity if booking_params[:option].present?
    if coupon_code.present?
      coupons_get = Coupon.get_coupon_for_user(user.id).or(Coupon.get_coupon_for_all)
      coupons = coupons_get.reject{|coupon| coupon.coupon_use_count == CouponUser.where(coupon_id: coupon.id)&.count}
      coupon = coupons.select{|coupon| coupon.name == coupon_code}.first      
      if coupon.present?
        booking_tour.price_total =
          if coupon.percent? 
            price * (100 - coupon.coupon_amount)/100
          else
            price - coupon.coupon_amount
          end
        if booking_tour.save
          CouponUser.create(user_id: user.id, coupon_id: coupon.id, booking_tour_id: booking_tour.id)
          success_response("Booking success! Thank you for your booking!", {booking_tour: booking_tour})
        else
          error_response("Your booking is failed!", {booking_tour: booking_tour})
        end
      else
        error_response("Code Invalid!", {booking_tour: booking_tour})
      end
    else
      booking_tour.price_total = price
      if booking_tour.save
        success_response("Booking success! Thank you for your booking!", {booking_tour: booking_tour})
      else
        error_response("Your booking is failed!", {booking_tour: booking_tour})
      end
    end
  end

  def update
    booking_tour = BookingTour.find(booking_tour_id)
    CouponUser.find_by(booking_tour_id: booking_tour.id)&.destroy
    set_price_tour(booking_tour)
    price = (booking_params[:quantity].to_i * tour.price * (1 - tour.coupon / 100.to_f))
    price += HotelTour.get_by_hotel_id(booking_params[:option].to_i).get_by_tour_id(tour.id)[0].extra_fee * booking_params[:quantity].to_i if booking_params[:option].present?
    if coupon_code.present?
      coupons_get = Coupon.get_coupon_for_user(user.id).or(Coupon.get_coupon_for_all)
      coupons = coupons_get.reject{|coupon| coupon.coupon_use_count == CouponUser.where(coupon_id: coupon.id)&.count}
      coupon = coupons.select{|coupon| coupon.name == coupon_code}.first      
      if coupon.present?
        booking_tour.price_total =
          if coupon.percent? 
            price * (100 - coupon.coupon_amount)/100
          else
            price - coupon.coupon_amount
          end
        if booking_tour.update(booking_params)
          CouponUser.create(user_id: user.id, coupon_id: coupon.id)
          success_response("Booking updated! Thank you for your booking!", {booking_tour: booking_tour})
        else
          error_response("Updating your booking is failed!", {booking_tour: booking_tour})
        end
      else
        error_response("Code Invalid!", {booking_tour: booking_tour})
      end
    else
      booking_tour.price_total = price
      if booking_tour.update(booking_params)
        success_response("Booking updated! Thank you for your booking!", {booking_tour: booking_tour})
      else
        error_response("Updating your booking is failed!", {booking_tour: booking_tour})
      end
    end
  end

  private

  def set_price_tour(booking_tour)
    booking_tour.price = tour.price
    booking_tour.coupon = tour.coupon
  end

  def success_response(message, data = {})
    {success: true, message: message, data: data}
  end

  def error_response(message, data = {})
    {success: false, message: message, data: data}
  end
end
