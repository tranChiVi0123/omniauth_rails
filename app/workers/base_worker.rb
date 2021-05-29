class BaseWorker
  include Sidekiq:Worker

  def perform(args)
    p "Hello Worker"
  end
end