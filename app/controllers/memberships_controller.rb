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
      redirect_to project_memberships_path(@project), notice: "Member successfully saved."
    else
      redirect_to project_memberships_path(@project), alert: @membership.errors.full_messages
    end
  end

  def edit
  end

  def update
    @membership = @project.memberships.find(params[:id])
    @membership.update(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project)
      flash[:notice] = "membership updated"
    else
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project)
    flash[:notice] = "membership successfully deleted"
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
