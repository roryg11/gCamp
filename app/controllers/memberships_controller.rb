class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = @project.memberships.all
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project)
      flash[:notice] = "Member successfully saved."
    else
      redirect_to project_memberships_path(@project)
      flash[:notice] = "Member could not be saved."
    end
  end

  private
  def membership_params
    params.require(:membership).permit(
      :user_id,
      :project_id,
      :role
    )
  end
end
