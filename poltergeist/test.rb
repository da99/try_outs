
require 'capybara'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    :phantomjs_options => [
      "--ignore-ssl-errors=true",
      "--ssl-protocol=tlsv1"]
  })
end

# Capybara.javascript_driver = :poltergeist

session = Capybara::Session.new(:poltergeist)

# feature 'it works' do
  # scenario 'homepage' do
    session.visit('https://127.0.0.1:4568/')
    session.save_screenshot('/tmp/example.png')
  # end
# end
