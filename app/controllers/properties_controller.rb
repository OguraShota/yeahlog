class PropertiesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]
  
  def index
  end
  
  def new
    @property = Property.new
  end

  def show
    @property = Property.find(params[:id])
    @comment = Comment.new
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

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update_attributes(property_params)
      flash[:success] = "物件情報が更新されました！"
      redirect_to @property
    else
      render 'edit'
    end
  end

  def destroy
    @property = Property.find(params[:id])
    if current_user.admin? || current_user?(@property.user)
      @property.destroy
      flash[:success] = "物件が削除されました"
      redirect_to request.referrer == user_url(@property.user) ? user_url(@property.user) : root_url
    else
      flash[:danger] = "他人の物件は削除できません"
      redirect_to root_url
    end
  end

  private

    def property_params
      params.require(:property).permit(:name, :description, :reference, :recommend, :picture)
    end

    def correct_user
      # 現在のユーザーが更新対象の物件を保有しているかどうかの確認
      @property = current_user.properties.find_by(id: params[:id])
      redirect_to root_url if @property.nil?
    end
end
