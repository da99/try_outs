
require "http/server"
require "da_server"
require "../src/www_server/Public_Files"

class Not_Found
  include HTTP::Handler
  def initialize
  end # def

  def call(ctx)
    code = ctx.response.status_code

    if !ctx.response.wrote_headers?
      ctx.response.status_code = 404
      ctx.response.content_type = "text/plain"
      ctx.response.print "404 NOT FOUND: #{ ctx.request.path.inspect  }"
      ctx.response.flush
      STDERR.puts ctx.response.output.inspect
    end
    return call_next(ctx)
  end # def
end # class

class Hello
  include HTTP::Handler
  def initialize
  end # def

  def call(context)
    # if false
      context.response.content_type = "text/plain"
      context.response.print "Hello world! The time is #{Time.local}"
      # call_next(context)
    # end
  end # def

end # === class

server = HTTP::Server.new([
  # HTTP::LogHandler.new,
  # DA_Server::No_Slash_Tail.new,
  # DA_Server::Secure_Headers.new,
  # Public_Files.new(["/tmp", "/Public"]),
  Hello.new,
  # Not_Found.new
])

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen

# DA_Server.new(
#   host: "0.0.0.0",
#   port: 8080,
#   user: "da",
#   handlers: [
#     # HTTP::LogHandler.new,
#     # DA_Server::No_Slash_Tail.new,
#     # DA_Server::Secure_Headers.new,
#     Public_Files.new(["/tmp", "/Public"])
#     # Not_Found.new
#   ]
# ).listen
