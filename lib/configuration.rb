class Configuration
  class << self
    def rabbitmq_url
      default_url
    end

    def default_url
      "amqp://guest:guest@rabbitmq:5672"
    end
  end
end
