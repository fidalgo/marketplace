class WorkersController < ApplicationController
  before_action :authenticate_user!

  def index
    @workers = Worker.all
  end

  def skills_list
    if params[:query].present?
      render json: current_user.skills.where('name LIKE ?', "%#{params[:query]}%")
    else
      render json: current_user.skills_list
    end
  end

  def show
    @worker = Worker.includes(:skills).where('users.id = ?', params[:id]).first
  end

  def skills
    @worker = current_user
  end

  def update
    if current_user.update(worker_params)
      redirect_to workers_path, notice: 'Worker skills were successfully updated.'
    else
      render :skills
    end
  end


  private

  def worker_params
    params.require(:worker).permit(:name, :email, skills_list: [])
  end
end
