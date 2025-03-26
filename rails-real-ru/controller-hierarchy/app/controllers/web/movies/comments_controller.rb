# frozen_string_literal: true

module Web::Movies
    class CommentsController < ApplicationController
      def index
        @comments = resource_movie.comments.order(created_at: :desc)
      end
  
      def new
        @comment = resource_movie.comments.new
      end
  
      def edit
        @comment = resource_movie.comments.find(params[:id])
      end
  
      def create
        @comment = resource_movie.comments.new(comment_params)
        if @comment.save
          redirect_to movie_comments_path(resource_movie), notice: 'Create success'
        else
          render :new, status: :unprocessable_entity
        end
      end
  
      def update
        @comment = resource_movie.comments.find(params[:id])
        if @comment.update(comment_params)
          redirect_to movie_comments_path(resource_movie), notice: 'Update success'
        else
          render :edit, status: :unprocessable_entity
        end
      end
  
      def destroy
        @comment = resource_movie.comments.find(params[:id])
        @comment&.destroy!
        redirect_to movie_comments_path(resource_movie), notice: 'Comment destroyed'
      end
  
      private
  
      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end