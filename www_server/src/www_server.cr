
require "da_server"
require "./www_server/Public_Files"

class HTTP_Log
  include HTTP::Handler

  def initialize
  end # def

  def call(ctx)
    STDERR.puts "#{ctx.request.method} - #{ctx.request.path.inspect} - #{Time.local.to_s}"
    STDERR.puts ctx.response.status.inspect
    return call_next(ctx)
  end # def
end # class

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

server = DA_Server.new(
  host: "0.0.0.0",
  port: 4567,
  user: "da",
  handlers: [
    HTTP_Log.new,
    DA_Server::No_Slash_Tail.new,
    DA_Server::Secure_Headers.new,
    Public_Files.new(["/tmp", "/Public"]),
    Not_Found.new
  ]
)

server.listen
