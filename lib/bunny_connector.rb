require 'bunny'
require_relative 'configuration'

class BunnyConnector
  class << self
    def new
      conn = Bunny.new Configuration.rabbitmq_url
      conn.start
    rescue Exception => e
      puts "Exception: #{e.message}"
    end
  end
end
