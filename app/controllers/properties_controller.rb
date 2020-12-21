class PropertiesController < ApplicationController
  before_action :logged_in_user

  def new
    @property = Property.new
  end

  def show
    @property = Property.find(params[:id])
  end

  def create
    @property = current_user.properties.build(property_params)
    if @property.save
      flash[:success] = "物件が登録されました!"
      redirect_to property_path(@property)
    else
      render 'properties/new'
    end
  end

  private

    def property_params
      params.require(:property).permit(:name, :description, :reference, :recommend)
    end

end
