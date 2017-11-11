require_relative 'bunny_connector'

class Mediator
  class << self
    def send_message data
      conn = BunnyConnector.new
      ch   = conn.create_channel

      ex   = ch.fanout 'gateway_exchange'
      ex.publish data

      puts " [x] Mediated:  #{data}"
      conn.close
    end
  end
end
