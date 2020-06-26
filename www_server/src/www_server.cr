
require "da_server"
require "./www_server/Public_Files"


class Not_Found
  include HTTP::Handler
  def initialize
  end # def

  def call(ctx)
    file_path = File.join(Dir.current, "/Public/404.html")
    ctx.response.status_code = 404
    ctx.response.content_type = DA_Server.mime(file_path)
    ctx.response.content_length = File.size(file_path)
    File.open(file_path) do |file|
      IO.copy(file, ctx.response)
    end
  end # def
end # class

server = DA_Server.new(
  host: "0.0.0.0",
  port: 4567,
  user: "da",
  handlers: [
    DA_Server::No_Slash_Tail.new,
    DA_Server::Secure_Headers.new,
    Public_Files.new(["/tmp", "/Public"]),
    Not_Found
  ]
)

server.listen
