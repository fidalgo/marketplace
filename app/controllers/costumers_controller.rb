class CostumersController < ApplicationController
  before_action :authenticate_user!

  def index
    @costumers = Costumer.all
  end

  def show
    @costumer = Costumer.find(params[:id])
    redirect_to :back, alert: 'Access denied.' unless @costumer == current_user
  end

  def search
  end

  def results
    @workers = Costumer.find_workers_by_skill_name(params[:skills])
  end
end
