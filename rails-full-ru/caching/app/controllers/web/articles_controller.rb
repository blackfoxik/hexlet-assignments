# frozen_string_literal: true

class Web::ArticlesController < Web::ApplicationController
  caches_action :show

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end