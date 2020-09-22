class Admin::CampaignsController < Admin::BaseController
  def index
    @campaigns = Campaign.all
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      Coupon.create(name: "#{@campaign.name}#{@campaign.id}", coupon_type: @campaign.sale_type,
                  coupon_target_type: "all_users", coupon_amount: @campaign.amount, coupon_use_count: @campaign.numbers_of_use,
                  date_start: @campaign.date_start, date_end: @campaign.date_end)
      flash[:success] = "Create success!"
      redirect_to admin_campaigns_path
    else
      flash.now[:danger] = "Create failed!"
      @campaigns = Campaign.all
      render 'admin/campaigns/index'
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    flash[:success] = "Delete success!"
    redirect_to admin_campaigns_path 
  end

  private
  def campaign_params
    params.require(:campaign).permit(:name, :sale_type, :amount, :date_start, :date_end,
                                    :numbers_of_use, :content)
  end
end
