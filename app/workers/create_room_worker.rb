class CreateRoomWorker
  include Sidekiq::Worker

  def perform
    Room.create(name: 'Amazing room')
  end
end