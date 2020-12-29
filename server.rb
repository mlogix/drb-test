require 'drb/drb'

class TimeServer
  def get_current_time
    puts "Invoked: (thread id: #{Thread.current.object_id}) "

    10000.times.each do |_|
      # NOOP
    end

    Time.now
  end
end

front = TimeServer.new
uri = "druby://0.0.0.0:8787"
DRb.start_service(uri, front)
DRb.thread.join
