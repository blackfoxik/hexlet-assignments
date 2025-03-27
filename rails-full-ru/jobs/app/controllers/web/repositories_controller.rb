# frozen_string_literal: true

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
    repository = Repository.new(permitted_params)

    if repository.save
      RepositoryLoaderJob.perform_later(repository)
      redirect_to repositories_path, notice: 'The task will be done async'
    else
      flash[:notice] = t('fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    repository = Repository.find(params[:id])

    RepositoryLoaderJob.perform_later(repository)
    redirect_to repositories_path, notice: 'The task will be done async'
  end

  def update_repos
    repositories = Repository.order(updated_at: :asc)
    repositories.each do |repository|
      RepositoryLoaderJob.perform_later(repository)
    end
    redirect_to repositories_path, notice: 'The task will be done async'
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