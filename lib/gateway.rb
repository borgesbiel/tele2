require 'bunny'
require_relative 'configuration'
require_relative 'bunny_connector'

def send_message data
  conn = BunnyConnector.new
  ch   = conn.create_channel

  ex   = ch.fanout 'gateway_exchange'
  ex.publish data

  puts " [x] Mediated:  #{data}"
  conn.close
end

conn = BunnyConnector.new
ch   = conn.create_channel
q    = ch.queue 'gateway_queue'

begin
  puts ' [*] Gateway service ------'
  puts ' [*] Waiting for messages...'
  puts ' [*] To exit press CTRL+C'
  puts

  q.subscribe block: true do |_delivery_info, _properties, body|
    send_message "#{body}"
  end
rescue Interrupt => _
  conn.close

  exit(0)
end
