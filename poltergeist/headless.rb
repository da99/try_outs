
require 'watir'
require 'watir-webdriver'
require 'headless'

headless = Headless.new
headless.start

browser = Watir::Browser.new :firefox
browser.goto 'https://localhost:4568'
puts browser.title
browser.close

at_exit {
  puts "=== destroying headless"
  headless.destroy
}
