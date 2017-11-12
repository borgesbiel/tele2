require_relative 'bunny_connector'

class Logger
  conn = BunnyConnector.new
  conn.start

  ch = conn.create_channel
  x  = ch.fanout "gateway_exchange"
  q  = ch.queue "logger_queue"
  q.bind(x)

  begin
    puts " [*] Logger ------"
    puts " [*] Waiting for messages."
    puts " [*] To exit press CTRL+C"
    puts

    q.subscribe block: true do |delivery_info, properties, body|
      puts " [x] #{body}"
    end
  rescue Interrupt => _
    conn.close

    exit(0)
  end
end
