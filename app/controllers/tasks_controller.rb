# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :authenticate_request
  before_action :authorize_admin, only: [:create, :assign]
  # before_action :find_task, only: [:assign, :complete]
  before_action :set_task, only: [:create, :update, :destroy]

  def create
  	debugger
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def assign
    if @current_user.admin?
      assignment = TaskAssignment.new(task: @task, user_id: params[:user_id], assigned_by: @current_user.id)
      if assignment.save
        render json: assignment, status: :ok
      else
        render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  def assigned
    tasks = @current_user.tasks
    render json: tasks, status: :ok
  end

  def complete
    if @task.users.include?(@current_user)
      @task.update(completed: true)
      render json: @task, status: :ok
    else
      render json: { error: 'Forbidden' }, status: :forbidden
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :completed, :created_by)
  end

  def find_task
    @task = Task.find(params[:id])
  end

   def set_task
    @task = Task.find(params[:id])
  end

  def authorize_admin
    render json: { error: 'Forbidden' }, status: :forbidden unless @current_user.admin?
  end
end
