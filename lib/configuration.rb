class Configuration
  class << self
    def rabbitmq_url
      default_url
    end

    def default_url
      "amqp://guest:guest@localhost:5672"
    end
  end
end
