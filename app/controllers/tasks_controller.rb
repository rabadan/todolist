class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy]
  before_action :set_tasks, only: %i[index]

  def index
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: I18n.t('.task_created')
    else
      set_tasks
      render :index
    end
  end

  def update
    @task.is_closed = params[:is_closed].to_s == '1'
    if @task.save
      redirect_to tasks_path, notice: I18n.t('.task_created')
    else
      set_tasks
      render :index
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: I18n.t('.task_destroyed')
    else
      set_tasks
      render :index
    end
  end

  private

  def set_tasks
    @tasks = Task.where(is_closed: false).order(:created_at).all
    @closed_task  = Task.where(is_closed: true).order(updated_at: :desc).all
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:text, :is_closed)
  end
end
