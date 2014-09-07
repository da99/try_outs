
# === the following is ok since this server is never 
# exposed to the public... or event turned on.
get_cookie = <<-EOF
curl -c /tmp/cookie.txt http://root:D86BBEFFBDD82E2EEAC70C43169EEBE62F4410F48CEA81A28A5EC7D34B0223F8@localhost:2480/connect/GratefulDeadConcerts && cat /tmp/cookie.txt
EOF

user="root"
pswd="D86BBEFFBDD82E2EEAC70C43169EEBE62F4410F48CEA81A28A5EC7D34B0223F8"

cookies = {"OSESSIONID"=>"OS1410056589824-6017226228821263965", "Path"=>"%2F"}
cookies_txt = cookies.map { |k,v| "#{k}=#{v};"}.join(' ')


require 'em-http-request'


counter = 0
limit = 50

time = Time.now.to_f
EventMachine.run {

  https = []
  i = 0
  limit.times do |i|
    # https[i] =
    http = EventMachine::HttpRequest.new('http://localhost:2480/class/GratefulDeadConcerts/Person').
      get(:head=>{'Cookie' => cookies_txt})
    https[i] = http
  # end

  # limit.times do |i|
    http.errback { p "Uh oh #{i}"; EM.stop }

    http.callback {
      # p http.response_header.status
      # p http.response_header
      # p http.response
      puts "#{http.response_header.status} - #{i} - #{counter}"
      counter += 1
      if counter >= limit
        EventMachine.stop 
        puts Time.now.to_f - time
      end
    }
  end
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
