require 'drb/drb'

THREADS_COUNT = 4

DRB_SERVICES = THREADS_COUNT.times.map do |index|
  DRb.start_service
  DRbObject.new_with_uri("druby://0.0.0.0:#{8787 + index}")
end

def distributed_call(index)
  timeserver = DRB_SERVICES[index]
  timeserver.get_current_time
end

def run
  THREADS_COUNT.times.map do |index|
    Thread.new do
      puts distributed_call(index)
    end
  end.map(&:join)
end

loop do
  run
end
