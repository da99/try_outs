
# === Final:
#     OrientDB was put for the long-term.
#     Java requires more memory than PG and Ruby 2.1.2 combined.
#     Also, the HTTP vs Binary protocol was too much of a slow down
#     compared to Ruby + PG paster 200 async requests.



# === the following is ok since this server is never
# exposed to the public. The OrientDB server is also
# turned off when not being used by this script.
get_cookie = <<-EOF
curl -c /tmp/cookie.txt http://root:D86BBEFFBDD82E2EEAC70C43169EEBE62F4410F48CEA81A28A5EC7D34B0223F8@localhost:2480/connect/GratefulDeadConcerts && cat /tmp/cookie.txt
EOF
# ==================================================

user="root"
pswd="D86BBEFFBDD82E2EEAC70C43169EEBE62F4410F48CEA81A28A5EC7D34B0223F8"

cookies = {"OSESSIONID"=>"OS1410058525296-6337484251133599011", "Path"=>"%2F"}
cookies_txt = cookies.map { |k,v| "#{k}=#{v};"}.join(' ')


require 'em-http-request'


T = Time.now.to_f
Cache = {i: []}
LIMIT = 200
TIMES = []

def get_time
  Cache[:i] << 1
  if Cache[:i].size >= LIMIT
    EventMachine.stop
  end
  t = (Time.now.to_f - T)
  TIMES << t
  t
end

EventMachine.run {

  LIMIT.times do |i|
    http = EventMachine::HttpRequest.
      new('http://localhost:2480/class/GratefulDeadConcerts/Person').
      get(:head=>{'Cookie' => cookies_txt})

    http.errback { p 'Uh oh'; EM.stop }
    http.callback {
      # puts "#{http.response_header.status} #{i} #{get_time}"
      get_time
    }
  end
}

at_exit {
  puts "Highest: #{TIMES.sort.last}"
}

__END__
# ----------------------------

require 'net/http/persistent'
require 'benchmark'


begin
http = Net::HTTP::Persistent.new 'my_o'
uri = URI 'http://localhost:2480/class/GratefulDeadConcerts/Person'
http.headers['Cookie'] = cookies_txt

r = http.request(uri)
puts r.body
# # puts r.methods.map(&:inspect).sort.join("\n")
# puts r.to_hash
# r.each { |k,v| puts "#{k}=#{v.inspect}"}
#
puts Benchmark.measure {
  1000.times {
    r = http.request(uri)
  }
}

ensure
  puts 'HTTP persistent: shutdown...'
  http.shutdown
  puts 'Done.'
end

__END__
require 'curb'
require 'benchmark'

# client = RestClient.get( "http://#{user}:#{pswd}@localhost:2480/connect/GratefulDeadConcerts" )
# cookies = client.cookies
# puts cookies

c = Curl::Easy.new('http://localhost:2480/class/GratefulDeadConcerts/Person')
c.cookies= cookies_txt

puts Benchmark.measure {
  100.times {
    c.perform
  }
}

__END__
require 'orientdb_binary'

cmd = "http://root:#{pswd}localhost:2480/class/GratefulDeadConcerts/Person"

connection = OrientdbBinary::Connection.new(host: 'localhost', port: 2424)
server = connection.server(user: user, password: pswd)
database = server.database.new(name: 'GratefulDeadConcerts')

100.times {
  puts database.exists?
}
