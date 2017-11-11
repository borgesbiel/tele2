class Configuration
  def self.rabbitmq_url
    default_url
  end

  def self.default_url
    "amqp://guest:guest@localhost:5672"
  end
end
