
HTTP_Log = HTTP::LogHandler

# This is here in case you need custom
# log handler
class Custom_HTTP_Log
  include HTTP::Handler

  def initialize
  end # def

  def call(ctx)
    STDERR.puts "#{ctx.request.method} - #{ctx.request.path.inspect} - #{Time.local.to_s}"
    call_next(ctx)
  end # def
end # class
