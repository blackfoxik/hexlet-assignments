# frozen_string_literal: true

require 'octokit'

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    @repository = Repository.new(permitted_params)

    if @repository.save
      params = Web::RepositoryDataBuilderService.new.build(@repository.link)
      @repository.update!(params)

      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end