class WorkersController < ApplicationController
  before_action :authenticate_user!

  def index
    @workers = Worker.all
  end

  def show
    @worker = Worker.find(params[:id])
    redirect_to :back, alert: 'Access denied.' unless @worker == current_user
  end
end
