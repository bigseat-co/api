Sidekiq::Cron::Job.create(
  name: 'CreateRoomWorker - every 5min',
  cron: '*/5 * * * *',
  class: 'CreateRoomWorker'
)
