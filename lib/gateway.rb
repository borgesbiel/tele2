require_relative 'bunny_connector'
require_relative 'mediator'

class Gateway
  conn = BunnyConnector.new
  ch   = conn.create_channel
  q    = ch.queue 'gateway_queue'

  begin
    puts ' [*] Gateway service ------'
    puts ' [*] Waiting for messages...'
    puts ' [*] To exit press CTRL+C'
    puts

    q.subscribe block: true do |_delivery_info, _properties, body|
      Mediator.send_message "#{body}"
    end
  rescue Interrupt => _
    conn.close

    exit(0)
  end
end
