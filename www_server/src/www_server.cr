
require "da_server"
require "./www_server/Public_Files"
require "./www_server/HTTP_Log"
require "./www_server/Not_Found"

server = DA_Server.new(
  host: "0.0.0.0",
  port: 4567,
  user: "da",
  handlers: [
    HTTP_Log.new,
    DA_Server::No_Slash_Tail.new,
    Public_Files.new(["/tmp", "/Public"]),
    Not_Found.new
  ]
)

server.listen
