require "cuba"
require "rack/protection"

SPACES = 15
def sp k
  i = SPACES-k.length
  if i < 1
    ''
  else
    ' ' * i
  end
end

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.use Rack::Protection

Cuba.define do
  on get do
    on "hello" do
      res.write "Hello world!"
    end

    on root do
      res.write(env.inject("<code>\n") { |memo, (k, v)|
        if  k[/(server|host|name)/i]
          memo << "#{k}#{sp k} : #{v.inspect}\n"
        end
        memo
      } + '</code>')
    end
  end
end
