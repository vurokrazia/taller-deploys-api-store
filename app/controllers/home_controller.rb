class HomeController < ApplicationController
  def index
    render json: { name: 'Welcome' }
  end
  def grettings
    render json: { grettings: I18n.t(:hello) }
  end
end
