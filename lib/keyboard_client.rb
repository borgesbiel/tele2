require 'bunny'
require 'rubygems'
require 'eventmachine'
require_relative 'configuration'
require_relative 'bunny_connector'

class KeyboardClient
  module MyKeyboardHandler
    include EM::Protocols::LineText2

    def receive_line data
      conn = BunnyConnector.new
      ch   = conn.create_channel
      q    = ch.queue 'gateway_queue'

      ch.default_exchange.publish data, routing_key: q.name, persistent: true
      puts " [x] Keyboard Sent: #{data}"

      conn.close
    end
  end

  EM.run do
    puts ' [*] Keyboard client service ------'
    puts ' [*] Type text and press Enter to send a message'
    puts ' [*] To exit press CTRL+C'
    puts

    EM.open_keyboard MyKeyboardHandler
  end
end
