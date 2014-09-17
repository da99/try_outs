
require "ashikawa-core"

database = Ashikawa::Core::Database.new do |config|
  config.url = "http://localhost:8529"
  config.database_name = 'my_db'
end

puts database.inspect
