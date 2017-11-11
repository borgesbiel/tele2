require 'bunny'
require_relative 'configuration'

class Gateway
  conn = Bunny.new
  conn.start

  ch = conn.create_channel
  q = ch.queue 'gateway_queue'

  begin
    puts ' [*] Gateway Intermediate service ------'
    puts ' [*] Waiting for messages...'
    puts ' [*] To exit press CTRL+C'

    q.subscribe block: true do |_delivery_info, _properties, body|
      send_message "Mediated: #{body}"
    end
  rescue Interrupt => _
    conn.close

    exit(0)
  end

  private

  def send_message data
    conn = Bunny.new
    conn.start

    ch = conn.create_channel
    ex = ch.fanout 'gateway_exchange'

    ex.publish data

    puts " [x] Mediating '#{data}'"

    conn.close
  end
end
