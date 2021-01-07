class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_search
    if logged_in?
      @search_word = params[:q][:name_cont] if params[:q]
      @q = current_user.feed.paginate(page: params[:page], per_page: 5).ransack(params[:q])
      @properties = @q.result(distinct: true)
    end
  end


  private
  #ログイン済みユーザーがどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:denger] = "ログインしてください"
      redirect_to login_url
    end
  end
end
