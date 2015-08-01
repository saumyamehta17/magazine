class CommentsController < ApplicationController
  before_action :set_article
  before_filter :require_permission, only: :destroy

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
    respond_to do |format|
      format.js { }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.assign_attributes user: current_user, article: @article
    respond_to do |format|
      if @comment.save
        @comments =  @article.comments.arrange(order: 'created_at')
        format.js { }
      else
        format.js { render (@comment.root? ? :create : :new)}
      end
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    respond_to do |format|
      if @comment.childless? && @comment.destroy
        format.js { }
      else
        @comment.errors.add(:base,'Parent can not be delete if children exist.')
        format.js { }
      end
    end
    @comments =  @article.comments.arrange(order: 'created_at')
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def require_permission
    @comment = Comment.find(params[:id])
    if current_user != @comment.user
      @comment.errors.add(:base,'You are not authorized to delete comment.')
      render 'destroy.js.erb'
    end
  end

  def comment_params
    params.require(:comment).permit(:desc, :article_id, :user_id, :parent_id)
  end
end
