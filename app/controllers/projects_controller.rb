class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project=Project.new
  end

  def create
    @project=Project.new(project_params)
    if @project.save
      flash[:notice] = "Project was successfully created"
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project=Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
    flash[:notice] = "Project successfully deleted"
  end

  private
  def project_params
    params.require(:project).permit(
      :name
    )
  end

end
