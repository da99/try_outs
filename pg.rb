
require 'sequel'
require 'benchmark'

DB = Sequel.connect ENV['DATABASE_URL']

puts Benchmark.measure {
  1000.times {
    DB['SELECT * FROM "0010_model" LIMIT 1'].all
  }
}
