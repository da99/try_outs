require 'watir-webdriver'
switches = ['--ignore-ssl-errors=yes', '--ssl-protocol=tlsv1']

browser = if ARGV.first && ARGV.first['phanto']
            Watir::Browser.new :phantomjs, :args => switches
          else
            Watir::Browser.new (ARGV.first || :firefox).to_sym
          end
browser.goto 'https://localhost:4568'

puts browser.title
browser.close

__END__

# require 'watir'
require 'watir-webdriver'
browser = Watir::Browser.new((ARGV.first && ARGV.first.to_sym) || :chrome)
browser.goto 'https://localhost:4568'

puts browser.title
browser.close
