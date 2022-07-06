class HomeController < ApplicationController
  def index
    render json: { name: 'Welcome', environment_api: ENV['environment_api'] }
  end
  def grettings
    render json: { grettings: I18n.t(:hello) }
  end
end
