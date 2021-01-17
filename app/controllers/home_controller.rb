class HomeController < ApplicationController
  def index
    render json: { success: true, message: 'Oh boi, we are live!', rooms_count: Room.count }
  end
end
