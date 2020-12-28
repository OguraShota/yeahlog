class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @property = Property.find(params[:property_id])
    @user = @property.user
    current_user.favorite(@property)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @property = Property.find(params[:property_id])
    current_user.favorites.find_by(property_id: @property.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
