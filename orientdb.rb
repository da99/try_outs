
get_cookie = <<-EOF
curl -c /tmp/cookie.txt http://root:D86BBEFFBDD82E2EEAC70C43169EEBE62F4410F48CEA81A28A5EC7D34B0223F8@localhost:2480/connect/GratefulDeadConcerts && cat /tmp/cookie.txt
EOF

user="root"
pswd="D86BBEFFBDD82E2EEAC70C43169EEBE62F4410F48CEA81A28A5EC7D34B0223F8"

cookies = {"OSESSIONID"=>"OS14100518875354175987230096333474", "Path"=>"%2F"}
cookies_txt = cookies.map { |k,v| "#{k}=#{v};"}.join(' ')

# ----------------------------

require 'net/http/persistent'
require 'benchmark'


begin
http = Net::HTTP::Persistent.new 'my_o'
uri = URI 'http://localhost:2480/class/GratefulDeadConcerts/Person'
http.headers['Cookie'] = cookies_txt

# r = http.request(uri)
# # puts r.methods.map(&:inspect).sort.join("\n")
# puts r.to_hash
# r.each { |k,v| puts "#{k}=#{v.inspect}"}
#
puts Benchmark.measure {
  100.times {
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
