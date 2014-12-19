class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  before_action do
    @project = Project.find(params[:project_id])
  end

  # GET /tasks
  # GET /tasks.json
  def index

    @tasks = @project.tasks.all

    if params[:complete] == "false"
      @tasks = @project.tasks.where(:complete => false)
    end

    if params[:order_by_desc] == "true"
      @tasks = @tasks.order(:description)
    end

    if params[:order_by_due_date] == "true"
      @tasks = @tasks.order(:due_date)
    end

    @today = Date.today
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to project_tasks_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_date, :complete, :project_id)
    end
end
