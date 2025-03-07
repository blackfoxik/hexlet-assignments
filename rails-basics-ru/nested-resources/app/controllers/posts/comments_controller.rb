# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  def new
    @comment = PostComment.new
    @post = Post.find(params[:post_id])
  end

  def create
    post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.post = post

    if @comment.save
      redirect_to post, notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find params[:post_id]
    @comment = PostComment.find params[:id]
  end

  def update
    @post = Post.find params[:post_id]
    @comment = PostComment.find params[:id]
    if @comment.update(post_comment_params)
      redirect_to @post, notice: 'Comment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = PostComment.find params[:id]
    @comment.destroy

    redirect_to post_path(@post), notice: 'Comment was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
end
