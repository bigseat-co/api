class HomeController < ApplicationController
  def index
    render json: { success: true, message: 'Oh boi, we are live!' }
  end
end
