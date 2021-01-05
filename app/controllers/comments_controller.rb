class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @property = Property.find(params[:property_id])
    @user = @property.user
    @comment = @property.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@property.nil? && @comment.save
      flash[:success] = "コメントを投稿しました！"
      if @user != current_user
        @user.notifications.create(property_id: @property.id, variety: 2,
                                   from_user_id: current_user.id,
                                   content: @comment.content)
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end


  def destroy
    @comment = Comment.find(params[:id])
    @property = @comment.property
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to property_url(@property)
  end
end
