class WorkersController < ApplicationController
  before_action :authenticate_user!

  def index
    @workers = Worker.all
  end

  def skills_list
    render json: Worker.find_name_by_match(params[:query])
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
