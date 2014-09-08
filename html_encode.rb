
require 'escape_utils'
require 'htmlentities'
require 'benchmark'


CODER= HTMLEntities.new :xhtml1
HTML_ESCAPE_TABLE = {

  '&laquo;' => "&lt;",
  '&raquo;' => "&gt;",

  "&lsquo;" => "&apos;",
  "&rsquo;" => "&apos;",
  "&sbquo;" => "&apos;",

  "&lsquo;" => "&apos;",
  "&rsquo;" => "&apos;",

  "&ldquo;" => "&quot;",
  "&rdquo;" => "&quot;",
  "&bdquo;" => "&quot;",

  "&lsaquo;" => "&lt;",
  "&rsaquo;" => "&gt;",

  "&acute;" => "&apos;",
  "&uml;" => "&quot;",

  '\\' => "&#92;",
  '/' => "&#47;",
  # '%' => "&#37;",
  # ':' => '&#58;',
  # '=' => '&#61;',
  # '?' => '&#63;',
  # '@' => '&#64;',
  "\`" => '&apos;',
    '‘' => "&apos;",
    '’' => "&apos;",
    '“' => '&quot;',
    '”' => '&quot;',
    # "$" => "&#36;",
    # '#' => '&#35;', # Don't use this or else it will ruin all other entities.
    # '&' => # Don't use this " " " " " "
    # ';' => # Don't use this " " " " " "
    '|' => '&brvbar;',
    '~' => '&sim;'
  # '!' => '&#33;',
  # '*' => '&lowast;', # Don't use this. '*' is used by text formating, ie RedCloth, etc.
  # '{' => '&#123;',
  # '}' => '&#125;',
  # '(' => '&#40;',
  # ')' => '&#41;',
  # "\n" => '<br />'
}

CHARS = /(#{HTML_ESCAPE_TABLE.keys.map {  |s| Regexp.escape s }.join('|')})/

partial = <<-EOF
 <p> @ / here is some random content : erer8934398 & & / //  ©</p>
EOF

html = partial * 100


def my_encode str
  EscapeUtils.escape_html(str).gsub(CHARS) { |s|
    HTML_ESCAPE_TABLE[s]
  }
end

puts EscapeUtils.escape_html(partial)
puts Benchmark.measure {
  1000.times {
    EscapeUtils.escape_html html
  }
}

puts my_encode(partial)
puts Benchmark.measure {
  1000.times {
    my_encode html
  }
}

puts CODER.encode(partial, :named, :hexadecimal)
puts Benchmark.measure {
  1000.times {
    CODER.encode html, :named, :hexadecimal
  }
}




