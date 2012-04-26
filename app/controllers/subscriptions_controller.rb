class SubscriptionsController < ApplicationController
  before_filter :check_for_subscription!, :except => [:index]
  def index
    @subscription = Subscription.find_by_user_id(current_user)
  end
  def new
    @subscription = Subscription.new
  end
  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to subscriptions_path, :alert => "Subscribed!"
    else
      render "new"
    end
  end 
  private
    def check_for_subscription!
      redirect_to subscriptions_path if Subscription.find_by_user_id(current_user).present?
    end
end
