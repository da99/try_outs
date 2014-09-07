require 'fb'
include Fb
# The Database class acts as a factory for Connections.
# It can also create and drop databases.
db = Database.new(
:database => "localhost:/tmp/readme.fdb",
:username => 'sysdba',
:password => 'masterkey')
# :database is the only parameter without a default.
# Let's connect to the database, creating it if it doesn't already exist.
conn = db.connect rescue db.create.connect
# We'll need to create the database schema if this is a new database.
conn.execute("CREATE TABLE TEST (ID INT NOT NULL PRIMARY KEY, NAME VARCHAR(20))") if !conn.table_names.include?("TEST")
# Let's insert some test data using a parameterized query.  Note the use of question marks for place holders.
10.times {|id| conn.execute("INSERT INTO TEST VALUES (?, ?)", id, "John #{id}") }
# Here we'll conduct a spot check of the data we have just inserted.
ary = conn.query("SELECT * FROM TEST WHERE ID = 0 OR ID = 9")
ary.each {|row| puts "ID: #{row[0]}, Name: #{row[1]}" }
