class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @property = Property.find(params[:property_id])
    @user = @property.user
    @comment = @property.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@property.nil? && @comment.save
      flash[:success] = "コメントを投稿しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end


  def destroy
  end

end