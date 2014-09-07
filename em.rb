require 'em-http-request'

T = Time.now.to_f
Cache = {i: []}
LIMIT = 100
def get_time
  Cache[:i] << 1
  if Cache[:i].size >= LIMIT
    EventMachine.stop
  end
  Time.now.to_f - T
end

EventMachine.run {

  LIMIT.times do |i|
    http = EventMachine::HttpRequest.new('http://google.com/').get :query => {'keyname' => 'value'}

    http.errback { p 'Uh oh'; EM.stop }
    http.callback {
      p "#{http.response_header.status} #{i} #{get_time}"
    }
  end
}
